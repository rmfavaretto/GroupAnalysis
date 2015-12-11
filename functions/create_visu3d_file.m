function [  ] = create_visu3d_file( videoOUT, AGENTS_DATA, nFRAMES, nAGENTS, mFACTOR, HIGHT, vNULL )
    
    %% Create the document node and root element, SIMULATION:
    docNode = com.mathworks.xml.XMLUtils.createDocument('SIMULATION');
    
    
    %% Identify the root element, and set the Path attribute:
    SIMULATION = docNode.getDocumentElement;
    SIMULATION.setAttribute('Path','.');
    
    
    %% Add the AGENTS element node:
    agents = docNode.createElement('AGENTS');
    SIMULATION.appendChild(agents);
    
    % List de agents elements
    for idx = 1 : nAGENTS
        
        curAgent = docNode.createElement('AGENT');
        curAgent.setAttribute('id', num2str(idx-1));
        agents.appendChild(curAgent);
        
    end
    
    
    %% Add the EVENTS element node:
    events = docNode.createElement('EVENTS');
    SIMULATION.appendChild(events);
    
    % Create the 'permanent' element
    curEvent = docNode.createElement('EVENT');
    curEvent.setAttribute('Name', 'Permanent Group');
    curEvent.setAttribute('Color', 'Red');
    curEvent.setAttribute('Tag', 'permanent');
    events.appendChild(curEvent);
    
    % Create the 'temporary' element
    curEvent = docNode.createElement('EVENT');
    curEvent.setAttribute('Name', 'Temporary Group');
    curEvent.setAttribute('Color', 'Blue');
    curEvent.setAttribute('Tag', 'temporary');
    events.appendChild(curEvent);
    
    
    %% Add the FRAMES element node:
    frames = docNode.createElement('FRAMES');
    frames.setAttribute('Quantity', num2str(nFRAMES));
    SIMULATION.appendChild(frames);
    
    % Cria os dados frame a frame
    for F = 1 : nFRAMES
        
        if ( size(AGENTS_DATA(F).data, 2) > 0 )
            
            [ qtdPos ] = get_num_agents( AGENTS_DATA, F, vNULL );
            curFrame = docNode.createElement('FRAME');
            curFrame.setAttribute('FrameAtual', num2str(F));
            curFrame.setAttribute('qtdPos', num2str(qtdPos));
            frames.appendChild(curFrame);

            % List all agents in that frame
            for A = 1 : nAGENTS
                
                % Agent's ID
                curAgentF = docNode.createElement('AGENT');
                
                if ( AGENTS_DATA(F).data(A).id ~= vNULL )
                    
                    curAgentF.setAttribute('id', num2str(A-1));
                    
                    if ( AGENTS_DATA(F).data(A).type == 1 )
                        curAgentF.setAttribute('tags', 'permanent');
                    elseif ( AGENTS_DATA(F).data(A).type == 2 )
                        curAgentF.setAttribute('tags', 'temporary');
                    end
                    
                end
                
                curFrame.appendChild(curAgentF);

                % Agent's position
                curPosition = docNode.createElement('POSITION');
                pos = [num2str(AGENTS_DATA(F).data(A).position(1,1)/mFACTOR) ' ' num2str(( HIGHT - AGENTS_DATA(F).data(A).position(1,1) ) / mFACTOR ) ' ' num2str(0)];
                curPosition.appendChild(docNode.createTextNode(pos));
                curAgentF.appendChild(curPosition);
                
            end
            
        else
            
            curFrame = docNode.createElement('FRAME');
            curFrame.setAttribute('FrameAtual', num2str(F));
            curFrame.setAttribute('qtdPos', num2str(0));
            frames.appendChild(curFrame);
            
        end
    end
    
    
    %% Write the XLM file
    name = ['results\' videoOUT '\' videoOUT '-3D.xml'];
    xmlwrite(name ,docNode);
    % type(name);
    
end

