%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      A taken Branch which is in the Table %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)  % a taken Branch which is allready in the table
    if Target(BTB_ptr)==trace_dec(i+1)
        
        Taken(BTB_ptr) = 1 ;
        Hit = Hit + 1 ;
        
        GlobalColumnSelection
        FinalTournomentPrediction
        
        GlobalColumnSelection
        [Right_Prediction_Local2, Wrong_Prediction_Local2,Right_Prediction_GLOBAL2,Wrong_Prediction_GLOBAL2,Right_Prediction_Final_Total2,Wrong_Prediction_Final_Total2]=Prediction_Taken(Local(BTB_ptr), GLOBAL(BTB_ptr,1:4), Final_Predictor(BTB_ptr), Right_Prediction_Local2, Wrong_Prediction_Local2,Right_Prediction_GLOBAL2,Wrong_Prediction_GLOBAL2,Right_Prediction_Final_Total2,Wrong_Prediction_Final_Total2,GLOBAL_History);
        
        SelectorStateMachine
        LocalStateMachine
        GlobalStateMachine
        
             
        
    end
end