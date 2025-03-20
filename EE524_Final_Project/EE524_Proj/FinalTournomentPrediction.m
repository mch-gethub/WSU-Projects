%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%     Selecting final prediction from local and Global and wrong/right prediction     %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Seltr(BTB_ptr)== 11 || Seltr(BTB_ptr)== 10)
    Final_Predictor(BTB_ptr) = Local(BTB_ptr);
    Local_Counter = Local_Counter + 1 ;
elseif(Seltr(BTB_ptr)== 01 || Seltr(BTB_ptr)== 00)
    Final_Predictor(BTB_ptr) = GLOBAL(BTB_ptr,GLOBAL_History_column_Index);
    Global_Counter = Global_Counter + 1 ;
else
    printf("error in tournoment setting")
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%                  wrong/right prediction                                             %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)
    if(Final_Predictor(BTB_ptr)==01 || Final_Predictor(BTB_ptr)==00)
        Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1;
    elseif(Final_Predictor(BTB_ptr)==11 || Final_Predictor(BTB_ptr)==10)
        Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1;
    else
        printf("error final prediction1")
    end
elseif(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1)
    if(Final_Predictor(BTB_ptr)==01 || Final_Predictor(BTB_ptr)==00)
        Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1;
    elseif(Final_Predictor(BTB_ptr)==11 || Final_Predictor(BTB_ptr)==10)
        Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1;
    else
        printf("error final prediction2")
    end
else
end
