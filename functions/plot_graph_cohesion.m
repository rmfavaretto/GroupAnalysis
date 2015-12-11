function [  ] = plot_graph_cohesion ( COHESION_DATA, DATA_FRAMES, G_DATA, videoDIR, videoOUT, nFRAMES, vNULL )
    
    %% COHESION DATA - FRAME BY FRAME

    for frame = 1 : nFRAMES
        
        cur_groups = DATA_FRAMES(frame).total_groups;
        
        temp_var = [];
        
        for GG = 1 : cur_groups
            
            if ( COHESION_DATA(frame).group(GG).group_cohesion ~= -1 )
                
                temp_var = [ temp_var COHESION_DATA(frame).group(GG).group_cohesion ];
                
            end
            
        end
        
        mean_cohesion(frame) = abs( mean( temp_var ) );
        
    end
    
    % Creating a figure and setting up the properties
    cohesion_by_frame = gcf;
    cohesion_by_frame.PaperUnits = 'inches';
    cohesion_by_frame.PaperPosition = [1 1 10 5];
    cohesion_by_frame.PaperPositionMode = 'manual';
    
    % Ploting the graph
    x = 1 : nFRAMES;
    handle = plot ( x, mean_cohesion, 'r-' );
    set(handle,'LineWidth',1.2);
    title( [ 'Mean Groups Cohesion by Frame (' videoOUT ')' ] );
    legend( 'Mean Cohesion', 1 );
    xlabel( 'Frames' );
    ylabel( 'Cohesion level (mean)' );
    
    % Saving the figure
    saveas( cohesion_by_frame, ['results\' videoOUT '\' videoOUT '-COHESION-GROUPSBYFRAME-GRAPH.jpg'] );
    
    % Closing the figure
    close(cohesion_by_frame);
    
    
    %% COHESION DATA BY GROUP
    
    % Number of groups
    nGROUPS = size( G_DATA, 2 );

    for G = 1 : nGROUPS
        
        temp_var = [];

        for F = 1 : nFRAMES

            cur_G = size ( COHESION_DATA(F).group, 2 );

            for GG = 1 : cur_G

                if ( COHESION_DATA(F).group(GG).id == G )
                    
                    if ( COHESION_DATA(F).group(GG).group_cohesion ~= -1 )

                        temp_var = [ temp_var COHESION_DATA(F).group(GG).group_cohesion ];
                        
                    end

                end

            end

        end
        
        mean_cohesion = abs( mean( temp_var( temp_var > 0 ) ) );
        
        if ( isnan( mean_cohesion ) )
            
            mean_cohesion = 0;
            
        end
        
        cohesion_group(G) = mean_cohesion;
        
    end
    
    % Creating a figure and setting up the properties
    cohesion_groups = gcf;
    cohesion_groups.PaperUnits = 'inches';
    cohesion_groups.PaperPosition = [1 1 10 5];
    cohesion_groups.PaperPositionMode = 'manual';
    
    % Ploting the graph
    handle = bar ( cohesion_group );
    set(handle,'LineWidth',1.2);
    title( [ 'Mean Groups Cohesion (' videoOUT ')' ] );
    xlabel( 'Groups' );
    ylabel( 'Cohesion level (mean)' );
    
    % Saving the figure
    saveas( cohesion_groups, ['results\' videoOUT '\' videoOUT '-COHESION-GROUS-GRAPH.jpg'] );
    
    % Closing the figure
    close(cohesion_groups);
    
end

