function [ curTYPE ] = get_type( G_DATA, DATA, frame, agent )
    
    qtd_groups = size(DATA(frame).data, 2);
    
    a = [];
    
    if (qtd_groups > 1)
        
        for i = 1 : qtd_groups
            
            if(DATA(frame).data(i).nro_pessoas == 0)
                
                a = [a i];                
                
            end
            
        end
        
    end
    
    DATA(frame).data(a) = [];
    
    qtd_groups = size(DATA(frame).data, 2);
    
    curTYPE = 0;
    
    for G = 1 : qtd_groups
        
        cur_num_Agents = size(DATA(frame).data(G).group, 2);
        
        for A = 1 : cur_num_Agents
            
            if ( DATA(frame).data(G).group(1, A) == agent )
                
                %cur_num_Frames = size( G_DATA(G).frames, 2);
                cur_num_Frames = G_DATA(G).nro_frames;
                
                if ( DATA(frame).data(G).type == 'V' )
                    
                    curTYPE = 1;
                    
                elseif ( DATA(frame).data(G).type == 'I' )
                    
                    curTYPE = 2;
                    
                end

            end
            
        end
        
    end
    
end

