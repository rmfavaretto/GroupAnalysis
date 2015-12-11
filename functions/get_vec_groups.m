function [ vecGROUPS ] = get_vec_groups ( mat_groups, nAGENTS, frame )
    
    G_ID = 1;
    
    temp = [];
    
    for A = 1 : nAGENTS
        temp = A;
        for AA = 1 : nAGENTS
            if ( mat_groups(A, AA) == 1 )
                temp = [ temp AA ];
            end
        end
        vecGROUPS_TEMP(A).idx = temp;
    end
    
    % Inicializa as variáveis
    tam_groups = [];
    
    %% Encontra os grupos unitários
    for i = 1 : nAGENTS
        tam_groups(i,:) = size(vecGROUPS_TEMP(i).idx);
    end
    
    
    %% Remove grupos unitários ou repetidos
    vecGROUPS_TEMP(find(tam_groups(:,2)<2)) = [];
    max_group = max(tam_groups(:,2));
    
    qtde_groups = size(vecGROUPS_TEMP);
    
    remover = zeros(qtde_groups(2),1);
    
    for i = 1 : qtde_groups(2)
        
        for j = 1 : qtde_groups(2)
            
            if (remover(i) ~= 1)
                
                if i ~= j
                    
                    if (size(vecGROUPS_TEMP(i).idx) == size(vecGROUPS_TEMP(j).idx))
                        
                        temp = (vecGROUPS_TEMP(i).idx == vecGROUPS_TEMP(j).idx);
                        
                        if (temp(1) * temp(2) == 1)
                            remover(j,1) = 1;
                        end
                        
                    end
                    
                end
                
            end
            
        end
        
    end
    vecGROUPS_TEMP( find(remover(:,1)==1) ) = [];
    
    % Tamanho do vetor de possíveis grupos
    T_POSS_G = size(vecGROUPS_TEMP, 2);
    
    if (T_POSS_G > 0)
        
        id_control = 1;
        G(id_control).agents = vecGROUPS_TEMP(id_control).idx;
        
        for i = 1 : T_POSS_G
            
            tam_vec = size(vecGROUPS_TEMP(i).idx, 2);
            
            for j = 1 : tam_vec
                
                tam_G = size(G, 2);
                
                for k = id_control : tam_G
                    
                    tam_cur_G = size(G(k).agents,2);
                    control_g_id = 0;
                    
                    if (frame == 231)
                        a = 2;
                    end
                    
                    for l = 1 : tam_cur_G
                        
                        if ( vecGROUPS_TEMP(i).idx(1,j) == G(k).agents(1,l) )
                            control_g_id = 1;
                        end
                        
                    end
                    
                    if ( control_g_id == 1 )
                        G(id_control).agents = [G(id_control).agents vecGROUPS_TEMP(i).idx];
                    else
                        id_control = id_control + 1;
                        G(id_control).agents = vecGROUPS_TEMP(i).idx;
                    end
                    
                end
                
            end
            
        end
        
        % Filtrando os grupos (unique)
        for g = 1 : id_control
            vecGROUPS(g).idx = unique(G(g).agents);
            vecGROUPS(g).frame = frame;
        end
                
    else
        vecGROUPS.idx = [];
    end
    
end

