function [ size_group_cohesion ] = get_cohesion_size( DATA_FRAMES, frame, G )
    
    if ( DATA_FRAMES(frame).data(G).type ~= 'N' )
        
        % Number of people in the group
        nAG = DATA_FRAMES(frame).data(G).nro_pessoas;

        size_group_cohesion = log10(nAG);
        
    else
        
        size_group_cohesion = -1;
        
    end
     
end

