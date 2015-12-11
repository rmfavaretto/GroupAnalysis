function [  ] = create_sumarization_file ( G_DATA, AGENTS_DATA, DATA_FRAMES, trkDATA, matDISTANCES, matVELOCITIES, matCOLECTIVITIES, matDISTURBANCES, COHESION_DATA, mFACTOR, videoOUT, nFRAMES )
    
    %% Quantidade de grupos
    total_G = size(G_DATA, 2);
      
    
    %% TXT sumarization data
    fileTXT = ['results\' videoOUT '\' videoOUT '-SUMARIZATION.txt'];
    fsum = fopen(fileTXT,'wt');
    
    
    %% Write the TXT file frame by frame
    for frame = 1 : nFRAMES
        
        %% Print the frame number
        % msg_curFrame = [ num2str(frame) '\n' ];
        % fprintf(fsum, msg_curFrame);
        
        
        %% Print the group's IDs
        for G = 1 : total_G
            msg_curGroup = [ num2str(G) ' '];
            fprintf(fsum, msg_curGroup);
        end
        
        % Print a '\n' here
        fprintf(fsum, '\n');
        
        
        %% Print the groups' types
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            curTYPE = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    curTYPE = DATA_FRAMES(frame).data(curG).type;
                    
                    if (curTYPE == 'V')
                    
                        curTYPE = 1;

                    elseif (curTYPE == 'I')

                        curTYPE = 0;

                    end
                    
                end
                
            end
            
            msg_curType = [ num2str(curTYPE) ' '];
            fprintf(fsum, msg_curType);
            
        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the size of the group
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            curNRO = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    curNRO = DATA_FRAMES(frame).data(curG).nro_pessoas;
                    
                end
                
            end
            
            msg_curNroPeople = [ num2str(curNRO) ' '];
            fprintf(fsum, msg_curNroPeople);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the duration of the group
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            curDURATION = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    curDURATION = DATA_FRAMES(frame).data(curG).nro_frames;
                    
                end
                
            end
            
            msg_curNroPeople = [ num2str(curDURATION) ' '];
            fprintf(fsum, msg_curNroPeople);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the mean distances
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            mediaDis = -1;
            
            for curG = 1 : curGROUPS
                
                nro_pessoas = DATA_FRAMES(frame).data(curG).nro_pessoas;
            
                tempDis = zeros( nro_pessoas, nro_pessoas );

                tam = size( DATA_FRAMES(frame).data(curG).frames, 2 );
                 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    for r = 1 : tam
                        
                        if (DATA_FRAMES(frame).data(curG).frames(r) == frame)  
                    
                            for p = 1 : nro_pessoas

                                for q = 1 : nro_pessoas

                                    tempDis(p,q) = matDISTANCES(frame).curDIS( DATA_FRAMES(frame).data(curG).group(1,p), DATA_FRAMES(frame).data(curG).group(1,q));

                                end

                            end

                            mediaDis = mean(tempDis(tempDis > 0));
                            
                        end
                        
                    end
                    
                end

            end
            
            msg_curDuration = [ num2str(mediaDis * mFACTOR) ' '];
            fprintf(fsum, msg_curDuration);
            
        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
               
        
        %% Print the speeds
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            mediaVel = -1;
            
            for curG = 1 : curGROUPS
                
                nro_pessoas = DATA_FRAMES(frame).data(curG).nro_pessoas;
                
                tam = size( DATA_FRAMES(frame).data(curG).frames, 2 );
                
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    for r = 1 : tam
                        
                        if (DATA_FRAMES(frame).data(curG).frames(r) == frame)
                            
                            tempVel = [];
                            
                            for p = 1 : nro_pessoas
                                
                                tempVel(p) = matVELOCITIES(frame).curVEL( DATA_FRAMES(frame).data(curG).group(p) );
                                
                            end
                            
                            mediaVel = mean(tempVel);
                            
                        end
                        
                    end
                    
                end
                
            end
            
            msg_curSpeeds = [ num2str(mediaVel) ' '];
            fprintf(fsum, msg_curSpeeds);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the angular variation
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            mediaAngular = -1;
            
            for curG = 1 : curGROUPS
                
                nro_pessoas = DATA_FRAMES(frame).data(curG).nro_pessoas;
                
                tam = size( DATA_FRAMES(frame).data(curG).frames, 2 );
                
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    for r = 1 : tam
                        
                        if (DATA_FRAMES(frame).data(curG).frames(r) == frame)
                            
                            tempAngVar = [];
                            
                            for p = 1 : nro_pessoas

                                for q = 1 : nro_pessoas

                                    tempAngVar(p,q) = trkDATA(frame).data.oriO( DATA_FRAMES(frame).data(curG).group(1,p), DATA_FRAMES(frame).data(curG).group(1,q) );

                                end

                            end
                            
                            if (size(tempAngVar(tempAngVar > 0),1) > 0)
                                
                                mediaAngular = mean(tempAngVar(tempAngVar > 0));
                                
                            else
                                
                                mediaAngular = 0;
                                
                            end
                            
                        end
                        
                    end
                    
                end

            end
            
            msg_curAngVar = [ num2str(mediaAngular) ' '];
            fprintf(fsum, msg_curAngVar);
            
        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the area
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            curAREA = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    curAREA = DATA_FRAMES(frame).data(curG).area;
                    
                end
                
            end
            
            msg_curNroPeople = [ num2str(curAREA) ' '];
            fprintf(fsum, msg_curNroPeople);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the centroid - POS X
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            posX = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    if(DATA_FRAMES(frame).data(curG).nro_pessoas ~= 0)
                        
                        posX = DATA_FRAMES(frame).data(curG).centroid(1);
                        
                    end
                    
                end
                
            end
            
            msg_curNroPeople = [ num2str(posX) ' '];
            fprintf(fsum, msg_curNroPeople);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the centroid - POS Y
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            posY = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    if(DATA_FRAMES(frame).data(curG).nro_pessoas ~= 0)
                    
                        posY = DATA_FRAMES(frame).data(curG).centroid(2);
                        
                    end
                    
                end
                
            end
            
            msg_curNroPeople = [ num2str(posY) ' '];
            fprintf(fsum, msg_curNroPeople);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the collectivity
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            mediaCol = -1;

            for curG = 1 : curGROUPS
                
                nro_pessoas = DATA_FRAMES(frame).data(curG).nro_pessoas;

                tam = size( DATA_FRAMES(frame).data(curG).frames, 2 );
                
                tempVAR = [];
                 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    for r = 1 : tam
                        
                        if (DATA_FRAMES(frame).data(curG).frames(r) == frame)  
                    
                            for p = 1 : nro_pessoas

                                for q = 1 : nro_pessoas

                                    if ( p ~= q )
                                        
                                        tempVAR = [tempVAR, matCOLECTIVITIES(1).curCOL( DATA_FRAMES(frame).data(curG).group(p), DATA_FRAMES(frame).data(curG).group(q) )];
                                        
                                    end

                                end

                            end

                            mediaCol = mean(tempVAR);
                            
                        end
                        
                    end
                    
                end

            end
            
             msg_curDuration = [ num2str(mediaCol) ' '];
             fprintf(fsum, msg_curDuration);
            
        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the disturbance
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            mediaDis = -1;
            
            for curG = 1 : curGROUPS
                
                nro_pessoas = DATA_FRAMES(frame).data(curG).nro_pessoas;
                
                tam = size( DATA_FRAMES(frame).data(curG).frames, 2 );
                
                tempVAR = [];
                
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    for r = 1 : tam
                        
                        if (DATA_FRAMES(frame).data(curG).frames(r) == frame)
                            
                            for p = 1 : nro_pessoas
                                
                                tempVAR = [tempVAR, matDISTURBANCES(frame).curDIS.level( DATA_FRAMES(frame).data(curG).group(p) )];
                                
                            end
                            
                            mediaDis = mean(tempVAR);
                            
                        end
                        
                    end
                    
                end
                
            end
            
            msg_curSpeeds = [ num2str(sprintf('%0.6f', mediaDis)) ' '];
            fprintf(fsum, msg_curSpeeds);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
        
        %% Print the cohesion
        for G = 1 : total_G
            
            curGROUPS = DATA_FRAMES(frame).total_groups;
            
            curCOHESION = -1;
            
            for curG = 1 : curGROUPS
 
                if ( DATA_FRAMES(frame).data(curG).groupID == G )
                    
                    curCOHESION = COHESION_DATA(frame).group(curG).group_cohesion;
                    
                end
                
            end
            
            msg_curNroPeople = [ num2str(curCOHESION) ' '];
            fprintf(fsum, msg_curNroPeople);

        end
        
        % imprimir um \n aqui
        fprintf(fsum, '\n');
        
end

