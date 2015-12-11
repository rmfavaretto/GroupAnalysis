function [ bool_ang ] = compare_angle ( ang_p1, ang_p2, vNULL )
    
    %% Define o percentual de similaridade
    per = 0.05;
    
    %% Definição dos limites superior e inferior
    lim_sup = ang_p1+(per*360);
    lim_inf = ang_p1-(per*360);
    
    %% Retorno bool_ang: 1 - similar, 0 - não similar
    bool_ang = 0;
        
    %% Compara se os ângulos de objetivo estão próximos
    if ( (ang_p1 ~= vNULL) && (ang_p2 ~= vNULL) )
        if(lim_sup <= 360) && (lim_inf >= 0)
            if (ang_p2 <= lim_sup) && (ang_p2 >= lim_inf)
                bool_ang = 1;
            end
        elseif (lim_sup > 360) && (lim_inf >= 0)
            if ((ang_p2 <= 360) && (ang_p2 >= lim_inf)) || ((ang_p2 >= 0) && (ang_p2 <= lim_sup-360))
                bool_ang = 1;
            end
        elseif (lim_inf < 0) && (lim_sup <= 360)
            if ((ang_p2 <= lim_sup) && (ang_p2 >= 0)) || ((ang_p2 >= 360-lim_inf) && (ang_p2 <= 360))
                bool_ang = 1;
            end
        end
    else
        bool_ang = vNULL;
    end
    
end

