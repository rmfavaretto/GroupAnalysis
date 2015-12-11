function [  ] = plot_final_video( G_DATA, AGENTS_DATA, matPOSITIONS, nFRAMES, nAGENTS, videoDIR, curClipFrameSet, mFACTOR, videoOUT, videoTYP, RELEVANCE, dados_STD, vNULL )
    
    %% Output video definitions
    videoName = ['results\' videoOUT '\' videoOUT '.' videoTYP];

    
    %% Video object definitions
    writerObj = VideoWriter(videoName);
    writerObj.FrameRate = 5;
    open(writerObj);
    
    
    %% Number of groups
    nGROUPS = size( G_DATA , 2 );
        
    
    %% Getting agents' information frame by frame
    [ NRO ] = get_info_groups_frames( G_DATA, AGENTS_DATA, nFRAMES, vNULL );
    
    
    %% Plot the information frame by frame
    for frame = 1 : nFRAMES
        
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
        
        % Plot the group's information
        for G = 1 : nGROUPS
            
            if ( find (G_DATA(G).frames( G_DATA(G).frames == frame ) ) )
                
                if ( G_DATA(G).type == 'V' )
                    
                    % Plot the group as permanent
                    nAG = G_DATA(G).nro_pessoas;
                    
                    for A = 1 : nAG
                        
                        temp(A, 1) = matPOSITIONS(frame).curPOS( G_DATA(G).group(A) ).NOR(1,1);
                        temp(A, 2) = matPOSITIONS(frame).curPOS( G_DATA(G).group(A) ).NOR(1,2);
                        
                    end
                    
                    [~, C] = kmeans(temp,1);

                    plot_relevance_all (RELEVANCE(G), C(1), C(2), 'r');
                    
                    scatter(temp(:,1),temp(:,2), 30, 'r', 'filled', 'o');
                    scatter(C(1),C(2), 1, 'r', 'filled', 'o');
                    
                    for A = 1 : nAG
                        line([C(1), temp(A,1)], [C(2), temp(A,2)], 'color', 'r', 'LineWidth', 0.8);
                    end
                    msg = [ 'G' num2str(G) ];
                    text(C(1), C(2), msg, 'color', 'w', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
                    
                    temp = [];
                    
                else
                    
                    % Plot the group as temporary
                    nAG = G_DATA(G).nro_pessoas;
                    
                    for A = 1 : nAG
                        
                        temp(A, 1) = matPOSITIONS(frame).curPOS( G_DATA(G).group(A) ).NOR(1,1);
                        temp(A, 2) = matPOSITIONS(frame).curPOS( G_DATA(G).group(A) ).NOR(1,2);
                        
                    end
                    
                    [~, C] = kmeans(temp,1);

                    plot_relevance_all (RELEVANCE(G), C(1), C(2), 'b');
                    
                    scatter(temp(:,1),temp(:,2), 30, 'b', 'filled', 'o');
                    scatter(C(1),C(2), 1, 'b', 'filled', 'o');
                    
                    for A = 1 : nAG
                        line([C(1), temp(A,1)], [C(2), temp(A,2)], 'color', 'b', 'LineWidth', 0.8);
                    end
                    msg = [ 'G' num2str(G) ];
                    text(C(1), C(2), msg, 'color', 'w', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
                    
                    temp = [];
                    
                end
                
            end
            
        end
        
        % Plot the agents 'alone' (no groups)
        nAG_NoGroup = size(NRO(frame).curAgNoGroupsID, 2);
        
        for A = 1 : nAG_NoGroup
                        
            nogroups(A, 1) = matPOSITIONS(frame).curPOS( NRO(frame).curAgNoGroupsID(A) ).NOR(1,1);
            nogroups(A, 2) = matPOSITIONS(frame).curPOS( NRO(frame).curAgNoGroupsID(A) ).NOR(1,2);

        end
        
        scatter(nogroups(:,1),nogroups(:,2), 35, 'y', 'filled', 'o');
        
        nogroups = [];
        
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
    
    
    %% Closing the video object
    close(writerObj);
    
    
end

