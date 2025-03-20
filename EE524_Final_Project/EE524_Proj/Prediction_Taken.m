function[Right_Prediction_Local2, Wrong_Prediction_Local2,Right_Prediction_Global2,Wrong_Prediction_Global2,Right_Prediction_Final_Total2,Wrong_Prediction_Final_Total2]=Prediction_Taken(Local, Global, Final_Predictor, Right_Prediction_Local2, Wrong_Prediction_Local2,Right_Prediction_Global2,Wrong_Prediction_Global2,Right_Prediction_Final_Total2,Wrong_Prediction_Final_Total2,GLOBAL_History)
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
            if(Local == 11 || Local== 10)
                Right_Prediction_Local2 = Right_Prediction_Local2 + 1 ;
            end
            if(Local == 01 || Local== 00)
                Wrong_Prediction_Local2 = Wrong_Prediction_Local2 + 1 ;
            end
            if(Global(GLOBAL_History_column_Index) == 11 || Global(GLOBAL_History_column_Index)== 10)
                Right_Prediction_Global2 = Right_Prediction_Global2 + 1 ;
            end
            if(Global(GLOBAL_History_column_Index) == 01 || Global(GLOBAL_History_column_Index)== 00)
                Wrong_Prediction_Global2 = Wrong_Prediction_Global2 + 1 ;
            end
            
            if(Final_Predictor == 11 || Final_Predictor== 10)
                Right_Prediction_Final_Total2 = Right_Prediction_Final_Total2 + 1 ;
            end
            if(Final_Predictor == 01 || Final_Predictor== 00)
                Wrong_Prediction_Final_Total2 = Wrong_Prediction_Final_Total2 + 1 ;
            end