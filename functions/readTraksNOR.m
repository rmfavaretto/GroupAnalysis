function trk = readTraksNOR(fileName)

fid = fopen(fileName, 'r');

i = 0;
len = fscanf(fid,'%d');
while (len) > 0    
    i = i + 1;
    
    A = fscanf(fid,'(%d,%d,%d)');
    
    B = round(A);
     
    trk(i).x = B(1:3:end);
    trk(i).y = B(2:3:end);
    trk(i).t = B(3:3:end);
   
    len = fscanf(fid,'%d');
end
fclose(fid);
