function [  ] = plot_video_FBF( G_DATA, DATA_FRAMES, AGENTS_DATA, matPOSITIONS, COHESION_DATA, nFRAMES, nAGENTS, videoDIR, curClipFrameSet, mFACTOR, videoOUT, videoTYP, vNULL )
    
    %% Output video definitions
    videoName = ['results\' videoOUT '\' videoOUT '.' videoTYP];

    
    %% Video object definitions
    writerObj = VideoWriter(videoName);
    writerObj.FrameRate = 5;
    open(writerObj);
    
    
    %% Getting agents' information frame by frame
    [ NRO ] = get_info_groups_frames( G_DATA, DATA_FRAMES, AGENTS_DATA, nFRAMES, vNULL );
    
    
    %% Plot the information frame by frame
    for frame = 1 : (nFRAMES - 1)
        
        % Getting the current frame
        curFrame = im2double(imread([videoDIR '\' curClipFrameSet(frame).name]));
        
        % Create a figure
        img = figure;
        
        % Area to show the information
        areaCurFrame = size(curFrame);
        area_add = 40;
        [ new_area ] = concatena_area ( curFrame, area_add );

        curFrame = vertcat ( curFrame, new_area );  
        
        % Show the current frame
        hold off
        imshow(curFrame);
        hold on
        
        % Plot the agents 'alone' (no groups)
        nAG_NoGroup = size(NRO(frame).curAgNoGroupsID, 2);

        for A = 1 : nAG_NoGroup

            nogroups(A, 1) = matPOSITIONS(frame).curPOS( NRO(frame).curAgNoGroupsID(A) ).NOR(1,1);
            nogroups(A, 2) = matPOSITIONS(frame).curPOS( NRO(frame).curAgNoGroupsID(A) ).NOR(1,2);

        end

        if ( nAG_NoGroup > 0 )

            scatter(nogroups(:,1),nogroups(:,2), 35, 'y', 'filled', 'o');

        end

        nogroups = [];

        % Number of groups
        nGROUPS = DATA_FRAMES(frame).total_groups;
        
        % Plot the group's information
        for G = 1 : nGROUPS
            
            % Number of people in the group
            nAG = DATA_FRAMES(frame).data(G).nro_pessoas;
            
            if (nAG > 0)
            
                curTYPE = DATA_FRAMES(frame).data(G).type;

                % Get the current group COHESION
                curCOHESION = COHESION_DATA(frame).group(G).group_cohesion;

                % Get the current group CENTROID
                curCENTROID = DATA_FRAMES(frame).data(G).centroid;

                plot_cohesion( curCOHESION, curCENTROID, curTYPE);

                % Plot the goup
                if ( curTYPE == 'V' )

                     plot_permanent_group( DATA_FRAMES, matPOSITIONS, nAG, frame, G );

                elseif ( curTYPE == 'I' )

                     plot_temporary_group( DATA_FRAMES, matPOSITIONS, nAG, frame, G );

                else

                    % plot_possible_group( DATA_FRAMES, matPOSITIONS, nAG, frame, G );

                end
                
            end
            
        end
        
        % Plot the agent's ID
        % plot_agent_id ( matPOSITIONS, nAGENTS, frame, vNULL );
        
        % Plot the scale
        plot_scale ( mFACTOR );

        % Plot the title
        plot_title ( frame, NRO(frame).curAgents, NRO(frame).curGroups );

        % Plot the subtitle
        plot_subtitle ( areaCurFrame, area_add, NRO(frame).curPermGroups, NRO(frame).curTempGroups, NRO(frame).curAgNoGroups );
        
        % Write the video file
        video_frame = getframe( img );
        writeVideo( writerObj, video_frame );
        close all        
        
    end
    
end

