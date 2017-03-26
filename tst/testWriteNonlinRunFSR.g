
dirH := DirectoryHome();
imeF := "WriteNonlinRunFSR.txt";
imefajla := Filename(dirH,  imeF);
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

K := GF(2);; x := X(K, "x");;
 f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
y := X(F, "y");; l := y^4+ y+ Z(2^4);;
t10 := LFSR(K, f, l);
ist :=[0*Z(2), Z(2^4), Z(2^4)^5, Z(2)^0 ];; 
elmvec := [Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14];;

 sequence := WriteNonlinRunFSR(output, t10, ist, elmvec);

  


 AppendTo(output, " * testing WriteAllFSR(output, t10, true) after run:\n");

 WriteAllFSR(output, t10, true);
 
 
   AppendTo(output, "\n\n\n\n");
 
  

    
    AppendTo(output, "\n\n\n\n");
 
 f:= x^3+x+Z(2)^0 ;;  F := FieldExtension(K, f);;                               
 ChooseField(F);; 

 clist := [ One(F), One(F)];;
 mlist := [x_0, x_0*x_1*x_2];;
 t5 := NLFSR(F, clist, mlist, 3);
sequence :=[];
ist := [Z(2^3)^2,Z(2^3),One(F)];;

elmvec := [Z(2^3)^2, Z(2^3)^2, Z(2)^0, Z(2^3)^7, Z(2^3)^3, Z(2^3)^2, Z(2^3)^2, Z(2^3)^4];;


 sequence := WriteNonlinRunFSR(output, t5, ist, elmvec);
 


 AppendTo(output, " * testing WriteAllFSR(output, t5, true) after run:\n");

 WriteAllFSR(output, t5, true);



  
 CloseStream(output);
 
 
 
Print("\nim done , where are u ? \n");
