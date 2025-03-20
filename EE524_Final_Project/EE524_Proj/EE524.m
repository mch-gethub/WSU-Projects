clear all ;
clc ;

fileID = fopen('trace_sample.txt','r');
[A] = fscanf(fileID,'%x %x %x %x %x %x');
fclose(fileID);
trace_dec(:)=A(:,1);
trace_dec=trace_dec';
trace_length = length(trace_dec);
BTB_length = 1024 ; 
PC(1:BTB_length)=0 ; 
Target(1:BTB_length)=0 ; 
GLOBAL(1:BTB_length,1:4)=0 ; 
Local(1:BTB_length) = 0 ; 
Seltr(1:BTB_length) = 0 ; 
Branch_Counter = 0 ;
% BTB_ptr = 0 ; 
Ptr = (0:1023)' ; 
for i=1 : trace_length-1
    if (trace_dec(i)+4 ~= trace_dec(i+1))
       Branch_Counter = Branch_Counter + 1 ;
       BTB_ptr = 1 + mod(trace_dec(i),1024)/4 ; 
       PC(BTB_ptr)=trace_dec(i);
       Target(BTB_ptr)=trace_dec(i+1);
       
    end
end
BTB = [Ptr PC' Target' GLOBAL(:,1) GLOBAL(:,2) GLOBAL(:,3) GLOBAL(:,4) Local' Seltr'];
Entry_Number = trace_length 
BTB_index = 0 ;
for j=1:1024
    if(PC(j)~=0)
        BTB_index = BTB_index+1;
    end
end
BTB_Display(1:BTB_index,1:9) = 0;
BTB_index = 0;
for j=1:1024
    if(PC(j)~=0)
        BTB_index = BTB_index+1;
         BTB_Display(BTB_index,1:end) = BTB(j,1:end);
    end
end
%formatSepc = 'BTB_Display(1:end,1)'
fileID = fopen('BTB_output.txt','w');
fprintf(fileID,'%7d %7x %7d %7d %7d %7d %7d %7d %7d \n', BTB_Display');
fclose(fileID);
Branch_Counter 
BTB_index