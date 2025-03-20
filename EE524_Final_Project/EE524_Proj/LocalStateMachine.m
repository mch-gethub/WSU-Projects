%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      Local state machine setting for different condition          %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      When Branch is Taken  and it is in the table                 %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)
    if Target(BTB_ptr)==trace_dec(i+1)
        
        if(Local(BTB_ptr)==11)
            Local(BTB_ptr) = 11;
            Right_Prediction_Local = Right_Prediction_Local + 1 ;
            Right_Prediction_array_Local(BTB_ptr) = 1 ;
        elseif(Local(BTB_ptr) == 10)
            Local(BTB_ptr) = 11;
            Right_Prediction_Local = Right_Prediction_Local + 1 ;
            Right_Prediction_array_Local(BTB_ptr) = 1 ;
        elseif(Local(BTB_ptr)== 01 )
            Local(BTB_ptr) = 11;
            Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
            Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
        elseif(Local(BTB_ptr)==00)
            Local(BTB_ptr) = 01;
            Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
            Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
        end
    end
end









%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      When Branch is Not Taken                                     %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1)    
    if(Local(BTB_ptr)==11)
        Local(BTB_ptr) = 10;
        Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
        Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
    elseif(Local(BTB_ptr) == 10)
        Local(BTB_ptr) = 00;
        Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
        Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
    elseif(Local(BTB_ptr)== 01)
        Local(BTB_ptr) = 00;
        Right_Prediction_Local = Right_Prediction_Local + 1 ;
        Right_Prediction_array_Local(BTB_ptr) = 1 ;
    elseif(Local(BTB_ptr)==00)
        Local(BTB_ptr) = 00;
        Right_Prediction_Local = Right_Prediction_Local + 1 ;
        Right_Prediction_array_Local(BTB_ptr) = 1 ;
    end
end