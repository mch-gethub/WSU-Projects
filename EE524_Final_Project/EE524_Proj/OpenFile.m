fileID = fopen('Spice_FP_new.txt','r');
[A] = fscanf(fileID,'%x %x %x %x %x %x');
fclose(fileID);