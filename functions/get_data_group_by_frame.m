function [ THIS ] = get_data_group_by_frame( GROUPS, temp, frame )
    
    qtde_curG = size( temp(frame).data, 2 );
    
    if ( frame > 1 )
        
        for G = 1 : qtde_curG
            
            GROUPS(G).negative = frame - (GROUPS(G).first - 1) - GROUPS(G).positive;
            
        end
        
    end
    
    THIS = GROUPS;
    
end

