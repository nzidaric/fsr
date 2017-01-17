#testing the step  of the LFSR

sequence :=[];sequence1 :=[];sequence2 :=[];
#############################################################################
#F  LFSR( <K>, <charpol> )  . . . . . . . . . .  create an LFSR object 	# len 2
Print("#F  LFSR( <K>, <charpol> )\n");
K := GF(2); 
y := X(K, "y");
l := y^3 + y + 1;
t1 :=  LFSR(K, l);
Print(t1);
ist1 :=[0*Z(2), 0*Z(2), Z(2)^0 ];
Add(sequence,LoadLFSR(t1,ist1));
PrintAll(t1);
for i in [1..9] do 
	Add(sequence,StepLFSR(t1)); # add to the end
od;
Print(IntVecFFExt(sequence));Print("\n"); 
Print(t1);
Print("\n"); 
Print("now with additional input 1:\n"); 
for i in [1..10] do 
	Add(sequence1,StepLFSR(t1,Z(2)^0)); # add to the end
od;
Print(IntVecFFExt(sequence1));Print("\n"); 
PrintAll(t1);
Print("test error case with additional input Z(2^4) :\n"); 
Print(StepLFSR((t1), Z(2^4)));
Print("\n"); 

Print("test error case with unloaded LFSR:\n"); 
t2 :=  LFSR(K, l);
Print(StepLFSR((t2), Z(2^4)));
Print("\n"); 


Print("All tests passed!!!");