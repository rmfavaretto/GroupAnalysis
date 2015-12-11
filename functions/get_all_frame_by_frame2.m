function [ DATA_FRAMES2 ] = get_all_frame_by_frame2 ( G_DATA, DATA, nFRAMES, T_level, P_level, matPOSITIONS, nAGENTS, mFACTOR, vNULL )
    

    %% Calculating the number of groups in each frame
    for frame = 1 : nFRAMES
        
        DATA_FRAMES2(frame).data = DATA(frame).data;
        
        total_groups = size( DATA(frame).data, 2 );
        DATA_FRAMES2(frame).total_groups = total_groups;
        
    end
    
    
    %% Calculating the centroid and the area of each group
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES2(frame).total_groups > 0 )
        
            for g = 1 : DATA_FRAMES2(frame).total_groups

                curGROUP = DATA_FRAMES2(frame).data(g).group;

                [ groupCENTER, groupAREA ] = get_group_centroid( frame, curGROUP, matPOSITIONS );

                DATA_FRAMES2(frame).data(g).centroid = groupCENTER;
                
                umPXarea = (1/mFACTOR)^2;
                
                curAREA = groupAREA * umPXarea;
                
                DATA_FRAMES2(frame).data(g).area = curAREA;

            end
            
        end
        
    end
    
    
    %% Calculating the number of temporary and permanent groups in each frame
    for frame = 1 : nFRAMES
        
        if ( DATA_FRAMES2(frame).total_groups > 0 )
        
            temporary = 0;
            permanent = 0;

            for g = 1 : DATA_FRAMES2(frame).total_groups

                type = DATA_FRAMES2(frame).data(g).type;

                if ( type == 'I' )

                    temporary = temporary + 1;

                elseif ( type == 'V' )

                    permanent = permanent + 1;

                end

            end

            DATA_FRAMES2(frame).temporary_groups = temporary;
            DATA_FRAMES2(frame).permanent_groups = permanent;
            
        else
            
            DATA_FRAMES2(frame).temporary_groups = 0;
            DATA_FRAMES2(frame).permanent_groups = 0;
            
        end
        
    end
    
    
end

