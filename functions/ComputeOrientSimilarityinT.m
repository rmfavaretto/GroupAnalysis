function [ O ] = ComputeOrientSimilarityinT( pos_x, pos_y, inst_vel, vNULL )
    
    N = size( inst_vel, 2 );
    
    aux = [0 0];
    
    for j = 1 : N
        for k = 1 : N
            if ( (pos_x(j) ~= vNULL) && (pos_y(j) ~= vNULL) && (pos_x(k) ~= vNULL) && (pos_y(k) ~= vNULL))
                modulo_vec = sqrt( ( pos_x(j) - aux(1) )*( pos_x(j) - aux(1) ) + ( pos_y(j) - aux(2) )*( pos_y(j) - aux(2) ) );
                if ( modulo_vec ~= 0 )
                    v1.x = pos_x(j) / modulo_vec;
                    v1.y = pos_y(j) / modulo_vec;
                else
                    v1.x = -1;
                end

                modulo_vec = sqrt( ( pos_x(k) - aux(1) )*( pos_x(k) - aux(1) ) + ( pos_y(k) - aux(2) )*( pos_y(k) - aux(2) ) );
                if ( modulo_vec ~= 0 )
                    v2.x = pos_x(k) / modulo_vec;
                    v2.y = pos_y(k) / modulo_vec;
                else
                    v2.x = -1;
                end

                if ( ( v1.x ~= -1 ) && ( v2.x ~= -1 ) )
                    O( j, k ) = round( CalcProd( v1, v2 ), 4 );
                else
                    O( j, k ) = -9999;
                end
            else
                O( j, k ) = vNULL;
            end
        end
    end
end

