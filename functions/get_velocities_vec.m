function [ curVEL ] = get_velocities_vec( dataAGENTS, nAGENTS, frame )
       
     if (nAGENTS > 0)
        for A = 1 : nAGENTS
            curVEL(A).NOR = dataAGENTS(A).dataNOR(frame,3:4);
            curVEL(A).PER = dataAGENTS(A).dataPER(frame,3:4);
        end
    end
    
end

