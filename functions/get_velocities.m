function [ curVELOCITY ] = get_velocities( curVELOCITY_VEC, nAGENTS, mFACTOR, vNULL )
    
    for A = 1 : nAGENTS
        if ( ( curVELOCITY_VEC(A).PER(1) ~= vNULL ) && ( curVELOCITY_VEC(A).PER(2) ~= vNULL ) )
            curVELOCITY(A) = sqrt(power(curVELOCITY_VEC(A).PER(1), 2) + power(curVELOCITY_VEC(A).PER(2), 2)) / mFACTOR;
        else
            curVELOCITY(A) = vNULL;
        end
    end
    
end

