function [ RELEVANCE, REL_STD ] = calculate_relevance( REL_DATA, videoOUT )
    
    nGROUPS = size(REL_DATA, 2);
    
    %% TXT file definitions
    fileTXT = ['results\' videoOUT '\' videoOUT '-RELEVANCE.txt'];
    fid = fopen(fileTXT,'wt');
    
    
    %% Setting up some variables
    VEC_ag = [];
    VEC_time = [];
    VEC_dist = [];
    VEC_vel = [];
    VEC_ori = [];
    VEC_collec = [];
    
    
    %% Getting data for all frames
    for G = 1 : nGROUPS
        VEC_ag = [ VEC_ag REL_DATA(G).ag_num ];
        VEC_time = [ VEC_time REL_DATA(G).time ];
        VEC_dist = [ VEC_dist REL_DATA(G).dist ];
        VEC_vel = [ VEC_vel REL_DATA(G).vel ];
        VEC_ori = [ VEC_ori REL_DATA(G).ori ];
        VEC_collec = [ VEC_collec REL_DATA(G).collec ];
    end
    
    
    %% Calculating the STD values
    for G = 1 : nGROUPS
        REL_STD(G).std_ag = (REL_DATA(G).ag_num - mean(VEC_ag)) / std(VEC_ag);
        if ( isnan(REL_STD(G).std_ag) )
            REL_STD(G).std_ag = mean(VEC_ag);
        end
        REL_STD(G).std_time = (REL_DATA(G).time - mean(VEC_time)) / std(VEC_time);
        REL_STD(G).std_dis = (REL_DATA(G).dist - mean(VEC_dist)) / std(VEC_dist);
        REL_STD(G).std_vel = (REL_DATA(G).vel - mean(VEC_vel)) / std(VEC_vel);
        REL_STD(G).std_ori = (REL_DATA(G).ori - mean(VEC_ori)) / std(VEC_ori);
        REL_STD(G).std_collec = (REL_DATA(G).collec - mean(VEC_collec)) / std(VEC_collec);
    end
    
    
    %% Writing the values in the TXT file
    for G = 1 : nGROUPS
        RELEVANCE(G) = REL_STD(G).std_ag + REL_STD(G).std_time + (1 - REL_STD(G).std_dis) + (1 - REL_STD(G).std_vel) + (1 - REL_STD(G).std_ori) + REL_STD(G).std_collec;
        msgGroupAmount = [ 'G' num2str(G) ': ' num2str(RELEVANCE(G)) '\n' ];
        fprintf(fid, msgGroupAmount);
    end
    
    
    %% Closing the TXT file
    fclose(fid);
    
end

