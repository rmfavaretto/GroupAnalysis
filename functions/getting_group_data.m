function [ G_DATA, DATA ] = getting_group_data( GROUPS, T_level, P_level, N_level, nFRAMES, vNULL )
    
    % Setting up some variables
    G.groupID = [];
    G.group = [];
    G.nro_pessoas = 0;
    G.type = '';
    G.nro_frames = 0;
    G.first = [];
    G.last = [];
    G.frames = [];
    G.positive = 0;
    G.negative = 0;
    
    for frame = 1 : nFRAMES
        
        curQtdGROUP = size(GROUPS(frame).curGROUPS, 2);
        
        if ( frame == 1 )
            
            for grupo = 1 : curQtdGROUP
                
                G(grupo).group = GROUPS(frame).curGROUPS(grupo).idx;
                G(grupo).first = frame;
                G(grupo).last = frame;
                G(grupo).frames = [G(grupo).frames, frame];
                G(grupo).positive = 1;
                G(grupo).negative = 0;
                
            end
            
        else
            
            for j = 1 : curQtdGROUP
                
                qtdGRUPOS = size(G, 2);
                diff = 0;
                
                for k = 1 : qtdGRUPOS
                    
                    size_G = size(GROUPS(frame).curGROUPS(j).idx, 2);
                    size_GROUPS = size(G(k).group, 2);
                    
                    if ( size_G == size_GROUPS )
                        
                        if ( GROUPS(frame).curGROUPS(j).idx ~= G(k).group )
                            
                            diff = diff + 1;
                            
                        else
                            
                           G(k).last = frame;
                           G(k).frames = [G(k).frames, frame];
                           G(k).positive = G(k).positive + 1;
                            
                        end
                        
                    else
                        
                        diff = diff + 1;
                        
                    end
                    
                end
                
                if (qtdGRUPOS == diff)
                    
                    G(qtdGRUPOS + 1).group = GROUPS(frame).curGROUPS(j).idx;
                    G(qtdGRUPOS + 1).first = frame;
                    G(qtdGRUPOS + 1).last = frame;
                    G(qtdGRUPOS + 1).frames = [ G(qtdGRUPOS + 1).frames, frame ];
                    G(qtdGRUPOS + 1).positive = 1;
                    G(qtdGRUPOS + 1).negative = 0;
                    
                    qtdGRUPOS = size(G, 2);
                    diff = 0;
                    
                end
                
            end
            
        end
        temp(frame).data = G;
        
        [ THIS ] = get_data_group_by_frame( G, temp, frame );
        
        % DATA: Getting the number of frames and agents and setting up the types
        
        total = size( THIS, 2 );
        
        for i = 1 : total
            
            THIS(i).groupID = i;
            
            THIS(i).nro_frames = size( THIS(i).frames, 2 );
            THIS(i).nro_pessoas = size( THIS(i).group, 2 );
            
            if ( THIS(i).nro_frames < T_level )
                
                THIS(i).type = 'N';
                
            else
                
                if ( (THIS(i).nro_frames < P_level) )
                    
                    THIS(i).type = 'I';
                    
                    if ( frame - THIS(i).last >  N_level )
                        
                        THIS(i).type = 'N';
                        
                    end

                elseif ( (THIS(i).nro_frames >= P_level) )
                    
                    THIS(i).type = 'V';
                    
                    if ( frame - THIS(i).last >  N_level )
                        
                        THIS(i).type = 'N';
                        
                    end
                
                end
            
            end
            
            %tam = size(THIS, 2);
            %remove = [];
            %for i = 1 : tam

            %    if(THIS(i).type == 'N')

            %        remove = [remove i];

            %    end

            %end

            %THIS(remove) = [];
        
            DATA(frame).data = THIS;      
        
        end
        
    end
    
    % Getting the number of frames and agents and setting up the types
    if (qtdGRUPOS > 0)
        
        for w = 1 : qtdGRUPOS
            
            G(w).nro_frames = size(G(w).frames,2);
            G(w).nro_pessoas = size(G(w).group,2);
            
            if ( G(w).nro_frames >= P_level )
                
                G(w).type = 'V';
                
            elseif ( G(w).nro_frames >= T_level )
                
                G(w).type = 'I';
                
            else
                
                G(w).type = 'N';
                
            end
            
        end
        
    end
    
    % Cleaning the empty data
    nGROUPS = size(G, 2);
    
    remove = [];
    
    for i = 1 : nGROUPS
        
        if ( G(i).nro_pessoas == 0 )
            remove = [remove i];
        end
        
    end
    
    G(remove) = [];

    % Output data
    G_DATA = G;
    
    %tam = size(G_DATA, 2);
    %remove = [];
    %for i = 1 : tam
        
    %    if(G_DATA(i).type == 'N')
            
    %        remove = [remove i];
            
    %    end
        
    %end
    
    %G_DATA(remove) = [];
    
end

