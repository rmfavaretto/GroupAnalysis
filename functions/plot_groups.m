function [  ] = plot_groups ( G_DATA, curClipFrameSet, videoDIR, videoOUT, videoTYP, nFRAMES, mFACTOR )
    
    % Output video definitions
    videoName = ['results\' videoOUT '\' videoOUT '.' videoTYP];

    % Video object definitions
    writerObj = VideoWriter(videoName);
    writerObj.FrameRate = 5;
    open(writerObj);
    
    % Number of groups
    qtdGrupos = size( G_DATA , 2 );

    for frame = 1 : nFRAMES
        
        % Getting the current frame
        curFrame = im2double(imread([videoDIR '\' curClipFrameSet(frame).name]));
        
        %% Create a figure
        img = figure;
        
        %% Area to show information
        areaCurFrame = size(curFrame);
        area_add = 40;
        [ new_area ] = concatena_area ( curFrame, area_add );

        curFrame = vertcat ( curFrame, new_area );  

        hold off
        imshow(curFrame);
        hold on
        
        for grupo = 1 : qtdGrupos
            
            
            
        end
        
        groups = 222;
        permanent = 222;
        temporary = 222;
        no_groups = 222;
        curAGENTS = 222;
        
        %% Plot the scale
        plot_scale ( mFACTOR );

        %% Plot the title
        plot_title ( frame, curAGENTS, groups );

        %% Plot the subtitle
        plot_subtitle ( areaCurFrame, area_add, permanent, temporary, no_groups );
        
        %% Write the video file
        video_frame = getframe( img );
        writeVideo( writerObj, video_frame );
        close all
        
    end
    
    %% Closing the video object
    close(writerObj);

end

