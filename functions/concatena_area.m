function [ new_area ] = concatena_area( curFrame, area )

    areaFrame = size(curFrame);
    
    canais_img = length(areaFrame);
    
    if (canais_img == 2)        
        new_frame = zeros([area, areaFrame(2)]);
        new_frame = new_frame+0.941176471;
    else
        new_frame = zeros([area, areaFrame(2), 3]);
        new_frame = new_frame+0.941176471;
    end
    new_area = new_frame;
end

