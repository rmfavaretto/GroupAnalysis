function [ first_near ] = get_first_near_distance( nAGENTS, curDISTANCE, vNULL )
    
    first_near = vNULL;
    
    for A = 1 : nAGENTS
        if (max(curDISTANCE(A,:))>0)
            first_near(A,1) = min(curDISTANCE(A,curDISTANCE(A,:)>0));
        else
            first_near(A,1) = vNULL;
        end
    end
    
end

