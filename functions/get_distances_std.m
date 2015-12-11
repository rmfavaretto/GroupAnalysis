function [curDISTANCE_STD] = get_distances_std ( dataAGENTS, matDISTANCES, nAGENTS, frame, vNULL )

    % Setting up some variables
    temp_data = [];
    curSTD = [];
    
    for A = 1 : nAGENTS
        startI = dataAGENTS(A).frameSTART;
        for AA = 1 : nAGENTS
            startJ = dataAGENTS(AA).frameSTART;
            for f = max ([startI startJ]) : frame
                if ( matDISTANCES(f).curDIS(A, AA) ~= vNULL )
                    temp_data = [temp_data matDISTANCES(f).curDIS(A, AA)];
                end
            end
            if ( matDISTANCES(frame).curDIS(A, AA) ~= vNULL )
                curSTD(A, AA) = std(temp_data);
            else
                curSTD(A, AA) = vNULL;
            end
            temp_data = [];
        end
    end
    
    curDISTANCE_STD = curSTD;
    
end

