function [ bool_dis ] = compare_distance ( curDISTANCE, limDIS, vNULL )
    
    %% Retorno bool_dis: 1 - similar, 0 - n�o similar
    bool_dis = 0;
        
    %% Compara se a dist�ncia entre os pontos � pr�xima
    if (curDISTANCE ~= vNULL)
        if (curDISTANCE <= limDIS)
            bool_dis = 1;
        end
    else
        bool_dis = vNULL;
    end
    
end

