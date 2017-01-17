#testing the run of the LFSR

sequence1:=[];sequence2 :=[];sequence3 :=[];sequence4 :=[];sequence5 :=[];sequence6 :=[];
#############################################################################
#O  RunLFSR( <lfsr> , <pr> ) ................ III. run with/without print to shell
K := GF(2); 
y := X(K, "y");
l := y^3 + y + 1;
t1 :=  LFSR(K, l);
Print(t1);
ist1 :=[0*Z(2), Z(2)^0, Z(2)^0 ];
seq0 := LoadLFSR(t1,ist1);
Print("test for RunLFSR(lfsr, true) III. run with/without print to shell\n");
sequence3 := RunLFSR(t1,true);
Add(sequence3,seq0,1);
Print(IntVecFFExt(sequence3));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
#O  RunLFSR( <lfsr> ) ....................... IV.  run without print to shell
seq0 := LoadLFSR(t1,ist1);
Print("test for RunLFSR(lfsr) IV.  run without print to shell \n");
sequence4 := RunLFSR(t1);
Add(sequence4,seq0,1);
Print(IntVecFFExt(sequence4));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
if sequence3=sequence4 then check3:= true;
else check3:= false ;
fi;
Print("check if sequences from the two tests equal? \nRunLFSR( <lfsr> , <pr> )=?RunLFSR( <lfsr> ) : ",check3,"\n");
Print("\n"); Print("\n"); Print("\n"); 
#############################################################################
#O  RunLFSR( <lfsr> , <num>, <pr> ) ......... I.   run for num steps with/without print to shell
seq0 := LoadLFSR(t1,ist1);
Print("test for RunLFSR(lfsr,num, true) I.   run for num steps with/without print to shell\n");
sequence1 := RunLFSR(t1,5,true);
Add(sequence1,seq0,1);
Print(IntVecFFExt(sequence1));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
#O  RunLFSR( <lfsr> , <num> ) ............... II.  run for num steps without print to shell
seq0 := LoadLFSR(t1,ist1);
Print("test for RunLFSR(lfsr,num) I.   run for num steps with/without print to shell\n");
sequence2 := RunLFSR(t1, 5);
Add(sequence2,seq0,1);
Print(IntVecFFExt(sequence2));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
if sequence1=sequence2 then check1:= true;
else check1:= false ;
fi;
Print("check if sequences from the two tests equal? \nRunLFSR( <lfsr> , <num>, <pr> )=?RunLFSR( <lfsr>, <num> ) : ",check1,"\n");
Print("\n"); Print("\n"); Print("\n"); 

#############################################################################
#O  RunLFSR( <lfsr> , <ist>, <num>, <pr>) ... V.   load new initial state then run for num-1 steps with/without print to shell
Print("test for RunLFSR(lfsr, ist, num, true) V.   load new initial state then run for num-1 steps with/without print to shell\n");
sequence5 := RunLFSR(t1, ist1, 5, true);
Print(IntVecFFExt(sequence5));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
#O  RunLFSR( <lfsr> , <ist>, <num>) ......... VI.  load new initial state then run for num-1 steps without print to shell
Print("test for RunLFSR(lfsr, ist, num) VI.  load new initial state then run for num-1 steps without print to shell\n");
sequence6 := RunLFSR(t1, ist1, 5);
Print(IntVecFFExt(sequence6));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
if sequence5=sequence6 then check2:= true;
else check2:= false ;
fi;
Print("check if sequences from the two tests equal? \nRunLFSR( <lfsr> , <ist>, <num>, <pr>)=?RunLFSR( <lfsr> , <ist>, <num>) : ",check2,"\n");
Print("\n"); Print("\n"); Print("\n"); 

#O  RunLFSR( <lfsr> , <ist>) ................ VII. load new initial state then run without print to shell
Print("test for RunLFSR(lfsr, ist) VII. load new initial state then run without print to shell\n");
sequence7 := RunLFSR(t1, ist1);
Print(IntVecFFExt(sequence7));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
check7:= true;
for i in [1.. Length(sequence6)] do 
	if sequence6[i]=sequence7[i] then check7 := check7 and true;
	else check7 := false;
	fi;
od;

Print("check if first num elements of last sequence equal to previous test? : ",check7,"\n");
Print("\n"); Print("\n"); Print("\n"); 


Print("All tests passed?  ", (check1 and check2 and check3 and check7));

# if i dont reinitialize the ist1 somehow the previous LFSR keeps changing it !!!! 
# what happens if i create a copy of it when i Load ?  --> FIXED using ShallowCopy