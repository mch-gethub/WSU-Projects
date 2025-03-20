%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      Global state machine setting for different condition          %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      also global history setting is called and set here            %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%  When Branch is Taken  and it is in the table with correct address  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)
    if Target(BTB_ptr)==trace_dec(i+1)
        
        
        GlobalColumnSelection
        GlobalHistorySetting
        
        if(GLOBAL(BTB_ptr ,GLOBAL_History_column_Index)==11)
            GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 11;
            Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
            Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
        elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index) == 10)
            GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 11;
            Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
            Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
        elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)== 01 )
            GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 11;
            Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1; 
            Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
        elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)==00)
            GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 01;
            Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1; 
            Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
        end
        
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      When Branch is Not Taken                                     %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1)
    
    
    GlobalColumnSelection
    GlobalHistorySetting
    
    
    if(GLOBAL(BTB_ptr ,GLOBAL_History_column_Index)==11)
        GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 10;
        Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1; 
        Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
    elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index) == 10)
        GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
        Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1; 
        Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
    elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)== 01 )
        GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
        Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
        Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
    elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)==00)
        GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
        Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
        Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
    end
end