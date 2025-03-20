%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%              Branch for the first time                            %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if(Flag_trace_Jump == 1) && (Flag_PC_In_BTB ==0) % the first time we see the branch for the current entry

        Taken(BTB_ptr) = 1 ;
        Branch_Miss_Counter = Branch_Miss_Counter + 1 ; % Total number of Miss Branches

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%%               Finding Collision       %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
        if (PC(BTB_ptr)~=trace_dec(i) && PC(BTB_ptr)~= 0 )
            Collisions = Collisions + 1 ;
            Collisions_PC (k) = PC(BTB_ptr)  ;
            Collisions_trace (k) = trace_dec(i) ;
            Collisions_ptr (k) = BTB_ptr ;
            k = k+1 ;
        end
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%% Setting the BTB table PC and Target for the first time 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        PC(BTB_ptr)=trace_dec(i); % Placing the Branch PC from the trace.txt in the BTB
        Target(BTB_ptr)=trace_dec(i+1); % Placing the target PC in the BTB table
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%% Setting value of local, global and slector for the first time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        Seltr(BTB_ptr) = 10 ;       % Setting  the local column to 11 as strong taken Branch
        Local(BTB_ptr) = 11 ;       % Setting  the local column to 11 as strong taken Branch
        GLOBAL(BTB_ptr , 1 ) = 11 ; %Setting all the GLOBAL History columns to 11 as strong Taken branch
        GLOBAL(BTB_ptr , 2 ) = 11 ; %Setting all the GLOBAL History columns to 11 as strong Taken branch
        GLOBAL(BTB_ptr , 3 ) = 11 ; %Setting all the GLOBAL History columns to 11 as strong Taken branch
        GLOBAL(BTB_ptr , 4 ) = 11 ; %Setting all the GLOBAL History columns to 11 as strong Taken branch
        
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%% Setting value of local, global and slector for the first time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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