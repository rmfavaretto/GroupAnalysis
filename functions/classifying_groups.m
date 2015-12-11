function [ GROUP_TYPE ] = classifying_groups( GROUPS, frame )
    
    for f = 1 : frame
        
        totalG = size(GROUPS(f).curGROUPS,2);
        
        for g = 1 : totalG
            
            GROUP_TYPE = g;
            
        end
        
    end
    
end

