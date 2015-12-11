function [ COHESION_DATA ] = calculate_cohesion( DATA_FRAMES, matANGLES, matVELOCITIES, nFRAMES )

    for frame = 1 : nFRAMES

        % Number of groups
        nGROUPS = DATA_FRAMES(frame).total_groups;
        
        for G = 1 : nGROUPS
            
            % Get the COHESION of orientation (angles)
            [ angle_group_AVG, curpANG_COHESIONS ] = get_cohesion_orient( DATA_FRAMES, matANGLES, frame, G );
            COHESION_DATA(frame).group(G).angle_group_avg = angle_group_AVG;
            COHESION_DATA(frame).group(G).angle_agents = curpANG_COHESIONS;
            
            % Get the COHESION of speed (velocities)
            [ speed_group_AVG, curpSPEED_COHESIONS ] = get_cohesion_speed( DATA_FRAMES, matVELOCITIES, frame, G );
            COHESION_DATA(frame).group(G).speed_group_avg = speed_group_AVG;
            COHESION_DATA(frame).group(G).speed_agents = curpSPEED_COHESIONS;
            
            % Get the COHESION of size (Number of agents)
            [ size_group_cohesion ] = get_cohesion_size( DATA_FRAMES, frame, G );
            COHESION_DATA(frame).group(G).size_group_avg = size_group_cohesion;
            
            if ( DATA_FRAMES(frame).data(G).type ~= 'N' )
            
                % Number of people in the group
                nAG = DATA_FRAMES(frame).data(G).nro_pessoas;

                individual_cohesion = [];

                % Calculate the individual cohesion
                for A = 1 : nAG

                    i_cohesion = curpANG_COHESIONS(A) + curpSPEED_COHESIONS(A) + size_group_cohesion;

                    individual_cohesion = [ individual_cohesion i_cohesion ];

                end

                COHESION_DATA(frame).group(G).individual_cohesion = individual_cohesion;
                COHESION_DATA(frame).group(G).group_cohesion = mean(individual_cohesion);

                % Get the group's ID
                COHESION_DATA(frame).group(G).id = DATA_FRAMES(frame).data(G).groupID;
                
            else
                
                COHESION_DATA(frame).group(G).individual_cohesion = -1;
                COHESION_DATA(frame).group(G).group_cohesion = -1;
                COHESION_DATA(frame).group(G).id = DATA_FRAMES(frame).data(G).groupID;
                
            end
            
        end
        
    end
    
end

