function [ groupCENTER, groupAREA ] = get_group_centroid( frame, curGROUP, matPOSITIONS )
    
    % Getting the number of agents
    nAG = size( curGROUP, 2 );
    
    if (nAG > 0)
        
        % Getting the agents' positions
        for A = 1 : nAG

            temp(A, 1) = matPOSITIONS(frame).curPOS( curGROUP(A) ).NOR(1,1);
            temp(A, 2) = matPOSITIONS(frame).curPOS( curGROUP(A) ).NOR(1,2);

        end

        % Calculating the group centroid with K-means
        [ ~, groupCENTER ] = kmeans( temp, 1 );

        % Calculating the area of the group
        [ ~, groupAREA ] = boundary( temp );
    
    else
        
        groupCENTER = -666;
        groupAREA = -666;
        
    end

end

