function [  ] = plot_possible_group( DATA_FRAMES, matPOSITIONS, nAG, frame, G )
    
    temp = [];
    
    for A = 1 : nAG
                        
        temp(A, 1) = matPOSITIONS(frame).curPOS( DATA_FRAMES(frame).data(G).group(A) ).NOR(1,1);
        temp(A, 2) = matPOSITIONS(frame).curPOS( DATA_FRAMES(frame).data(G).group(A) ).NOR(1,2);

    end
    
    CENTROID = DATA_FRAMES(frame).data(G).centroid;
    
    scatter(temp(:,1),temp(:,2), 30, 'y', 'filled', 'o');
    % scatter(CENTROID(1),CENTROID(2), 1, 'y', 'filled', 'o');

    for A = 1 : nAG
        
        % line([CENTROID(1), temp(A,1)], [CENTROID(2), temp(A,2)], 'color', 'y', 'LineWidth', 0.8);
        
    end
    
    % msg = [ 'G' num2str(DATA_FRAMES(frame).data(G).groupID) ];
    
    % text(CENTROID(1), CENTROID(2), msg, 'color', 'w', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
     
end

