    clear all
    clc

    fileID = fopen('Spice_FP_new.txt','r');
    [A] = fscanf(fileID,'%x %x %x %x %x %x');
    fclose(fileID);
    trace_dec(:)=A(:,1); %Values from the source file in decimal format.
    trace_dec=trace_dec';
    trace_length = length(trace_dec); %Total number of Trace.txt enries.
    BTB_length = 1024 ;
    PC(1:BTB_length)=0 ;
    Target(1:BTB_length)=0 ; % Branch Traget address.
    GLOBAL(1:BTB_length,1:4)= 00 ; %GLOBAL Prediction Variable with 4 columns for two bit history
    GLOBAL_History = 11 ;           %% Setting the GLOBAL History value to 11 as strong taken branches (two previous ones)
    GLOBAL_History_Array(1:BTB_length) = 00 ;
    GLOBAL_History_column_Index = 1 ;
    Local(1:BTB_length) = 00 ; % Local Branch Prediction Variable
    Seltr(1:BTB_length) = 01 ;
    Seltr_Dir = 00 ;
    Seltr_Dir_Array(1:BTB_length) = 0 ;
    Branch_Counter = 0 ;
    Branch_Wrong_Address_Counter = 0 ;
    Branch_Miss_Counter = 0 ;
    Wrong_Address_Index = 0 ;
    Taken(1:BTB_length) = 0 ;
    Hit = 0 ;
    Collisions = 0 ;
    Collisions_PC = 0 ;
    Collisions_trace = 0 ;
    Collisions_ptr = 0 ;
    k = 1 ;
    j = 1 ;
    BTB_ptr = 0 ;
    Ptr = (0:1023)' ;
    Final_Predictor(1:BTB_length) = 00 ;
    Wrong_Prediction_Local = 0 ;
    Right_Prediction_Final_Total = 0 ;
    Wrong_Prediction_Final_Total = 0 ;
    Right_Prediction_Local = 0 ;
    Wrong_Prediction_GLOBAL = 0 ;
    Right_Prediction_GLOBAL = 0 ;
    Wrong_Prediction_array_GLOBAL(1:BTB_length) = 0 ;
    Right_Prediction_array_GLOBAL(1:BTB_length) = 0 ;
    Wrong_Prediction_array_Local(1:BTB_length) = 0 ;
    Right_Prediction_array_Local(1:BTB_length) = 0 ;
    for i=1 : trace_length-1
        BTB_ptr = 1 + mod(trace_dec(i)/4,1024); % BTB Entry Number
        BTB_ptr_Array_temp(i) = BTB_ptr ;         %%%%%% checking the BTB pointers which are generated
        %%%%%%%%%%%%% Check if there is a branch or not (Comparing current PC and Next PC)
        if (trace_dec(i)+4 ~= trace_dec(i+1))
            Flag_trace_Jump = 1 ;
        else
            Flag_trace_Jump = 0;
        end
        %%%%%%%%%%%%% END Check if there is a branch or not (Comparing current PC and Next PC)

        %%%%%%%%%%%%% Check whether the current trace_dec(i) is in BTB
        if (PC(BTB_ptr) == trace_dec(i))
            Flag_PC_In_BTB = 1;
        else
            Flag_PC_In_BTB = 0;
        end
        %%%%%%%%%%%%% END Check whether the current trace_dec(i) is in BTB

        %%% This part is to check the branch status
        if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)  % a taken Branch which is allready in the table
            Hit = Hit + 1 ;
            Taken(BTB_ptr) = 1 ;
            %%%%Final Prediction
            if(Seltr(BTB_ptr)== 11 || Seltr(BTB_ptr)== 10)
                Final_Predictor(BTB_ptr) = Local(BTB_ptr);
            elseif(Seltr(BTB_ptr)== 01 || Seltr(BTB_ptr)== 00)
                Final_Predictor(BTB_ptr) = GLOBAL(BTB_ptr);
            else
            end
            if(Final_Predictor(BTB_ptr) == 11 || Final_Predictor(BTB_ptr) == 10)
                if((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1))
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1))
                    Wrong_Prediction_Final(BTB_ptr) = 1 ;
                    Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0))

                else
                end
            elseif(Final_Predictor(BTB_ptr) == 01 || Final_Predictor(BTB_ptr) == 00)
                if((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1))
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1))
                    Wrong_Prediction_Final(BTB_ptr) = 1 ;
                    Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0))

                else
                end
            end
            %%%End Finale Prediction
            %%%%Setting the Selecter
            if(GLOBAL_History == 00)
                GLOBAL_History_column_Index = 1 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History_column_Index = 2 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History_column_Index = 3 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History_column_Index = 4;
            else
            end

            if(Local(BTB_ptr)==11 || Local(BTB_ptr)==10)
                if(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==11 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==10) %%%%It shows that the local predictor predicts taken
                    Seltr_Dir = 11 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                elseif(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==01 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==00)
                    Seltr_Dir = 10 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                end
            elseif(Local(BTB_ptr)==01 || Local(BTB_ptr)==00)
                if(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==11 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==10) %%%%It shows that the local predictor predicts taken
                    Seltr_Dir = 01 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                elseif(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==01 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==00)
                    Seltr_Dir = 00 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                end
            end

            if  (Seltr_Dir == 10)
                if (Seltr(BTB_ptr) == 10)
                    Seltr(BTB_ptr) = 11 ;
                elseif(Seltr(BTB_ptr) == 01)
                    Seltr(BTB_ptr) = 10 ;
                elseif(Seltr(BTB_ptr) == 00)
                    Seltr(BTB_ptr) = 01 ;
                else
                    Seltr(BTB_ptr) = Seltr(BTB_ptr);
                end
            elseif(Seltr_Dir == 01)
                if(Seltr(BTB_ptr) == 10)
                    Seltr(BTB_ptr) = 01 ;
                elseif(Seltr(BTB_ptr) == 01)
                    Seltr(BTB_ptr) = 00 ;
                elseif(Seltr(BTB_ptr) == 00)
                    Seltr(BTB_ptr) = 00 ;
                elseif(Seltr(BTB_ptr) == 11)
                    Seltr(BTB_ptr) = 10 ;
                end
            else
                Seltr(BTB_ptr) = Seltr(BTB_ptr) ;
            end
            %%%%End Selecter Part

            if Target(BTB_ptr)==trace_dec(i+1) % Target address is in the table
                %%%%%This part of the program is related to set the value of
                %%%%%Local Prediction when Branch is taken and it is in the
                %%%%%table.
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
                %%%%%End of the program which is related to set the value of
                %%%%%Local Prediction when Branch is taken and it is in the
                %%%%%table.

                %%%%%%GH1 Setting the GLOBAL_History value whenever a taken branch has
                %%%%%%happend
                if(GLOBAL_History == 00)
                    GLOBAL_History = 01 ;
                elseif(GLOBAL_History == 01)
                    GLOBAL_History = 11 ;
                elseif(GLOBAL_History == 10)
                    GLOBAL_History = 01 ;
                elseif(GLOBAL_History == 11)
                    GLOBAL_History = 11 ;
                else
                end
                %%%%%This part of the program is related to set the value of
                %%%%%GLOBAL Prediction when Branch is taken and it is in the
                %%%%%table.
                if(GLOBAL_History == 00)
                    GLOBAL_History_column_Index = 1 ;
                elseif(GLOBAL_History == 01)
                    GLOBAL_History_column_Index = 2 ;
                elseif(GLOBAL_History == 10)
                    GLOBAL_History_column_Index = 3 ;
                elseif(GLOBAL_History == 11)
                    GLOBAL_History_column_Index = 4;
                else
                end
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
                    Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                    Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
                elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)==00)
                    GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 01;
                    Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                    Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
                end
                %%%%%End of the program which is related to set the value of
                %%%%%GLOBAL Prediction when Branch is taken and it is in the
                %%%%%table.
                %%%%%%End of GH1


            else
                Branch_Wrong_Address_Counter = Branch_Wrong_Address_Counter + 1 ; % Total number of Miss Branches
                Wrong_Address_Index(j) = i;
                j = j+1 ;
                Wrong_Prediction_Local = Wrong_Prediction_Local + 1 ;
                Wrong_Prediction_array_Local(BTB_ptr) = 1 ;
                if (PC(BTB_ptr)~=trace_dec(i) && PC(BTB_ptr)~= 0 )
                    Collisions = Collisions + 1 ;
                    Collisions_PC (k) = PC(BTB_ptr)  ;
                    Collisions_trace (k) = trace_dec(i) ;
                    Collisions_ptr (k) = BTB_ptr
                    k = k+1 ;
                end
                PC(BTB_ptr)=trace_dec(i); % Placing the Branch PC from the trace.txt in the BTB
                Target(BTB_ptr)=trace_dec(i+1); % Placing the target PC in the BTB table
                Local(BTB_ptr) = 11 ; % Setting  the local column to 11 as strong taken Branch

                if(GLOBAL_History == 00)
                    GLOBAL_History = 01 ;
                elseif(GLOBAL_History == 01)
                    GLOBAL_History = 11 ;
                elseif(GLOBAL_History == 10)
                    GLOBAL_History = 01 ;
                elseif(GLOBAL_History == 11)
                    GLOBAL_History = 11 ;
                else
                end
                if(GLOBAL_History == 00)
                    GLOBAL_History_column_Index = 1 ;
                elseif(GLOBAL_History == 01)
                    GLOBAL_History_column_Index = 2 ;
                elseif(GLOBAL_History == 10)
                    GLOBAL_History_column_Index = 3 ;
                elseif(GLOBAL_History == 11)
                    GLOBAL_History_column_Index = 4;
                else
                end
                GLOBAL(BTB_ptr , GLOBAL_History_column_Index) = 11 ;

            end






        elseif(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1) % a not taken Branch
            Hit = Hit + 1 ;
            Taken(BTB_ptr) = 0 ;
            %%%%Final Prediction
            if(Seltr(BTB_ptr)== 11 || Seltr(BTB_ptr)== 10)
                Final_Predictor(BTB_ptr) = Local(BTB_ptr);
            elseif(Seltr(BTB_ptr)== 01 || Seltr(BTB_ptr)== 00)
                Final_Predictor(BTB_ptr) = GLOBAL(BTB_ptr);
            else
            end
            if(Final_Predictor(BTB_ptr) == 11 || Final_Predictor(BTB_ptr) == 10)
                if((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1))
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1))
                    Wrong_Prediction_Final(BTB_ptr) = 1 ;
                    Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0))

                else
                end
            elseif(Final_Predictor(BTB_ptr) == 01 || Final_Predictor(BTB_ptr) == 00)
                if((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1))
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1))
                    %Wrong_Prediction_Final(BTB_ptr) = 1 ;
                    %Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1 ;
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0))

                else
                end
            end
            %%%End Final Prediction

            %%%%Setting the Selecter
            if(GLOBAL_History == 00)
                GLOBAL_History_column_Index = 1 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History_column_Index = 2 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History_column_Index = 3 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History_column_Index = 4;
            else
            end

            if(Local(BTB_ptr)==11 || Local(BTB_ptr)==10)
                if(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==11 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==10) %%%%It shows that the local predictor predicts taken
                    Seltr_Dir = 00 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                elseif(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==01 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==00)
                    Seltr_Dir = 01 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                end
            elseif(Local(BTB_ptr)==01 || Local(BTB_ptr)==00)
                if(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==11 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==10) %%%%It shows that the local predictor predicts taken
                    Seltr_Dir = 10 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                elseif(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==01 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==00)
                    Seltr_Dir = 11 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                end
            end

            if  (Seltr_Dir == 10)
                if (Seltr(BTB_ptr) == 10)
                    Seltr(BTB_ptr) = 11 ;
                elseif(Seltr(BTB_ptr) == 01)
                    Seltr(BTB_ptr) = 10 ;
                elseif(Seltr(BTB_ptr) == 00)
                    Seltr(BTB_ptr) = 01 ;
                else
                    Seltr(BTB_ptr) = Seltr(BTB_ptr);
                end
            elseif(Seltr_Dir == 01)
                if(Seltr(BTB_ptr) == 10)
                    Seltr(BTB_ptr) = 01 ;
                elseif(Seltr(BTB_ptr) == 01)
                    Seltr(BTB_ptr) = 00 ;
                elseif(Seltr(BTB_ptr) == 00)
                    Seltr(BTB_ptr) = 00 ;
                elseif(Seltr(BTB_ptr) == 11)
                    Seltr(BTB_ptr) = 10 ;
                end
            else
                Seltr(BTB_ptr) = Seltr(BTB_ptr) ;
            end
            %%%%End Selecter Part

            %%%%%%GH2 Setting the GLOBAL_History value whenever a not taken branch has
            %%%%%%happend
            if(GLOBAL_History == 00)
                GLOBAL_History = 00 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History = 10 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History = 00 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History = 10 ;
            else
            end

            if(GLOBAL_History == 00)
                GLOBAL_History_column_Index = 1 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History_column_Index = 2 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History_column_Index = 3 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History_column_Index = 4;
            else
            end

            if(GLOBAL(BTB_ptr ,GLOBAL_History_column_Index)==11)
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 10;
                Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
                %Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
                %Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index) == 10)
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
                Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
                %Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
                %Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)== 01 )
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
                Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
                Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
                %Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                %Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            elseif(GLOBAL(BTB_ptr,GLOBAL_History_column_Index)==00)
                GLOBAL(BTB_ptr,GLOBAL_History_column_Index) = 00;
                Right_Prediction_GLOBAL = Right_Prediction_GLOBAL + 1 ;
                Right_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
                %Wrong_Prediction_GLOBAL = Wrong_Prediction_GLOBAL + 1 ;
                %Wrong_Prediction_array_GLOBAL(BTB_ptr) = 1 ;
            end
            %%%%%End of the program which is related to set the value of
            %%%%%GLOBAL Prediction when Branch is taken and it is in the
            %%%%%table.
            %%%%%End of GH2

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





        elseif(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0) % the first time we see the branch for the current entry
            if trace_dec(i) == 4381628
                flag = i;
            end
            Taken(BTB_ptr) = 1 ;
            %%%%Final Prediction
            if(Seltr(BTB_ptr)== 11 || Seltr(BTB_ptr)== 10)
                Final_Predictor(BTB_ptr) = Local(BTB_ptr);
            elseif(Seltr(BTB_ptr)== 01 || Seltr(BTB_ptr)== 00)
                Final_Predictor(BTB_ptr) = GLOBAL(BTB_ptr);
            else
            end
            if(Final_Predictor(BTB_ptr) == 11 || Final_Predictor(BTB_ptr) == 10)
                if((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1))
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1))
                    Wrong_Prediction_Final(BTB_ptr) = 1 ;
                    Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0))

                else
                end
            elseif(Final_Predictor(BTB_ptr) == 01 || Final_Predictor(BTB_ptr) == 00)
                if((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1))
                    Right_Prediction_Final(BTB_ptr) = 1 ;
                    Right_Prediction_Final_Total = Right_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1))
                    Wrong_Prediction_Final(BTB_ptr) = 1 ;
                    Wrong_Prediction_Final_Total = Wrong_Prediction_Final_Total + 1 ;
                elseif((Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0))

                else
                end
            end
            %%%End Finale Prediction

            %%%%Setting the Selecter
            if(GLOBAL_History == 00)
                GLOBAL_History_column_Index = 1 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History_column_Index = 2 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History_column_Index = 3 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History_column_Index = 4;
            else
            end

            if(Local(BTB_ptr)==11 || Local(BTB_ptr)==10)
                if(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==11 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==10) %%%%It shows that the local predictor predicts taken
                    Seltr_Dir = 11 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                elseif(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==01 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==00)
                    Seltr_Dir = 10 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                end
            elseif(Local(BTB_ptr)==01 || Local(BTB_ptr)==00)
                if(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==11 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==10) %%%%It shows that the local predictor predicts taken
                    Seltr_Dir = 01 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                elseif(GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==01 || GLOBAL(BTB_ptr, GLOBAL_History_column_Index)==00)
                    Seltr_Dir = 00 ;
                    Seltr_Dir_Array(BTB_ptr) = Seltr_Dir ;
                end
            end

            if  (Seltr_Dir == 10)
                if (Seltr(BTB_ptr) == 10)
                    Seltr(BTB_ptr) = 11 ;
                elseif(Seltr(BTB_ptr) == 01)
                    Seltr(BTB_ptr) = 10 ;
                elseif(Seltr(BTB_ptr) == 00)
                    Seltr(BTB_ptr) = 01 ;
                else
                    Seltr(BTB_ptr) = Seltr(BTB_ptr);
                end
            elseif(Seltr_Dir == 01)
                if(Seltr(BTB_ptr) == 10)
                    Seltr(BTB_ptr) = 01 ;
                elseif(Seltr(BTB_ptr) == 01)
                    Seltr(BTB_ptr) = 00 ;
                elseif(Seltr(BTB_ptr) == 00)
                    Seltr(BTB_ptr) = 00 ;
                elseif(Seltr(BTB_ptr) == 11)
                    Seltr(BTB_ptr) = 10 ;
                end
            else
                Seltr(BTB_ptr) = Seltr(BTB_ptr) ;
            end
            %%%%End Selecter Part

            if (PC(BTB_ptr)~=trace_dec(i) && PC(BTB_ptr)~= 0 )
                Collisions = Collisions + 1 ;
                Collisions_PC (k) = PC(BTB_ptr)  ;
                Collisions_trace (k) = trace_dec(i) ;
                Collisions_ptr (k) = BTB_ptr ;
                k = k+1 ;
            end
            PC(BTB_ptr)=trace_dec(i); % Placing the Branch PC from the trace.txt in the BTB
            Target(BTB_ptr)=trace_dec(i+1); % Placing the target PC in the BTB table
            Local(BTB_ptr) = 11 ; % Setting  the local column to 11 as strong taken Branch

            %%%%%%%%%%%%%%%
            if(GLOBAL_History == 00)
                GLOBAL_History = 01 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History = 11 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History = 01 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History = 11 ;
            else
            end

            if(GLOBAL_History == 00)
                GLOBAL_History_column_Index = 1 ;
            elseif(GLOBAL_History == 01)
                GLOBAL_History_column_Index = 2 ;
            elseif(GLOBAL_History == 10)
                GLOBAL_History_column_Index = 3 ;
            elseif(GLOBAL_History == 11)
                GLOBAL_History_column_Index = 4;
            else
            end
            GLOBAL(BTB_ptr , GLOBAL_History_column_Index ) = 11 ; %Setting all the GLOBAL History columns to 11 as strong Taken branch
            Branch_Miss_Counter = Branch_Miss_Counter + 1 ; % Total number of Miss Branches
        elseif(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==0) % regular command, Nothing to do.

        end
        GLOBAL_History_Array(BTB_ptr) = GLOBAL_History ; 
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
    fileID = fopen('BTB_output_Spice_FP.txt','w');
    fprintf(fileID,'%7d %7x %7x %7d %7d %7d %7d %7d %7d %7d %7d %7d \n', BTB_Display');
    fclose(fileID);
    Collissions_File = [Collisions_ptr' Collisions_trace' Collisions_PC'] ;
    file_Collission = fopen('Collissions_File_Spice_FP.txt','w');
    fprintf(file_Collission,'%7d %7x %7x  \n', Collissions_File' );
    fclose(file_Collission);

    Hit
    Miss = Branch_Miss_Counter
    Wrong_Address = Branch_Wrong_Address_Counter
    Wrong_Prediction_Local
    Right_Prediction_Local
    fprintf("Hit=%1d  Miss=%1d  Wrong_Address=%1d  Wrong_Prediction_Local=%1d  Right_Prediction_Local=%1d \n" , Hit ,  Miss, Wrong_Address, Wrong_Prediction_Local, Right_Prediction_Local)
