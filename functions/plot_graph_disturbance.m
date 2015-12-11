function [  ] = plot_graph_disturbance( matDISTURBANCES, matDISTANCES, G_DATA, videoDIR, videoOUT, nFRAMES, vNULL )
    
    % Number of groups
    nGROUPS = size( G_DATA, 2 );

    for frame = 1 : nFRAMES
        
        %% Agents disturbance
        val = mean(matDISTURBANCES(frame).curDIS.level(matDISTURBANCES(frame).curDIS.level > 0));
        
        if (isnan(val))
            
            val = 0;
            
        end
        
        dist_AGENTS(frame) = val;
        
        
        %% Groups disturbance
        for G = 1 : nGROUPS
            
            nro_pessoas = G_DATA(G).nro_pessoas;
            tam = size( G_DATA(G).frames, 2);
            tempVAR = [];
            
            for r = 1 : tam
                
                if (G_DATA(G).frames(r) == frame)
                    
                    for d = 1 : nro_pessoas
                        
                        tempVAR = [tempVAR, matDISTURBANCES(frame).curDIS.level( G_DATA(G).group(d) )];
                        
                    end
                    
                end
                
            end
            
            vv = mean(tempVAR(tempVAR>0));
       
            if (isnan(vv))
                vv = 0;
            end

            dist_GROUPS(frame) = vv;
            
        end
        
        
        %% Neighbors disturbance
        temp_dist_NEIGHBORS = [];
        
        for G = 1 : nGROUPS
            
            nro_pessoas = G_DATA(G).nro_pessoas;
            tam = size( G_DATA(G).frames, 2);
            tempVAR = [];
            
            for r = 1 : tam
                
                if (G_DATA(G).frames(r) == frame)
                    
                    for d = 1 : nro_pessoas
                        
                        ag = G_DATA(G).group(d);
                        a = min( matDISTANCES(frame).curDIS( ag, matDISTANCES(frame).curDIS( ag, :) > 0 ) );
                        XX = matDISTANCES(frame).curDIS( ag, : );
                        uu = min( XX( XX > a ) );
                        neighbor = find ( XX == uu, 1 );
                        tempVAR = [tempVAR, matDISTURBANCES(frame).curDIS.all( ag, neighbor )];
                        
                    end
                    
                end
                
            end
            
            tempNEIG = mean( tempVAR( tempVAR > 0 ) );
            
            if (isnan(tempNEIG))
                tempNEIG = 0;
            end
            
            temp_dist_NEIGHBORS = [ temp_dist_NEIGHBORS, tempNEIG ];
            
        end
        
        gg = mean( temp_dist_NEIGHBORS( temp_dist_NEIGHBORS > 0 ) );
        
        if ( isnan( gg ) )
            gg = 0;
        end
        
        dist_NEIGHBORS(frame) = gg;

    end
    
    %% Formating disturbance data
    disturbance.all = [];
    disturbance.groups = [];
    disturbance.neighbors = [];

    for ff = 1 : nFRAMES
        disturbance.all = [ disturbance.all, dist_AGENTS(ff) ];
        disturbance.groups = [ disturbance.groups, dist_GROUPS(ff) ];
        disturbance.neighbors = [ disturbance.neighbors, dist_NEIGHBORS(ff) ];
    end
    
    % Creating a figure and setting up the properties
    img = gcf;
    img.PaperUnits = 'inches';
    img.PaperPosition = [1 1 10 5];
    img.PaperPositionMode = 'manual';
    
    % Ploting the graph
    x = 1 : nFRAMES;
    handle = plot ( x, disturbance.all, 'r-', x, disturbance.groups, 'b-', x, disturbance.neighbors, 'g-' );
    set(handle,'LineWidth',1.2);
    title( [ 'Disturbances by Frame (' videoOUT ')' ] );
    legend( 'Agents', 'Groups', 'Neighbors', 1 );
    xlabel( 'Frames' );
    ylabel( 'Disturbance level (mean)' );
    
    % Saving the figure
    saveas( img, ['results\' videoOUT '\' videoOUT '-DISTURBANCE-GRAPH.jpg'] );
    
    % Closing the figure
    close(img);
    
end

