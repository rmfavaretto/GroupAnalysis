function [ curPOS ] = get_positions( dataAGENTS, nAGENTS, frame )
    
    if (nAGENTS > 0)
        for A = 1 : nAGENTS
            curPOS(A).NOR = dataAGENTS(A).dataNOR(frame,1:2);
            curPOS(A).PER = dataAGENTS(A).dataPER(frame,1:2);
        end
    end

end