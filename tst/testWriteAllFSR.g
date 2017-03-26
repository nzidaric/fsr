
dirH := DirectoryHome();
imeF := "WriteAllFSR.txt";
imefajla := Filename(dirH,  imeF);
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

 K := GF(2);;  y := X(K, "y");;
 l := y^3 + y + 1;;
 t1 :=  LFSR(K, l);

 AppendTo(output, "* testing WriteAllFSR(output, t1, false):\n");
 
 WriteAllFSR(output, t1, false);

 AppendTo(output, " * testing WriteAllFSR(output, t1, true):\n");

 WriteAllFSR(output, t1, true);
 
 
x := X(K, "x");; f := x^4 + x^3 + 1;;
 F := FieldExtension(K, f);;B := Basis(F);;
t2 := LFSR(F, l);
 
  AppendTo(output, "* testing WriteAllFSR(output, t2, false):\n");
 
 WriteAllFSR(output, t2, false);

 AppendTo(output, " * testing WriteAllFSR(output, t2, true):\n");

 WriteAllFSR(output, t2, true);
 

 f := x^4 + x^3 + 1;; F := FieldExtension(K, f);;
 y := X(F, "y");; l := y^4+ y+ Z(2^4);;
 t3 := LFSR(K, f, l);
 
  
  AppendTo(output, "* testing WriteAllFSR(output, t3, false):\n");
 
 WriteAllFSR(output, t3, false);

 AppendTo(output, " * testing WriteAllFSR(output, t3, true):\n");

 WriteAllFSR(output, t3, true);
 
sequence :=[];
 ist := [  Z(2^4) ,  0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
 
 Add(sequence, LoadFSR(t3,ist));
 
 
   AppendTo(output, "* testing WriteAllFSR(output, t3, false) after loading :\n");
 
 WriteAllFSR(output, t3, false);

 AppendTo(output, " * testing WriteAllFSR(output, t3, true) after loading:\n");

 WriteAllFSR(output, t3, true);
 

 Add(sequence, RunFSR(t3, 20)); 
  
   AppendTo(output, "* testing WriteAllFSR(output, t3, false) after run :\n");
 
 WriteAllFSR(output, t3, false);

 AppendTo(output, " * testing WriteAllFSR(output, t3, true) after run:\n");

 WriteAllFSR(output, t3, true);
 
 
 
F := GF(2);; B:= Basis(F);; ChooseField(F);;  
 
 clist := [One(F), One(F)];;
 mlist := [x_0*x_1, x_2];;
 t4 := NLFSR(F, clist, mlist, 3);



 AppendTo(output, "* testing WriteAllFSR(output, t4, false):\n");
 
 WriteAllFSR(output, t4, false);

 AppendTo(output, " * testing WriteAllFSR(output, t4, true):\n");

 WriteAllFSR(output, t4, true);

sequence :=[];

ist := [One(F),Zero(F),Zero(F)];; 

 Add(sequence, LoadFSR(t4,ist));
 
 
   AppendTo(output, "* testing WriteAllFSR(output, t4, false) after loading :\n");
 
 WriteAllFSR(output, t4, false);

 AppendTo(output, " * testing WriteAllFSR(output, t4, true) after loading:\n");

 WriteAllFSR(output, t4, true);
 
 
 
 Add(sequence, RunFSR(t4)); 

  
   AppendTo(output, "* testing WriteAllFSR(output, t4, false) after run :\n");
 
 WriteAllFSR(output, t4, false);

 AppendTo(output, " * testing WriteAllFSR(output, t4, true) after run:\n");

 WriteAllFSR(output, t4, true);

 
 
 
 f:= x^3+x+Z(2)^0 ;;  F := FieldExtension(K, f);;                               
 ChooseField(F);; 

 clist := [ One(F), One(F)];;
 mlist := [x_0, x_0*x_1*x_2];;
 t5 := NLFSR(F, clist, mlist, 3);
sequence :=[];
ist := [Z(2^3)^2,Z(2^3),One(F)];;

 AppendTo(output, "* testing WriteAllFSR(output, t5, false):\n");
 
 WriteAllFSR(output, t5, false);

 AppendTo(output, " * testing WriteAllFSR(output, t5, true):\n");

 WriteAllFSR(output, t5, true);

 Add(sequence, LoadFSR(t5,ist));
 
 
   AppendTo(output, "* testing WriteAllFSR(output, t5, false) after loading :\n");
 
 WriteAllFSR(output, t5, false);

 AppendTo(output, " * testing WriteAllFSR(output, t5, true) after loading:\n");

 WriteAllFSR(output, t5, true);
 
 
 
 Append(sequence, RunFSR(t5, 30)); 

  
   AppendTo(output, "* testing WriteAllFSR(output, t5, false) after run :\n");
 
 WriteAllFSR(output, t5, false);

 AppendTo(output, " * testing WriteAllFSR(output, t5, true) after run:\n");

 WriteAllFSR(output, t5, true);



   AppendTo(output, "* sequence produced by run  t5 :\n");
    AppendTo(output, sequence,"\n");
    
    
       AppendTo(output, "* sequence produced by run  t5 using basis :\n");
 
    WriteVector(output, WhichBasis(t5), sequence);
    
    
 
 CloseStream(output);
 
 
 
Print("\nim done , where are u ? \n");
