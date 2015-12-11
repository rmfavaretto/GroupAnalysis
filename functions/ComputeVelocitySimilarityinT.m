function [ V ] = ComputeVelocitySimilarityinT( inst_vel, vNULL )
    
    N = size( inst_vel, 2 );
    
    for i = 1 : N
        for j = 1 : N
            if ( (inst_vel(i) ~= vNULL) && (inst_vel(j) ~= vNULL) )
                V(i,j) = inst_vel(i) - inst_vel(j);
                if (V(i,j) < 0)
                    V(i,j) = V(i,j) * -1;
                end
            else
                V(i,j) = vNULL;
            end
        end
    end
end

