function [ curCOLECTIVITY, curDISTURBANCE, curANGULAR_VAR, trkDATA ] = get_colectivities( curPOSITION, curVELOCITY_VEC, curVELOCITY, desiredVEL, curDISTANCE, mFACTOR, nAGENTS, frame, vNULL )
    
    for A = 1 : nAGENTS
        pos( A, 1 ) = curPOSITION(A).PER(1,1);
        pos( A, 2 ) = curPOSITION(A).PER(1,2);
    end
    trkDATA.pos = pos;
    
    trkDATA.inst_vel = curVELOCITY;
    
    for A = 1 : nAGENTS
        pos_x( A, 1 ) = curVELOCITY_VEC(A).PER(1,1);
        pos_y( A, 1 ) = curVELOCITY_VEC(A).PER(1,2);
    end
    trkDATA.pos_x = pos_x;
    trkDATA.pos_y = pos_y;
    
    trkDATA.alphaT = ComputeAforallAgentsT( trkDATA.inst_vel, desiredVEL, vNULL );
    trkDATA.velCorrV = ComputeVelocitySimilarityinT( trkDATA.alphaT, vNULL );
    trkDATA.oriO = ComputeOrientSimilarityinT( trkDATA.pos_x, trkDATA.pos_y, trkDATA.inst_vel, vNULL );
    
    curANGULAR_VAR = trkDATA.oriO;
    
    [ curCOLECTIVITY, matrix_variation ] = ColectivityTime( trkDATA.oriO, trkDATA.velCorrV, trkDATA.pos, vNULL );
    [ curDISTURBANCE.level, curDISTURBANCE.me, curDISTURBANCE.all ] = ComputeDisturbanceinT( trkDATA.alphaT, matrix_variation, trkDATA.pos, trkDATA.oriO, mFACTOR, curDISTANCE, vNULL );
    
end

