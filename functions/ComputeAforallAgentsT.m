function [ A ] = ComputeAforallAgentsT( inst_vel, desiredVEL, vNULL )
    
    N = size( inst_vel, 2 );
    
   for i = 1 : N
        if ( inst_vel(i) ~= vNULL )
            A(i) = max([0, (desiredVEL - inst_vel(i))]);
        else
            A(i) = vNULL;
        end
   end
    
end

