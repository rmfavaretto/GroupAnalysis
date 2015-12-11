function [ NRO ] = get_info_groups_frames( G_DATA, DATA_FRAMES, AGENTS_DATA, nFRAMES, vNULL )
    
    %% Number of groups
    nGROUPS = size( G_DATA , 2 );
    
    
    %% Getting information frame by frame
    for frame = 1 : nFRAMES
        
        % Setting up some variables
        curGroups = 0;
        curPermGroups = 0;
        curTempGroups = 0;
        curAgents = 0;
        curAgGroups = 0;
        curAgID = [];
        curAgGroupsID = [];
        curAgNoGroups = 0;
        curAgNoGroupsID = [];
        
        % Get the number of agents in the frame
        temp_n_agents = size(AGENTS_DATA(frame).data, 2);
        
        for A = 1 : temp_n_agents
            
            agents(A) = AGENTS_DATA(frame).data(A).id;
            
            if ( AGENTS_DATA(frame).data(A).id ~= vNULL )
                
                curAgID = [curAgID AGENTS_DATA(frame).data(A).id];
                
            end
            
        end
        
        curAgents = size( agents( agents > 0 ), 2 );
        

        % Get the number of permanent groups
        curPermGroups = DATA_FRAMES(frame).permanent_groups;
        
        % Get the number of temporary groups
        curTempGroups = DATA_FRAMES(frame).temporary_groups;
        
        % Get the number of groups in the current frame
        curGroups = DATA_FRAMES(frame).total_groups;
        
        
        % Get the agent's ID for each type of group
        for G = 1 : curGroups
            
            if ( DATA_FRAMES(frame).data(G).type ~= 'N' )
                
                % Agent's IDs
                curAgGroupsID = [ curAgGroupsID DATA_FRAMES(frame).data(G).group ];
                
                % Groups' agents number
                curAgGroups = curAgGroups + DATA_FRAMES(frame).data(G).nro_pessoas;
                
            end
            
        end
        
        % Update the number of groups
        curGroups = curPermGroups + curTempGroups;
            
        % Update the number of agents
        curAgNoGroups = curAgents - curAgGroups;
        
        NRO(frame).curGroups = curGroups;
        NRO(frame).curPermGroups = curPermGroups;
        NRO(frame).curTempGroups = curTempGroups;
        NRO(frame).curAgents = curAgents;
        NRO(frame).curAgGroups = curAgGroups;
        NRO(frame).curAgGroupsID = curAgGroupsID;
        NRO(frame).curAgNoGroups = curAgNoGroups;
        NRO(frame).curAgNoGroupsID = setdiff(curAgID, curAgGroupsID);

    end
    
end

