function [ colec, m_var ] = ColectivityTime( oriO, velCorrV, pos, vNULL )
    
    N = size( pos, 1 );
    k1 = 1;
    k2 = 1;
    
    for j = 1 : N
        for k = 1 : N
            if ( ( oriO( j, k ) ~= vNULL ) && ( velCorrV( j, k ) ~= vNULL ) )
                if (j ~= k )
                    if(oriO( j, k ) == -9999)
                        m_var( j, k ) = velCorrV( j, k ) * k1;
                        colec( j, k ) = 1 * exp( ( 0.3 * -1 ) * ( m_var( j, k ) * m_var( j, k ) ) );
                    else
                        m_var( j, k ) = ( velCorrV( j, k ) * k1 ) + ( oriO( j, k ) * k2 );
                        colec( j, k ) = 1 * exp( ( 0.3 * -1 ) * ( m_var( j, k ) * m_var( j, k ) ) );
                    end
                end
            else
                m_var( j, k ) = vNULL;
                colec( j, k ) = vNULL;
            end
        end
    end
end

