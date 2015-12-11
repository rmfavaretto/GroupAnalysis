function [ curDISTANCE ] = get_distances( curPOSITION, nAGENTS, mFACTOR, vNULL )
    
    for A = 1 : nAGENTS
        for AA = 1 : nAGENTS
            if ( ( curPOSITION(A).PER(1) ~= vNULL ) && ( curPOSITION(AA).PER(1) ~= vNULL ) && ( curPOSITION(A).PER(2) ~= vNULL ) && ( curPOSITION(AA).PER(2) ~= vNULL ) )
                curDISTANCE(A, AA) = round(sqrt((curPOSITION(A).PER(1)-curPOSITION(AA).PER(1))^2+(curPOSITION(A).PER(2)-curPOSITION(AA).PER(2))^2)/mFACTOR,2);
            else
                curDISTANCE(A, AA) = vNULL;
            end
        end
    end
    
end

