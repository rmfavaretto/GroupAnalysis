function [ angle_group_AVG, curpANG_COHESIONS ] = get_cohesion_orient( DATA_FRAMES, matANGLES, frame, G )
    
    if ( DATA_FRAMES(frame).data(G).type ~= 'N' )
        
        % Number of people in the group
        nAG = DATA_FRAMES(frame).data(G).nro_pessoas;

        temp = [];

        for A = 1 : nAG

            agentID = DATA_FRAMES(frame).data(G).group(A);

            temp = [ temp matANGLES(frame).curANG(agentID) ];

        end

        % Mean of group angles
        angle_group_AVG = mean( temp );

        curpANG_COHESIONS = [];

        for A = 1 : nAG

            % Get the agent's ID
            agentID = DATA_FRAMES(frame).data(G).group(A);

            % Get the agent's ANGLE
            angle_agent = matANGLES(frame).curANG(agentID);

            % Calculate the agent's ANGLE COHESION
            orient_COHESION_AG = 10 - abs(angle_group_AVG - angle_agent);

            % Save the angle's cohesion
            curpANG_COHESIONS = [ curpANG_COHESIONS orient_COHESION_AG ];

        end
        
    else
        
        angle_group_AVG = -1;
        curpANG_COHESIONS = -1;
        
    end
    
end

