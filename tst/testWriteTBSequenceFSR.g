
dirH := DirectoryHome();
imeF := "WriteTBSequenceFSR.txt";
imefajla := Filename(dirH,  imeF);
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

 K := GF(2);;  
x := X(K, "x");;
 f := x^4 + x^3 + 1;; F := FieldExtension(K, f);;
 y := X(F, "y");; l := y^4+ y+ Z(2^4);;
 t3 := LFSR(K, f, l, [0,2]);
 
sequence :=[];
 ist := [  Z(2^4) ,  0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
 
 sequence :=  WriteRunFSR(output, t3, ist, 20);  
  
   AppendTo(output, "* testing WriteAllFSR(output, t3, false) after run :\n");
 
WriteAllFSR(output, t3, false);

   AppendTo(output, "* testing WriteTBSequenceFSR(output, t3, sequence) after run :\n");
WriteTBSequenceFSR(output, t3, sequence);

 
    
 
 CloseStream(output);
 
 
 
Print("\nim done , where are u ? \n");
