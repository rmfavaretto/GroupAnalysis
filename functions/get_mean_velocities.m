function [ curVELOCITY_MEAN ] = get_mean_velocities ( dataAGENTS, curPOSITION, nAGENTS, frame, vNULL )
    
    for A = 1 : nAGENTS
        if ( curPOSITION(A).PER(1,1) ~= vNULL )
            curVELOCITY_MEAN(A) =  sqrt((curPOSITION(A).PER(1,1)-dataAGENTS(A).initialPosPER(1,1))^2+((curPOSITION(A).PER(1,2)-dataAGENTS(A).initialPosPER(1,2)))^2)/frame;
        else
            curVELOCITY_MEAN(A) = vNULL;
        end
    end
    
end

