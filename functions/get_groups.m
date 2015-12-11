function [ curGROUPS ] = get_groups ( curFrame, dataAGENTS, curVELOCITY, curPOSITION, curDISTANCE, curDISTANCE_STD, curANGLE, mFACTOR, nAGENTS, frame, vNULL )
    
    curAGENTS = size( curVELOCITY( curVELOCITY ~= vNULL ), 2);
    
    % Neighbor distance limit
    % limDIS = round(1.2 * mFACTOR);
    limDIS = 1.2;
    
    % First near distance
    [ first_near ] = get_first_near_distance( nAGENTS, curDISTANCE, vNULL );
    
    % Distances at 1st frame
    [ iniDISTANCE ] = get_initial_distances ( dataAGENTS, nAGENTS );
    
    % Matriz de grupos
    mat_groups = zeros(nAGENTS, nAGENTS);
        
    % Find possible groups
    if (curAGENTS > 0)
        [ mat_groups ] = make_groups ( mat_groups, curVELOCITY, curANGLE, curDISTANCE, limDIS, nAGENTS, vNULL );
        [ vecGROUPS ] = get_vec_groups ( mat_groups, nAGENTS, frame );
    else
        vecGROUPS = [];
    end
    
    curGROUPS = vecGROUPS;
    
end

