%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%     Selector next state setting for taken Branch which is in the table      %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)
if Target(BTB_ptr)==trace_dec(i+1)
%%%%%%%%%%%%%%%%%%%%%%%              Selector Direction Setting                           %%%%%%%%%%%%%%%%%%%%%    

GlobalColumnSelection    
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
     
    
    
 %%%%%%%%%%%%%%%%%%%%%%%    Selector next state setting based on selector direction       %%%%%%%%%%%%%%%%%%%%%
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
end
end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%     Selector next state setting for Not taken                               %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1)
%%%%%%%%%%%%%%%%%%%%%%%              Selector Direction Setting                           %%%%%%%%%%%%%%%%%%%%%
       
GlobalColumnSelection
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

 %%%%%%%%%%%%%%%%%%%%%%%    Selector next state setting based on selector direction       %%%%%%%%%%%%%%%%%%%%%
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
 
end
