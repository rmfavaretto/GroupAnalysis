function [ curANG ] = get_angles( dataAGENTS, curPOS, matPOSITIONS, nAGENTS, frame, vNULL )
    
    for A = 1 : nAGENTS
        if ( (frame >= dataAGENTS(A).frameSTART) && (frame <= dataAGENTS(A).frameSTOP) )
            
            if ( (frame - 5) >= dataAGENTS(A).frameSTART )
                
                % a = matPOSITIONS( frame - 5 ).curPOS(A).PER;
                a = dataAGENTS(A).initialPosPER;
                
            else
                
                a = dataAGENTS(A).initialPosPER;
                
            end
            
            b = curPOS(A).PER;
            
            angle = atan2( b(2) - a(2), b(1) - a(1) ) / ( 2 * pi/360 );

            if(angle >= 0)
                curANG(A) = angle;
            else
                curANG(A) = angle+360;
            end
        else
            curANG(A) = vNULL;
        end
    end
    
end

