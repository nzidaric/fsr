
dirH := DirectoryHome();
imeF := "WriteTEXRunFSR2.txt";
imefajla := Filename(dirH,  imeF);
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

  K := GF(2);;  x := X(K, "x");;
  

f:= x^3+x+Z(2)^0 ;;  F := FieldExtension(K, f);;                               
 ChooseField(F);; 

 clist := [ One(F), One(F)];;
 mlist := [x_0, x_0*x_1*x_2];;
 t5 := NLFSR(F, clist, mlist, 3);
sequence :=[];
ist := [Z(2^3)^2,Z(2^3),One(F)];;




 
 WriteTEXRunFSR(output, t5, ist, 10);
 





   
 CloseStream(output);
 


 
 
 
Print("\nim done , where are u ? \n");
