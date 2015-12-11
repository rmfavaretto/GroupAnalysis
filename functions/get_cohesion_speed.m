function [ speed_group_AVG, curpSPEED_COHESIONS ] = get_cohesion_speed( DATA_FRAMES, matVELOCITIES, frame, G )
    
    if ( DATA_FRAMES(frame).data(G).type ~= 'N' )
        
        % Number of people in the group
        nAG = DATA_FRAMES(frame).data(G).nro_pessoas;

        temp = [];

        for A = 1 : nAG

            agentID = DATA_FRAMES(frame).data(G).group(A);

            temp = [ temp matVELOCITIES(frame).curVEL(agentID) ];

        end

        % Mean of group angles
        speed_group_AVG = mean( temp );

        curpSPEED_COHESIONS = [];

        for A = 1 : nAG

            % Get the agent's ID
            agentID = DATA_FRAMES(frame).data(G).group(A);

            % Get the agent's ANGLE
            speed_agent = matVELOCITIES(frame).curVEL(agentID);

            % Calculate the agent's ANGLE COHESION
            speed_COHESION_AG = 10 - abs(speed_group_AVG - speed_agent);

            % Save the angle's cohesion
            curpSPEED_COHESIONS = [ curpSPEED_COHESIONS speed_COHESION_AG ];

        end
    
    else
        
        speed_group_AVG = -1;
        curpSPEED_COHESIONS = -1;
        
    end
    
    
    
    
    
end

