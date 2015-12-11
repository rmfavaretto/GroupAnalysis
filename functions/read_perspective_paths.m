function [ pathsPER ] = read_perspective_paths ( trackPER )
    
    % Variável para armazenar os dados
    pathsPER = [];

    % Laço que realiza a leitura das trajetórias
    for i = 1:length(trackPER)
        curTrk = trackPER(i);
        curX1 = curTrk.x(1:1:end);
        curX2 = curTrk.y(1:1:end);
        curT = curTrk.t(1:1:end);
        curX = [curX1(1:end-1) curX2(1:end-1)];
        curV = [curX1(2:end)-curX1(1:end-1) curX2(2:end)-curX2(1:end-1)];      
        curXV = [curX curV curT(1:end-1) ones(size(curX,1),1)*i];
        pathsPER = [pathsPER; curXV];
    end
    
end

