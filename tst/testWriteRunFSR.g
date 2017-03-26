
dirH := DirectoryHome();
imeF := "WriteRunFSR.txt";
imefajla := Filename(dirH,  imeF);
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

  K := GF(2);;  y := X(K, "y");;
 l := y^3 + y + 1;;
 t1 :=  LFSR(K, l, [0,2]);

 ist := [   0*Z(2) ,  0*Z(2) ,   Z(2)^0  ];;


 
 WriteRunFSR(output, t1, ist, 10);
  


 AppendTo(output, " * testing WriteAllFSR(output, t1, true) after run:\n");

 WriteAllFSR(output, t1, true);
 
 
   AppendTo(output, "\n\n\n\n");
 
  
 
 K := GF(2);;   x := X(K, "x");;
 f := x^4 + x^3 + 1;; F := FieldExtension(K, f);;
 y := X(F, "y");; l := y^4+ y+ Z(2^4);;
 t3 := LFSR(K, f, l);
 
  
  
 
sequence :=[];
 ist := [  Z(2^4) ,  0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
 
 WriteRunFSR(output, t3, ist, 5);
 

 AppendTo(output, " * testing WriteAllFSR(output, t3, true) after run:\n");

 WriteAllFSR(output, t3, true);
 
 
    
    AppendTo(output, "\n\n\n\n");
 
 f:= x^3+x+Z(2)^0 ;;  F := FieldExtension(K, f);;                               
 ChooseField(F);; 

 clist := [ One(F), One(F)];;
 mlist := [x_0, x_0*x_1*x_2];;
 t5 := NLFSR(F, clist, mlist, 3);
sequence :=[];
ist := [Z(2^3)^2,Z(2^3),One(F)];;




 WriteRunFSR(output, t5, ist, 30);
 


 AppendTo(output, " * testing WriteAllFSR(output, t5, true) after run:\n");

 WriteAllFSR(output, t5, true);




 
 
 
Print("\nim done , where are u ? \n");
