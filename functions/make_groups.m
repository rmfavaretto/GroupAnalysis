function [ mat_groups ] = make_groups ( mat_groups, curVELOCITY, curANGLE, curDISTANCE, limDIS, nAGENTS, vNULL )

    for A = 1 : nAGENTS
        
        for AA = 1 : nAGENTS
            
            if (A ~= AA)
                
                [ bool_ang ] = compare_angle ( curANGLE(A), curANGLE(AA), vNULL );
                [ bool_dis ] = compare_distance ( curDISTANCE(A,AA), limDIS, vNULL );
                [ bool_vel ] = compare_velocity ( curVELOCITY(A), curVELOCITY(AA), vNULL );

                if ( ( bool_ang == 1 ) && ( bool_dis == 1 ) )
                    
                    mat_groups( A, AA ) = 1;
                    
                elseif ( ( bool_ang == vNULL ) || ( bool_dis == vNULL ) )
                    
                    mat_groups( A, AA ) = vNULL;
                    
                end
                
            else
                
                mat_groups( A, AA ) = 0;
                
            end
            
            id = 1;
            
        end
        
    end
        
end

