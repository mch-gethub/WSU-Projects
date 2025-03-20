%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      Global History Setting in all condition                       %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%  When Branch is Taken  and it is in the table or is not in the table  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==1)
    
if Target(BTB_ptr)==trace_dec(i+1)  % It is in the table
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
end

if Target(BTB_ptr)~=trace_dec(i+1)   % it is not in the table  ( seems it is similar to when it is in the table ) 
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
end

end






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%  When Branch is Not Taken    %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 0) && (Flag_PC_In_BTB ==1)

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
end