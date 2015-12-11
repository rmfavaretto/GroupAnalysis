function [  ] = plot_relevance_all( radio, posx, posy, cor)
    if ( radio < 0 )
        radio = 1;
    else
        radio = radio * 11;
    end
    y_c=radio*cos( [ 0 : 10 : 360 ] * pi / 180 ) + posy;
    x_c=radio*sin( [ 0 : 10 : 360 ] * pi / 180 ) + posx;
    plot( x_c, y_c );
    fill( x_c, y_c, cor, 'EdgeColor', cor, 'FaceAlpha', 0.2 );
end
