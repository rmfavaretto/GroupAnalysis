function [  ] = plot_positions ( curPOSITION, nAGENTS, vNULL )
    
    for A = 1 : nAGENTS
        
        if (curPOSITION(A).NOR(1,1) ~= vNULL)
            
            % Position
            scatter(curPOSITION(A).NOR(1, 1), curPOSITION(A).NOR(1, 2), 30, 'r', 'filled', 'o');
            
            % ID
            text(curPOSITION(A).NOR(1, 1), (curPOSITION(A).NOR(1, 2) - 5) , num2str(A), 'color', 'w', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
            
        end
        
    end
    
end

