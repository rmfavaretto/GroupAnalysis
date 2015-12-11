function [ dataAGENTS ] = get_initial_data( pathsNOR, pathsPER, nFRAMES, nAGENTS, vNULL )
    
    %% Get the agents data
    for A = 1 : nAGENTS
        tempDATA_NOR = zeros(nFRAMES, 6) + vNULL;
        tempDATA_PER = zeros(nFRAMES, 6) + vNULL;

        for F = 1 : nFRAMES
            for D = 1 : 6
                if ( size(pathsNOR((pathsNOR(:,6) == A & pathsNOR(:,5) == F) ,1), 1 ) ~= 0 )
                    tempDATA_NOR(F,D) = pathsNOR((pathsNOR(:,6) == A & pathsNOR(:,5) == F) ,D);
                    tempDATA_PER(F,D) = pathsPER((pathsPER(:,6) == A & pathsPER(:,5) == F) ,D);
                end
            end
        end
        dataAGENTS(A).dataNOR = tempDATA_NOR;
        dataAGENTS(A).dataPER = tempDATA_PER;
    end
    
    
    %% Performing some adjustments
    for A = 1 : nAGENTS
        for F = 1 : nFRAMES
            if (dataAGENTS(A).dataNOR(F,5) == vNULL)
                dataAGENTS(A).dataNOR(F,5) = F;
                dataAGENTS(A).dataPER(F,5) = F;
            end
            if (dataAGENTS(A).dataNOR(F,6) == vNULL)
                dataAGENTS(A).dataNOR(F,6) = A;
                dataAGENTS(A).dataPER(F,6) = A;
            end
        end
    end
    
    
    %% Initial positions
    for A = 1 : nAGENTS
        % Normal data initial position
        dataAGENTS(A).initialPosNOR = [min(pathsNOR(pathsNOR(:,6)==A & pathsNOR(:,5)==min(pathsNOR(pathsNOR(:,6)==A,5)),1)) min(pathsNOR(pathsNOR(:,6)==A & pathsNOR(:,5)==min(pathsNOR(pathsNOR(:,6)==A,5)),2))];
                
        % Perspective data initial position
        dataAGENTS(A).initialPosPER = [min(pathsPER(pathsPER(:,6)==A & pathsPER(:,5)==min(pathsPER(pathsPER(:,6)==A,5)),1)) min(pathsPER(pathsPER(:,6)==A & pathsPER(:,5)==min(pathsPER(pathsPER(:,6)==A,5)),2))];
        
        % First e last frame of each agent
        dataAGENTS(A).frameSTART = min(pathsNOR(pathsNOR(:,6)==A,5));
        dataAGENTS(A).frameSTOP = min(pathsNOR(pathsNOR(:,6)==A,5)) + (size(pathsNOR(pathsNOR(:,6)==A,5),1)-1);
    end

    
end

