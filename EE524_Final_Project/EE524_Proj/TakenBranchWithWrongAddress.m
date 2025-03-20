%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      A taken Branch which is in the Table with wrong address      %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)  % a taken Branch which is allready in the table
    if Target(BTB_ptr)~=trace_dec(i+1)            % checking for the wrong address
        
            Branch_Wrong_Address_Counter = Branch_Wrong_Address_Counter + 1 ; % Total number of wrong address
            Wrong_Address_Index(j) = i;
            j = j+1 ;
% % % % % % %             Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
% % % % % % %             Wrong_Prediction_array_Local(BTB_ptr) = 1 ;

            PC(BTB_ptr)=trace_dec(i); % Placing the Branch PC from the trace.txt in the BTB
            Target(BTB_ptr)=trace_dec(i+1); % Placing the target PC in the BTB table
            %Local(BTB_ptr) = 11 ; % Setting  the local column to 11 as strong taken Branch
            %GlobalHistorySetting     % Setting  the Global column to 11 as strong taken Branch
            %GLOBAL(BTB_ptr , 1) = 11 ; % Setting  the Global column to 11 as strong taken Branch
            %GLOBAL(BTB_ptr , 2) = 11 ; % Setting  the Global column to 11 as strong taken Branch
            %GLOBAL(BTB_ptr , 3) = 11 ; % Setting  the Global column to 11 as strong taken Branch 
            %GLOBAL(BTB_ptr , 4) = 11 ; % Setting  the Global column to 11 as strong taken Branch         
            if(Local(BTB_ptr)==11)
                Local(BTB_ptr) = 10;
                Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
                Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
            elseif(Local(BTB_ptr) == 10)
                Local(BTB_ptr) = 00;
                Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
                Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
            elseif(Local(BTB_ptr)== 01)
                Local(BTB_ptr) = 11;
                Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
                Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
            elseif(Local(BTB_ptr)==00)
                Local(BTB_ptr) = 01;
                Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
                Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
            end
            
            GlobalColumnSelection
            GlobalHistorySetting
            
            if(GLOBAL(BTB_ptr ,GLOBAL_History_column_Index)==11)
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 10;
                Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index) == 10)
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
                Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)== 01 )
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 11;
                Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1;
                Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)==00)
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 01;
                Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1;
                Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            end
            Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1;
            %%%%%%%%                ATTENTION                    %%%%%%%
            %%%%%%%% We are not doing anything regarding selector in this
            %%%%%%%% case, I am not sure what we need to do %%%%%%%%%%%%%
            %%%%%%%% the last modification sets this condition %%%%%%%%
            %%%%%%%% to a case with a taken brach which both local%%%%%%%%
            %%%%%%%% prediction and global predictions are wrong  %%%%%%%%
            
    end
end