function [  ] = plot_cohesion( curCOHESION, curCENTROID, curTYPE)
    
    if ( curTYPE ~= 'N' )

        % Set the color
        if ( curTYPE == 'V' )

            color = 'r';

        elseif ( curTYPE == 'I' )

            color = 'b';

        end

        if ( curCOHESION < 0 )

            coesion = 1;

        else

            coesion = curCOHESION * 3;

        end

        % Get the X and Y positions
        posx = curCENTROID(1);
        posy = curCENTROID(2);

        % Get the values to plot the circle
        y_c = coesion * cos( [ 0 : 10 : 360 ] * pi / 180 ) + posy;
        x_c = coesion * sin( [ 0 : 10 : 360 ] * pi / 180 ) + posx;

        % Plot the circle
        plot( x_c, y_c );

        % Fill the circle
        fill( x_c, y_c, color, 'EdgeColor', color, 'FaceAlpha', 0.2 );
        
    end
    
end

