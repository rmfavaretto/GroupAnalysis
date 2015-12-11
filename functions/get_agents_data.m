function [ AGENTS_DATA ] = get_agents_data ( G_DATA, DATA, matPOSITIONS, nFRAMES, nAGENTS, vNULL )
    
    curAGENTS_DATA.id = [];
    curAGENTS_DATA.position = [];
    curAGENTS_DATA.type = [];

    for frame = 1 : nFRAMES
    
        for A = 1 : nAGENTS
            
            if ( matPOSITIONS(frame).curPOS(A).PER(1,1) ~= vNULL )
                
                curAGENTS_DATA(A).id = A;
                curAGENTS_DATA(A).position = matPOSITIONS(frame).curPOS(A).PER;
                
                % Get the type at frame f
                [ curTYPE ] = get_type( G_DATA, DATA, frame, A );
                
                curAGENTS_DATA(A).type = curTYPE;
                
            else
                
                curAGENTS_DATA(A).id = vNULL;
                curAGENTS_DATA(A).position = vNULL;
                curAGENTS_DATA(A).type = vNULL;
                
            end
            
        end
        
        AGENTS_DATA(frame).data = curAGENTS_DATA;
        
    end
    
end
