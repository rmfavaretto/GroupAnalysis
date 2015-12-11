function [  ] = plot_scale ( mFACTOR )
    
    text(30 + (mFACTOR / 2), 12 , '1 meter', 'color', 'g', 'horizontalAlignment', 'center', 'FontWeight', 'bold');
    
    line([27, 27 ], [25, 35], 'color', 'g', 'LineWidth', 2.5);
    line([30, 30 + mFACTOR ], [30, 30], 'color', 'g', 'LineWidth', 2.5);
    line([33 + mFACTOR, 33 + mFACTOR ], [25, 35], 'color', 'g', 'LineWidth', 2.5);
    
end

