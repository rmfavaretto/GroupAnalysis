function [ iniDISTANCE ] = get_initial_distances ( dataAGENTS, nAGENTS )
    
     iniDISTANCE = zeros( nAGENTS, nAGENTS );
    
    for A = 1 : nAGENTS
        for AA = 1 : nAGENTS
            iniDISTANCE(A, AA) = round(sqrt((dataAGENTS(A).initialPosPER(1,1)-dataAGENTS(AA).initialPosPER(1,1))^2+(dataAGENTS(A).initialPosPER(1,2)-dataAGENTS(AA).initialPosPER(1,2))^2),0);
        end
    end
    
end

