#testing the constructors for the LFSR package 
#and the WriteAllLFSR to write them in a file
dir := DirectoryHome();;
str:="GAPLFSR/testLFSR_WriteAllLFSR_B2.txt";
nameWrite:=Filename(dir,str);
if IsExistingFile(nameWrite) then RemoveFile(nameWrite); fi;
output:=OutputTextFile(nameWrite,false);



#############################################################################
#F  LFSR( <K>, <charpol> )  . . . . . . . . . .  create an LFSR object 	# len 2
Print("#F  LFSR( <K>, <charpol> )\n");
AppendTo(output, "#F  LFSR( <K>, <charpol> )\n");

K := GF(2); 
y := X(K, "y");
l := y^3 + y + 1;
t1 :=  LFSR(K, l);
B := Basis(K);
PrintAll(B,t1);
WriteAllLFSR(output,B,t1);
AppendTo(output, "----====####====----\n");
#############################################################################
#F  LFSR( <K>, <fieldpol>, <charpol>)					# len 3
Print("#F  LFSR( <K>, <fieldpol>, <charpol>)\n");
AppendTo(output,"#F  LFSR( <K>, <fieldpol>, <charpol>)\n");

K := GF(2); 
x := X(K, "x");
f := x^4 + x^3 + 1;
F := FieldExtension(K, f);
y := X(F, "y");
l := y^4+ y+ Z(2^4);
t2 := LFSR(K, f, l);
B := Basis(F);
PrintAll(B,t2);
WriteAllLFSR(output,B,t2);
AppendTo(output, "----====####====----\n");
#############################################################################
#F  LFSR( <F>, <charpol>)						# len 2
F := FieldExtension(K, f);
Print("#F  LFSR( <F>, <charpol>)\n");
AppendTo(output,"#F  LFSR( <F>, <charpol>)\n");

t3 := LFSR(F, l);
B := Basis(F);
PrintAll(B,t3);
WriteAllLFSR(output,B,t3);
AppendTo(output, "----====####====----\n");
#############################################################################
#F  LFSR( <p>, <m>, <n>  )						# len 3
Print("#F  LFSR( <p>, <m>, <n>  )\n");
AppendTo(output,"#F  LFSR( <p>, <m>, <n>  )\n");

p := 3; m:= 2; n := 5;
t4 := LFSR(p, m, n);
B := Basis(GF(p^m));
PrintAll(B,t4);
WriteAllLFSR(output,B,t4);
AppendTo(output, "----====####====----\n");
Print("\n Now the versions with selected taps\n");
AppendTo(output,"\n Now the versions with selected taps\n");
#############################################################################
#F  LFSR( <K>, <charpol>, <tap> ) 					# len 3
Print("#F  LFSR( <K>, <charpol>, <tap> )\n");
AppendTo(output,"#F  LFSR( <K>, <charpol>, <tap> )\n");

K := GF(2); 
y := X(K, "y");
l := y^3 + y + 1;
tap := 0;
t5 :=  LFSR(K, l, tap);
B := Basis(K);
PrintAll(B,t5);
WriteAllLFSR(output,B,t5);
AppendTo(output, "----====####====----\n");
tap := 2;
t5 :=  LFSR(K, l, tap);
B := Basis(K);
PrintAll(B,t5);
WriteAllLFSR(output,B,t5);
AppendTo(output, "----====####====----\n");
tap := 5;
t5 :=  LFSR(K, l, tap);
B := Basis(K);
PrintAll(B,t5);
WriteAllLFSR(output,B,t5);
AppendTo(output, "----====####====----\n");
tap := [0,2];
t5 :=  LFSR(K, l, tap);
B := Basis(K);
PrintAll(B,t5);
WriteAllLFSR(output,B,t5);
AppendTo(output, "----====####====----\n");
#############################################################################
#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)				# len 4
Print("#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)\n");
AppendTo(output,"#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)\n");

K := GF(2); 
x := X(K, "x");
f := x^4 + x^3 + 1;
F := FieldExtension(K, f);
y := X(F, "y");
l := y^4+ y+ Z(2^4);
tap := 1;
t6 := LFSR(K, f, l, tap);
B := Basis(F);
PrintAll(B,t6);
WriteAllLFSR(output,B,t6);
AppendTo(output, "----====####====----\n");
tap := [0,2,3];
t6 := LFSR(K, f, l, tap);
PrintAll(B,t6);
WriteAllLFSR(output,B,t6);
AppendTo(output, "----====####====----\n");
tap := 9;
t6 := LFSR(K, f, l, tap);
PrintAll(B,t6);
WriteAllLFSR(output,B,t6);
AppendTo(output, "----====####====----\n");
#############################################################################
#F  LFSR( <F>, <charpol>, <tap>)					# len 3
F := FieldExtension(K, f);
Print("#F  LFSR( <F>, <charpol>, <tap>)\n");
AppendTo(output,"#F  LFSR( <F>, <charpol>, <tap>)\n");

tap := 1;
t7 := LFSR(F, l, tap);
B := Basis(F);
PrintAll(B,t7);
WriteAllLFSR(output,B,t7);
AppendTo(output, "----====####====----\n");
#############################################################################
#F  LFSR( <p>, <m>, <n>, <tap>  )					# len 4
Print("#F  LFSR( <p>, <m>, <n>, <tap>  )\n");
AppendTo(output,"#F  LFSR( <p>, <m>, <n>, <tap>  )\n");

p := 2; m:= 2; n := 5;
taps := [0,3,9];
t8 := LFSR(p, m, n,taps);
B := Basis(F);
PrintAll(B,t8);
WriteAllLFSR(output,B,t8);
AppendTo(output, "----====####====----\n");

CloseStream(output);
Print("All tests passed!!!");