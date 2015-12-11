function [  ] = trajectory_smoothness( dir, file, type, tamF, flag )
% dir: diretório onde se encontra o arquivo
% file: nome do arquivo a ser suavizado
% type: tipo do arquivo a ser gravado
% tamF: tamanho do filtro (deve ser IMPAR)
% Quanto maior o valor de n, maior será a suavização
% As extremidades de cada trajetória sao ignoradas [(n/2)-0.5 pontos] 

fid = fopen([dir, file, '.', type],'r');

if (flag == 'D')
    factor = fscanf(fid,'[%d]');
end

i = 0;
len = fscanf(fid,'%d');
while (len) > 0    
    i = i + 1;
    
    A = fscanf(fid,'(%f,%f,%f)');
     
    trk(i).x = A(1:3:end);
    trk(i).y = A(2:3:end);
    trk(i).t = A(3:3:end);
   
    len = fscanf(fid,'%d');
end
fclose(fid);


% aplica o filtro 
mfilter = ones(1,tamF)/tamF;
fileID = fopen([dir, file, '_filtered', '.', type],'w');

if (flag == 'D')
    fprintf(fileID, '[%d]', factor);
    fprintf(fileID,'\n');
end

for i=1: size(trk,2)
   x = trk(i).x; 
   y = trk(i).y; 
   t = trk(i).t; 
   
   xf = conv(x,mfilter,'valid');
   yf = conv(y,mfilter,'valid');
   
   t_i = floor(tamF/2)+1;
   t_f = size(y,1)-floor(tamF/2);
   
   trk(i).x(t_i:t_f) = xf;
   trk(i).y(t_i:t_f) = yf;
   
   fprintf(fileID,'%d ',size(x,1));
   for k=1: size(x,1)
       fprintf(fileID,'(%d,%d,%d)',round(trk(i).x(k)),round(trk(i).y(k)),trk(i).t(k));
   end
   fprintf(fileID,'\n');

end
fclose(fileID);