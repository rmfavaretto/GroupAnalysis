function [ bool_vel ] = compare_velocity ( vel_p1, vel_p2, vNULL )
    
    %% Define o percentual de similaridade
    per = 5;
    
    %% Definição dos limites superior e inferior
    lim_sup = vel_p1+(per*vel_p1);
    lim_inf = vel_p1-(per*vel_p1);
    
    %% Retorno bool_ang: 1 - similar, 0 - não similar
    bool_vel = 0;
    
    %% Compara as velocidades
    if ( ( vel_p1 ~= vNULL ) && ( vel_p2 ~= vNULL ) )
        if (vel_p2 < lim_sup) && (vel_p2 > lim_inf)
            bool_vel = 1;
        end
    else
        bool_vel = vNULL;
    end
    
end

