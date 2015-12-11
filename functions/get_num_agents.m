function [ qtdPos ] = get_num_agents( AGENTS_DATA, F, vNULL )
    
    tam = size( AGENTS_DATA(F).data, 2 );
    cont = 0;
    
    for S = 1 : tam
        
        if ( AGENTS_DATA(F).data(S).id ~= vNULL )
            cont = cont + 1;
        end
        
    end
    
    qtdPos = cont;
    
end

