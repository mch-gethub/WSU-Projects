clear all
clc
OpenFile
Initialization

for i=1 : trace_length-1
    
    SetBranchFlag
    CheckTraceInBTB

    
    TakenBranchInBTB
    TakenBranchWithWrongAddress
    NotTakenBranchInBTB
    BranchFirstTime
    RegularCommand
    
    
    
    
end
BTB = [Ptr PC' Target' GLOBAL(:,1) GLOBAL(:,2) GLOBAL(:,3) GLOBAL(:,4) Local' Seltr' Seltr_Dir_Array' GLOBAL_History_Array' Taken'];
Entry_Number = trace_length
BTB_index = 0 ;
for j=1:1024
    if(PC(j)~=0)
        BTB_index = BTB_index+1;
    end
end
BTB_Display(1:BTB_index,1:12) = 0;
BTB_index = 0;
for j=1:1024
    if(PC(j)~=0)
        BTB_index = BTB_index+1;
        BTB_Display(BTB_index,1:end) = BTB(j,1:end);
    end
end
%formatSepc = 'BTB_Display(1:end,1)'
fileID = fopen('BTB_output.txt','w');
fprintf(fileID,'%7d %7x %7x %7d %7d %7d %7d %7d %7d %7d %7d %7d \n', BTB_Display');
fclose(fileID);
Collissions_File = [Collisions_ptr' Collisions_trace' Collisions_PC'] ;
file_Collission = fopen('Collissions_File.txt','w');
fprintf(file_Collission,'%7d %7x %7x  \n', Collissions_File' );
fclose(file_Collission);

Hit
Miss = Branch_Miss_Counter
Wrong_Address = Branch_Wrong_Address_Counter
Wrong_Prediction_Local;
Right_Prediction_Local;
%fprintf("Hit=%1d  Miss=%1d  Wrong_Address=%1d  Wrong_Prediction_Local=%1d  Right_Prediction_Local=%1d \n" , Hit ,  Miss, Wrong_Address, Wrong_Prediction_Local, Right_Prediction_Local)
Right_Prediction_Local
Right_Prediction_GLOBAL
Right_Prediction_Final_Total
Wrong_Prediction_Local
Wrong_Prediction_GLOBAL
Wrong_Prediction_Final_Total
Collisions
Local_Counter
Global_Counter
