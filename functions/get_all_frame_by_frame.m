function [ DATA_FRAMES ] = get_all_frame_by_frame( G_DATA, nFRAMES, T_level, P_level, matPOSITIONS, nAGENTS, mFACTOR, vNULL )

    %% Number of groups
    nGROUPS = size( G_DATA , 2 );
    
    %G.groupID = [];
    %G.group = [];
    %G.nro_pessoas = 0;
    G = [];
    
    %% Processing each frame
    for frame = 1 : nFRAMES
        
        control_G = 1;
        
        for group = 1 : nGROUPS
            
            nFRMS = size( G_DATA(group).frames, 2 );
            
            for F = 1 : nFRMS
                
                if ( G_DATA(group).frames(F) == frame )
                    
                    G(control_G).groupID = group;
                    G(control_G).group = G_DATA(group).group;
                    G(control_G).nro_pessoas = G_DATA(group).nro_pessoas;
                    
                    control_G = control_G + 1;
                    
                end
                    
            end
            
        end
        
        DATA_FRAMES(frame).data = G;
        
        G = [];
        
    end
    
    
    %% Calculating the number of groups in each frame
    for frame = 1 : nFRAMES
        
        total_groups = size( DATA_FRAMES(frame).data, 2 );
        DATA_FRAMES(frame).total_groups = total_groups;
        
    end
    
    
    %% Calculating the number of frames for each group
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES(frame).total_groups > 0 )
            
            for g = 1 : DATA_FRAMES(frame).total_groups

                % Get the goup ID
                g_ID = DATA_FRAMES(frame).data(g).groupID;

                % Get the frames for this ID until the current frame
                DATA_FRAMES(frame).data(g).frames = G_DATA(g_ID).frames(G_DATA(g_ID).frames <= frame);

                % Counting the number of frames
                num_frames = size( DATA_FRAMES(frame).data(g).frames, 2);
                DATA_FRAMES(frame).data(g).nro_frames = num_frames;

            end
            
        end
        
    end
    
    
    %% Getting the first and the last frame of each group
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES(frame).total_groups > 0 )
            
            for g = 1 : DATA_FRAMES(frame).total_groups

                % Get the goup ID
                g_ID = DATA_FRAMES(frame).data(g).groupID;

                % Get the first frame
                DATA_FRAMES(frame).data(g).first = G_DATA(g_ID).first;

                % Get the last frame
                DATA_FRAMES(frame).data(g).last = frame;

            end
            
        end
        
    end
    
    
    %% Calculating the type of each group
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES(frame).total_groups > 0 )
        
            for g = 1 : DATA_FRAMES(frame).total_groups

                nro_frames = DATA_FRAMES(frame).data(g).nro_frames;

                if ( nro_frames >= P_level )

                    DATA_FRAMES(frame).data(g).type = 'V';

                elseif ( nro_frames >= T_level )

                    DATA_FRAMES(frame).data(g).type = 'I';
                    
                else
                    
                    DATA_FRAMES(frame).data(g).type = 'N';

                end

            end
            
        end
        
    end
    
    
    %% Calculating the centroid and the area of each group
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES(frame).total_groups > 0 )
        
            for g = 1 : DATA_FRAMES(frame).total_groups

                curGROUP = DATA_FRAMES(frame).data(g).group;

                [ groupCENTER, groupAREA ] = get_group_centroid( frame, curGROUP, matPOSITIONS );

                DATA_FRAMES(frame).data(g).centroid = groupCENTER;
                
                umPXarea = (1/mFACTOR)^2;
                
                curAREA = groupAREA * umPXarea;
                
                DATA_FRAMES(frame).data(g).area = curAREA;

            end
            
        end
        
    end
    
    
    %% Calculating the number of temporary and permanent groups in each frame
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES(frame).total_groups > 0 )
        
            temporary = 0;
            permanent = 0;

            for g = 1 : DATA_FRAMES(frame).total_groups

                type = DATA_FRAMES(frame).data(g).type;

                if ( type == 'I' )

                    temporary = temporary + 1;

                elseif ( type == 'V' )

                    permanent = permanent + 1;

                end

            end

            DATA_FRAMES(frame).temporary_groups = temporary;
            DATA_FRAMES(frame).permanent_groups = permanent;
            
        else
            
            DATA_FRAMES(frame).temporary_groups = 0;
            DATA_FRAMES(frame).permanent_groups = 0;
            
        end
        
    end
    
    
end

