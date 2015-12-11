function [ trackPER, mFACTOR ] = readTraksPER( fileName )

fid = fopen(fileName, 'r');

mFACTOR = fscanf(fid,'[%d]');

i = 0;
len = fscanf(fid,'%f');
while (len) > 0    
    i = i + 1;
    
    A = fscanf(fid,'(%f,%f,%f)');
    
    B = round(A);
     
    trackPER(i).x = B(1:3:end);
    trackPER(i).y = B(2:3:end);
    trackPER(i).t = B(3:3:end);
   
    len = fscanf(fid,'%f');
end
fclose(fid);