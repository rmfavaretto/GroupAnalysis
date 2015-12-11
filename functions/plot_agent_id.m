function [  ] = plot_agent_id ( matPOSITIONS, nAGENTS, frame, vNULL )
    
    for A = 1 : nAGENTS
        
        if (matPOSITIONS(frame).curPOS(A).NOR(1,1) ~= vNULL)
            
            % ID
            text(matPOSITIONS(frame).curPOS(A).NOR(1, 1), (matPOSITIONS(frame).curPOS(A).NOR(1, 2) - 5) , num2str(A), 'color', 'c', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
            
        end
        
    end
    
end