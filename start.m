%% Group detection %%


%% Cleaning up the environment
clear; clc; close all


%% Display a message
msg = [ 'STARTING' ];
disp(msg)


%% Setting up directories and variables

% Path
addpath( 'functions\' );

% Video configurations
videoDIR = 'videos\video34\';
videoOUT = 'video-0034';
videoTYP = 'avi';

% Trajectory files
trajectoryNOR = 'CollectivenessN';
trajectoryPER = 'CollectivenessD';
trackNameNOR = [ videoDIR trajectoryNOR '_filtered' '.txt' ];
trackNamePER = [ videoDIR trajectoryPER '_filtered' '.txt' ];

% NULL value
vNULL = -666;

% Frame Set
curClipFrameSet = dir( [ videoDIR '*.jpg' ] );

% Video resolution
RESOLUTION = size( im2double ( imread ( [videoDIR '\' curClipFrameSet(1).name] ) ) );


%% Trajectory smoothness
trajectory_smoothness( videoDIR, trajectoryNOR, 'txt', 9, 'N' );
trajectory_smoothness( videoDIR, trajectoryPER, 'txt', 9, 'D' );


%% Reading tracks
[ trackPER, mFACTOR ] = readTraksPER(trackNamePER);
[ trackNOR ] = readTraksNOR(trackNameNOR);


%% Setting up the desired velocity
desiredVEL = 0.8 * mFACTOR;


%% Reading trajectory paths
pathsNOR = read_normal_paths ( trackNOR );
pathsPER = read_perspective_paths ( trackPER );


%% Getting the number of frames
nFRAMES = max ( pathsPER ( :, 5 ) );


%% Setting up the T level (% of frames for temporary groups)
T_level = 18;
P_level = 55;
N_level = 35;


%% Getting the number of agents
nAGENTS = max ( pathsPER( :, 6 ) );


%% Creating the directory to write the results
if ( exist( ['results\' videoOUT] ) ~= 7 )
    mkdir( ['results\' videoOUT] );
end


%% Get initial data
[ dataAGENTS ] = get_initial_data ( pathsNOR, pathsPER, nFRAMES, nAGENTS, vNULL );


%% Display a message
msg = [ 'READING THE FRAMES' ];
disp(msg)


%% Video Processing
for frame = 1 : nFRAMES
    
    %% Read the current frame
    curFrame = im2double ( imread ( [videoDIR '\' curClipFrameSet(frame).name] ) );
    HIGHT = size ( curFrame, 1 );
    
    
    %% Get positions
    [ curPOSITION ] = get_positions ( dataAGENTS, nAGENTS, frame );
    matPOSITIONS( frame ).curPOS = curPOSITION;
    
    
    %% Get velocities (vector)
    [ curVELOCITY_VEC ] = get_velocities_vec( dataAGENTS, nAGENTS, frame );
    matVELOCITIES_VEC( frame ).curVEL = curVELOCITY_VEC;
    
    
    %% Get velocities
    [ curVELOCITY ] = get_velocities( curVELOCITY_VEC, nAGENTS, mFACTOR, vNULL );
    matVELOCITIES( frame ).curVEL = curVELOCITY;
    
    
    %% Get the velocity (pixel/frame)
    [ curVELOCITY_MEAN ] = get_mean_velocities ( dataAGENTS, curPOSITION, nAGENTS, frame, vNULL );
    matVELOCITY_MEAN( frame ).curVEL = curVELOCITY_MEAN;
    
    
    %% Get angles
    [ curANGLE ] = get_angles( dataAGENTS, curPOSITION, matPOSITIONS, nAGENTS, frame, vNULL );
    matANGLES( frame ).curANG = curANGLE;
    
    
    %% Get distances
    [ curDISTANCE ] = get_distances( curPOSITION, nAGENTS, mFACTOR, vNULL );
    matDISTANCES( frame ).curDIS = curDISTANCE;
    
    
    %% Get distances STD
    [curDISTANCE_STD] = get_distances_std ( dataAGENTS, matDISTANCES, nAGENTS, frame, vNULL );
    matDISTANCES_STD( frame ).curDIS = curDISTANCE_STD;
    
    
    %% Get colectivity and disturbance
    [ curCOLECTIVITY, curDISTURBANCE, curANGULAR_VAR, DATA ] = get_colectivities( curPOSITION, curVELOCITY_VEC, curVELOCITY, desiredVEL, curDISTANCE, mFACTOR, nAGENTS, frame, vNULL );
    matCOLECTIVITIES( frame ).curCOL = curCOLECTIVITY;
    matDISTURBANCES( frame ).curDIS = curDISTURBANCE;
    matANGULAR_VAR( frame ).curANG = curANGULAR_VAR;
    trkDATA( frame ).data = DATA;
    
    
    %% Finding groups
    [ curGROUPS ] = get_groups ( curFrame, dataAGENTS, curVELOCITY, curPOSITION, curDISTANCE, curDISTANCE_STD, curANGLE, mFACTOR, nAGENTS, frame, vNULL );
    GROUPS( frame ).curGROUPS = curGROUPS;
    
    
    %% Display a message
    msg = [ 'Reading frame: ' num2str( frame ) ];
    disp(msg)
    
end

%% Display a message
msg = [ 'PROCESSING DATA (Be patient, please!)' ];
disp(msg)


%% Getting the group data
[ G_DATA, DATA ] = getting_group_data ( GROUPS, T_level, P_level, N_level, nFRAMES, vNULL );


%% Display a message
msg = [ '[...]' ];
disp(msg)


%% Getting agents data
[ AGENTS_DATA ] = get_agents_data ( G_DATA, DATA, matPOSITIONS, nFRAMES, nAGENTS, vNULL );


%% Create de XML file for 3D visualization
create_visu3d_file ( videoOUT, AGENTS_DATA, nFRAMES, nAGENTS, mFACTOR, HIGHT, vNULL );


%% Display a message
msg = [ '[...]' ];
disp(msg)


%% Getting all the group information frame by frame
[ DATA_FRAMES ] = get_all_frame_by_frame ( G_DATA, nFRAMES, T_level, P_level, matPOSITIONS, nAGENTS, mFACTOR, vNULL );


%% Display a message
msg = [ '[...]' ];
disp(msg)


%% Getting all the group information frame by frame 2
[ DATA_FRAMES2 ] = get_all_frame_by_frame2 ( G_DATA, DATA, nFRAMES, T_level, P_level, matPOSITIONS, nAGENTS, mFACTOR, vNULL );


%% Calculate the group's cohesion
[ COHESION_DATA ] = calculate_cohesion ( DATA_FRAMES2, matANGLES, matVELOCITIES, nFRAMES );


%% Display a message
msg = [ '[...]' ];
disp(msg)


%% Create de XML and TXT files for groups
[ REL_DATA ] = create_group_files ( G_DATA, COHESION_DATA, matPOSITIONS, matVELOCITIES, matDISTANCES, matANGLES, matANGULAR_VAR, matCOLECTIVITIES, matDISTURBANCES, videoOUT, RESOLUTION, nFRAMES, nAGENTS, mFACTOR );


%% Create the TXT file for sumarization
create_sumarization_file ( G_DATA, AGENTS_DATA, DATA_FRAMES2, trkDATA, matDISTANCES, matVELOCITIES, matCOLECTIVITIES, matDISTURBANCES, COHESION_DATA, mFACTOR, videoOUT, nFRAMES );


%% Display a message
msg = [ '[...]' ];
disp(msg)


%% Calculate the group's relevance
[ RELEVANCE, dados_STD ] = calculate_relevance ( REL_DATA, videoOUT );


%% Display a message
msg = [ 'GENERATING VIDEO' ];
disp(msg)


%% Ploting the video frame by frame
plot_video_FBF ( G_DATA, DATA_FRAMES2, AGENTS_DATA, matPOSITIONS, COHESION_DATA, nFRAMES, nAGENTS, videoDIR, curClipFrameSet, mFACTOR, videoOUT, videoTYP, vNULL );


%% Ploting the disturbance's graphic
plot_graph_disturbance ( matDISTURBANCES, matDISTANCES, G_DATA, videoDIR, videoOUT, nFRAMES, vNULL );


%% Ploting the cohesion's graphic
plot_graph_cohesion ( COHESION_DATA, DATA_FRAMES2, G_DATA, videoDIR, videoOUT, nFRAMES, vNULL );


%% Display a message
msg = [ 'ALL DONE - Enjoy it!' ];
disp(msg)


%% Cleaning up the environment
clear; clc; close all
