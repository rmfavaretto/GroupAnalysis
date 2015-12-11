function [  ] = plot_subtitle ( areaCurFrame, area_add, permanent, temporary, no_groups )
    
    x = areaCurFrame(2)/2;
    y = areaCurFrame(1)+(area_add/2);
    
    p1 = (x/3);
    p2 = (x/3)+250;
    p3 = (x/3)+500;
    
    rectangle('Position', [p1, y-5, 20, 14], 'EdgeColor', 'black', 'FaceColor', 'r');
    rectangle('Position', [p2, y-5, 20, 14], 'EdgeColor', 'black', 'FaceColor', 'b');
    rectangle('Position', [p3, y-5, 20, 14], 'EdgeColor', 'black', 'FaceColor', 'y');
    
    legVOL = ['Permanent: ' num2str(permanent)];
    text(p1 + 95, y, legVOL, 'color', 'black', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
    
    legINV = ['Temporary: ' num2str(temporary)];
    text(p2 + 95, y, legINV, 'color', 'black', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
    
    legNOG = ['No Group: ' num2str(no_groups)];
    text(p3 + 95, y, legNOG, 'color', 'black', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
    
end

