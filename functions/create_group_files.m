function [ REL_DATA ] = create_group_files( G_DATA, COHESION_DATA, matPOSITIONS, matVELOCITIES, matDISTANCES, matANGLES, matANGULAR_VAR, matCOLECTIVITIES, matDISTURBANCES, videoOUT, RESOLUTION, nFRAMES, nAGENTS, mFACTOR )
    
    %% Getting the total of groups
    nro_groups = size( G_DATA, 2 );
    
    
    %% TXT file definitions
    fileTXT = ['results\' videoOUT '\' videoOUT '-GROUPS.txt'];
    fid = fopen(fileTXT,'wt');
    
    
    %% XML file definitions
    docNode = com.mathworks.xml.XMLUtils.createDocument('ANALYSIS');
    ANALYSIS = docNode.getDocumentElement;
    ANALYSIS.setAttribute('Type','Group analysis');
    
    
    %% Add the GROUP's information
    
    % Number of groups in the XML file
    groups = docNode.createElement('GROUPS');
    groups.setAttribute('Amount',num2str(nro_groups));
    ANALYSIS.appendChild(groups);
    
    % Number of groups in the TXT file
    msgGroupAmount = ['Number of Groups: ' num2str(nro_groups)];
    fprintf(fid, msgGroupAmount);
    
    
    %% Add the region size's information
    
    % Get the video resolution
    PXS = RESOLUTION(1) * RESOLUTION(2);
    
    % Converting px to m²
    umPXarea = ( 1 / mFACTOR ) ^ 2;
    region_size = PXS * umPXarea;
    
    % Region size in the TXT file
    msgGroupAmount = ['\nRegion size: ' num2str(region_size)];
    fprintf(fid, msgGroupAmount);
    
    
    %% Add the people number's information
    
    % Number of People in the TXT file
    msgGroupAmount = ['\nNumber of People: ' num2str(nAGENTS)];
    fprintf(fid, msgGroupAmount);
    
    
    %% Getting the data of each group
    for G = 1 : nro_groups
        
        %% Group ID
        
        % Group ID in the XML file
        curGroup = docNode.createElement('GROUP');
        curGroup.setAttribute('GroupID', num2str(G));
        groups.appendChild(curGroup);

        % Group ID in the TXT file
        msgGroupID = ['\n\nGROUP ' num2str(G)];
        fprintf(fid, msgGroupID);
        
        
        %% Group TYPE
        
        % Formating the type
        if (G_DATA(G).type == 'V')
            type_group = 'Permanent';
        else
            type_group = 'Temporary';
        end
        
        % Group TYPE in the XML file
        type = docNode.createElement('TYPE');
        type.appendChild(docNode.createTextNode(type_group));
        curGroup.appendChild(type);

        % Group TYPE in the TXT file
        msgGroupType = ['\nType: ' type_group];
        fprintf(fid, msgGroupType);

        
        %% Group AGENTS NUMBER
        
        % Getting the agents number
        nro_agents = G_DATA(G).nro_pessoas;
        
        % Group AGENTS NUMBER in the XML file
        people = docNode.createElement('PEOPLE');
        people.appendChild(docNode.createTextNode(num2str(nro_agents)));
        curGroup.appendChild(people);

        % Group AGENTS NUMBER in the TXT file
        msgGroupPeople = ['\nNumber of people: ' num2str(nro_agents)];
        fprintf(fid, msgGroupPeople);
        
        % Write ANGENTS NUMBER in the RELEVANCE var
        REL_DATA(G).ag_num = nro_agents;
        REL_DATA(G).ag_num_std = std(nro_agents);
        
        
        %% Group DURATION
        
        % Getting group duration
        nro_frames = G_DATA(G).nro_frames;
        
        % Group DURATION in the XML file
        frames = docNode.createElement('FRAMES');
        frames.appendChild(docNode.createTextNode(num2str(nro_frames)));
        curGroup.appendChild(frames);

        % Group DURATION in the XML file
        msgGroupDuration = ['\nNumber of frames: ' num2str(nro_frames)];
        fprintf(fid, msgGroupDuration);

        % Write DURATION in the RELEVANCE var
        REL_DATA(G).time = nro_frames;
        REL_DATA(G).time_std = std(nro_frames);
        
        
        %% Group MEAN DISTANCE
        
        % Calculate the mean distances
        tempDis = zeros(nro_agents, nro_agents);
        
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            
            for P = 1 : nro_agents
                
                for Q = 1 : nro_agents

                    tempDis(P, Q) = matDISTANCES(cur_F).curDIS(G_DATA(G).group(1,P), G_DATA(G).group(1,Q));

                end
                
            end
            
            DIS(F).curDis = tempDis;
            temp_mediaDis(F) = mean(mean(DIS(F).curDis(DIS(F).curDis > 0)));
            tempDis = [];
            
        end
        
        mediaDis = mean(temp_mediaDis);
        stdDis = std(temp_mediaDis(temp_mediaDis > 0));
        
        % Group MEAN DISTANCE in the XML file
        curDistance = docNode.createElement('MEAN-DISTANCES');
        curDistance.setAttribute('STD', num2str(stdDis));
        curDistance.appendChild(docNode.createTextNode(num2str(mediaDis)));
        curGroup.appendChild(curDistance);

        % Group MEAN DISTANCE in the TXT file
        msgGroupDistance = ['\nMean distances (meters): ' num2str(mediaDis) ' std: ' num2str(stdDis)];
        fprintf(fid, msgGroupDistance);
        
        % Write MEAN DISTANCE in the RELEVANCE var
        REL_DATA(G).dist = mediaDis;
        REL_DATA(G).dist_std = stdDis;
        
        
        %% Group MEAN SPEED
        
        % Calculate the mean speeds
        tempVel = [];
        
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            
            for P = 1 : nro_agents
                
                tempVel(P) = matVELOCITIES(cur_F).curVEL(G_DATA(G).group(P));
                
            end
            
            vel(F) = mean(tempVel);
            stdVel(F) = std(tempVel);
            tempVel = [];
            
        end
        
        mediaVel = mean(vel);
        stdVel = mean(stdVel);
        
        % Group MEAN SPEED in the XML file
        curVelocity = docNode.createElement('MEAN-SPEEDS');
        curVelocity.setAttribute('STD', num2str(stdVel));
        curVelocity.appendChild(docNode.createTextNode(num2str(mediaVel)));
        curGroup.appendChild(curVelocity);

        % Group MEAN SPEED in the TXT file
        msgGroupVelocidades = ['\nMean speeds (meters/frame): ' num2str(mediaVel) ' std: ' num2str(stdVel)];
        fprintf(fid, msgGroupVelocidades);
        
        % Write MEAN SPEED in the RELEVANCE var
        REL_DATA(G).vel = mediaVel;
        REL_DATA(G).vel_std = stdVel;
        
        
        %% Group MEAN DIRECTION
        
        % Calculate the mean directions
        tempDir = [];
        
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            
            for P = 1 : nro_agents
                
                tempDir(P) = matANGLES(cur_F).curANG(G_DATA(G).group(P));
                
            end
            
            dir(F) = mean(tempDir);
            stdDir(F) = std(tempDir);
            tempDir = [];
            
        end
        
        mediaDir = mean(dir);
        stdDir = mean(stdDir); 
        
        % Group MEAN DIRECTION in the XML file
        curDirection = docNode.createElement('MEAN-DIRECTION');
        curDirection.setAttribute('STD', num2str(stdDir));
        curDirection.appendChild(docNode.createTextNode(num2str(mediaDir)));
        curGroup.appendChild(curDirection);

        % Group MEAN DIRECTION in the TXT file
        msgGroupAngles = ['\nMean direction: ' num2str(mediaDir) ' std: ' num2str(stdDir)];
        fprintf(fid, msgGroupAngles);
        
        
        %% Group MEAN ANGULAR VARIATION
        
        % Calculate the mean angular variations
        tempAngVar = zeros(nro_agents, nro_agents);
        
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            
            for P = 1 : nro_agents
                
                for Q = 1 : nro_agents

                    tempAngVar(P, Q) = matANGULAR_VAR(cur_F).curANG(G_DATA(G).group(1,P), G_DATA(G).group(1,Q));

                end
                
            end
            
            ANG_VAR(F).curAngVar = tempAngVar;
            temp_mediaAngVar(F) = mean(mean(ANG_VAR(F).curAngVar(ANG_VAR(F).curAngVar > 0)));
            tempAngVar = [];
            
        end
        
        mediaAngVar = mean( temp_mediaAngVar( temp_mediaAngVar > 0 ) );
        stdAngVar = std( temp_mediaAngVar( temp_mediaAngVar > 0 ) );
        
        % Group MEAN ANGULAR VARIATION in the XML file
        curAngVariation = docNode.createElement('MEAN-ANGULAR-VARIATION');
        curAngVariation.setAttribute('STD', num2str(stdAngVar));
        curAngVariation.appendChild(docNode.createTextNode(num2str(mediaAngVar)));
        curGroup.appendChild(curAngVariation);

        % Group MEAN ANGULAR VARIATION in the TXT file
        msgGroupAngles = ['\nMean angular variation: ' num2str(mediaAngVar) ' std: ' num2str(stdAngVar)];
        fprintf(fid, msgGroupAngles); 
        
        % Write MEAN ANGULAR VARIATION in the RELEVANCE var
        REL_DATA(G).ori = mediaAngVar;
        REL_DATA(G).ori_std = stdAngVar;
        
        
        %% Group MEAN AREA
        
        % Calculate the mean area
        AREA = [];
        
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            tempVAR = [];
            
            for P = 1 : nro_agents
                
                tempVAR = vertcat( tempVAR, matPOSITIONS(cur_F).curPOS( G_DATA(G).group(P) ).PER);
                
            end
            
            [ ~, temAre ] = boundary( tempVAR );
            AREA(F) = temAre * umPXarea;
            
        end
        
        mediaAre = round( mean(AREA), 6 );
        stdAre = round( std(AREA), 6 );
        AREA = [];
        
        % Group MEAN AREA in the XML file
        curArea = docNode.createElement('MEAN-AREA');
        curArea.setAttribute('STD', num2str(stdAre));
        curArea.appendChild(docNode.createTextNode(num2str(mediaAre)));
        curGroup.appendChild(curArea);

        % Group MEAN AREA in the TXT file
        msgGroupArea = ['\nMean area (m²): ' num2str(mediaAre)  ' std: ' num2str(stdAre)];
        fprintf(fid, msgGroupArea);
        
        
        %% Group MEAN COLECTIVITY
        
        % Calculate the mean colectivity
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            
            tempVAR = [];
            
            for P = 1 : nro_agents
                
                for Q = 1 : nro_agents

                    if ( P ~= Q )
                        tempVAR = [tempVAR, matCOLECTIVITIES(cur_F).curCOL(G_DATA(G).group(1,P), G_DATA(G).group(1,Q)) ];
                    end

                end
                
            end
            
            COLECT(F) = mean(tempVAR);
            
        end
        
        mediaCol = mean(COLECT);
        stdCol = std(COLECT);
        COLECT = [];
        
        % Group MEAN COLECTIVITY in the XML file
        curColectivity = docNode.createElement('MEAN-COLLECTIVITY');
        curColectivity.setAttribute('STD', num2str(stdCol));
        curColectivity.appendChild(docNode.createTextNode(num2str(mediaCol)));
        curGroup.appendChild(curColectivity);

        % Group MEAN COLECTIVITY in the TXT file
        msgGroupArea = ['\nMean collectivity: ' num2str(mediaCol) ' std: ' num2str(stdCol)];
        fprintf(fid, msgGroupArea);
        
        % Write MEAN COLECTIVITY in the RELEVANCE var
        REL_DATA(G).collec = mediaCol;
        REL_DATA(G).collec_std = stdCol;
        
        
        %% Group MEAN DISTURBANCE
        
        % Calculate the mean disturbance
        for F = 1 : nro_frames
            
            cur_F = G_DATA(G).frames(F);
            
            tempVAR = [];
            
            for P = 1 : nro_agents
                
                tempVAR = [tempVAR, matDISTURBANCES(cur_F).curDIS.level(G_DATA(G).group(P)) ];
                
            end
            
            DISTURB(F) = mean(tempVAR);
            
        end
        
        mediaDisturb = round( mean(DISTURB), 6 );
        stdDisturb = round( std(DISTURB), 6 );
        DISTURB = [];
        
        % Group MEAN DISTURBANCE in the XML file
        curDisturbance = docNode.createElement('MEAN-DISTURBANCE-LEVEL');
        curDisturbance.setAttribute('STD', num2str(stdDisturb));
        curDisturbance.appendChild(docNode.createTextNode(num2str(mediaDisturb)));
        curGroup.appendChild(curDisturbance);

        % Group MEAN DISTURBANCE in the TXT file
        msgGroupArea = ['\nMean disturbance: ' num2str(sprintf('%0.8f', mediaDisturb)) ' std: ' num2str(sprintf('%0.8f', stdDisturb))];
        fprintf(fid, msgGroupArea);
        
        
        %% Group MEAN COHESION
        
        % Calculate the mean cohesion
        for F = 1 : nro_frames
            
            cur_G = size ( COHESION_DATA(F).group, 2 );
            
            for GG = 1 : cur_G
            
                if ( COHESION_DATA(F).group(GG).id == G )

                    COHESION(F) = COHESION_DATA(F).group(GG).group_cohesion;

                end
                
            end
            
        end
        
        mediaCohesion = round( mean( COHESION( COHESION > 0) ), 6 );
        stdCohesion = round( std( COHESION( COHESION > 0) ), 6 );
        
        if ( isnan( mediaCohesion ) )
            
            mediaCohesion = 0;
            
        end
        
        if ( isnan( stdCohesion ) )
            
            stdCohesion = 0;
            
        end
        
        COHESION = [];
        
        % Group MEAN COHESION in the XML file
        curcohesion = docNode.createElement('MEAN-COHESION-LEVEL');
        curcohesion.setAttribute('STD', num2str(stdCohesion));
        curcohesion.appendChild(docNode.createTextNode(num2str(mediaCohesion)));
        curGroup.appendChild(curcohesion);

        % Group MEAN COHESION in the TXT file
        msgGroupArea = ['\nMean cohesion: ' num2str(sprintf('%0.8f', mediaCohesion)) ' std: ' num2str(sprintf('%0.8f', stdCohesion))];
        fprintf(fid, msgGroupArea);
                
    end
    
    %% Write the information in the XML file
    name = ['results\' videoOUT '\' videoOUT '-GROUPS.xml'];
    xmlwrite(name ,docNode);
    
    
    %% Close the TXT file
    fclose(fid);
    
end