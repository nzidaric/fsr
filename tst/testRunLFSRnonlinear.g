#testing the run of the LFSR with a external input

sequence1:=[];sequence2 :=[];sequence3 :=[];sequence4 :=[];sequence5 :=[];sequence6 :=[];
#############################################################################
#O  RunLFSR(<lfsr>, <elm>, <num>, <pr>) ...... VIII. run for num steps with the same external input on each step and with/without print to shell
K := GF(2); 
y := X(K, "y");
l := y^3 + y + 1;
t1 :=  LFSR(K, l);
elm := Z(2)^0;
Print(t1);
ist1 :=[0*Z(2), Z(2)^0, Z(2)^0 ];
seq0 := LoadLFSR(t1,ist1);
Print("test for RunLFSR(<lfsr>, <elm>, <num>, <pr>) VIII.\n");
sequence1 := RunLFSR(t1,elm, 10, true);
Add(sequence1,seq0,1);
Print(IntVecFFExt(sequence1));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
#O  RunLFSR(<lfsr>, <elm>)			  #IX.   run with the same external input on each step without print to shell
seq0 := LoadLFSR(t1,ist1);
Print("test for RunLFSR(<lfsr>, <elm>) IX.\n");
sequence2 := RunLFSR(t1,elm);
Add(sequence2,seq0,1);
Print(IntVecFFExt(sequence2));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 
check1:= true;
for i in [1.. Length(sequence1)] do 
	if sequence1[i]=sequence2[i] then check1 := check1 and true;
	else check1 := false;
	fi;
od;

Print("check if sequences from the two tests equal? : ",check1 ,"\n");

#O  RunLFSR(<lfsr>, <ist>, <elmvec>, <pr> ) .. X.    run for num steps with the different external input on each step with/without print to shell
elmvec := [Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0,Z(2)^0];

Print("test for RunLFSR(<lfsr>, <ist>, <elmvec>, <pr> ) X.\n");
sequence3 := RunLFSR(t1,ist1,elmvec,true);

Print(IntVecFFExt(sequence3));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 

if sequence2=sequence3 then check3:= true;
else check3:= false ;
fi;
Print("check if sequences from the three tests equal? : ",check1 and check3,"\n");
Print(IntVecFFExt(sequence1));Print("\n"); 
Print(IntVecFFExt(sequence2));Print("\n"); 
Print(IntVecFFExt(sequence3));Print("\n"); 
Print("\n"); Print("\n"); Print("\n"); 
#############################################################################
#O  RunLFSR(<lfsr>, <ist>, <elmvec>, <pr> ) .. X.    run for num steps with the different external input on each step with/without print to shell
elmvec := [Z(2)^0,0*Z(2),Z(2)^0,Z(2)^0,0*Z(2),0*Z(2),Z(2)^0,Z(2)^0,0*Z(2),Z(2)^0];
sequence4 := RunLFSR(t1,ist1,elmvec,true);
Print(IntVecFFExt(sequence4));Print("\n"); 
PrintAll(t1);
Print("\n"); Print("\n"); 



# if i dont reinitialize the ist1 somehow the previous LFSR keeps changing it !!!! 
# what happens if i create a copy of it when i Load ?  --> FIXED using ShallowCopy