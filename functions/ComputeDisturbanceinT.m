function [ disturb_level, hm_disturbed_me, disturb_all ] = ComputeDisturbanceinT( alphaT, matrix_variation, pos, oriO, mFACTOR, curDisPER, vNULL )
    
    sizeag = 0.8 * mFACTOR;
    
    %dados = find (alphaT == vNULL);
    
    N = size( pos, 1 );
    
    disturb_all = zeros( N, N );
    
    for j = 1 : N
        
        disturb_level(j) = 0;
        hm_disturbed_me(j) = 0;
        
        for k = 1 : N
            if ( matrix_variation( j, k ) ~= vNULL )
                if ( alphaT(j) ~= 0 )

                    d = sqrt( ( pos(k,1) - pos(j,1) ) * ( pos(k,1) - pos(j,1) ) + ( pos(k,2) - pos(j,2) ) * ( pos(k,2) - pos(j,2) ) );

                    if ( j ~= k ) && ( d < sizeag )

                        disturb_level(j) = disturb_level(j) + matrix_variation( j, k ) / ((d*d) + 0.1);
                        hm_disturbed_me(j) = hm_disturbed_me(j) + 1;
                        disturb_all(j,k) = matrix_variation( j, k ) / ((d*d) + 0.1);

                    end
                end
            else
                if (alphaT(j) == vNULL)
                    disturb_level(j) = vNULL;
                    hm_disturbed_me(j) = vNULL;
                end
                disturb_all(j,k) = vNULL;
            end
        end
    end
    
    %disturb_level( dados ) = vNULL;
    %hm_disturbed_me( dados ) = vNULL;
    
end

