
dirH := DirectoryHome();
imeF := "WriteTEXRunFSR.txt";
imefajla := Filename(dirH,  imeF);
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

  K := GF(2);;  y := X(K, "y");;
 l := y^3 + y + 1;;
 t1 :=  LFSR(K, l, [0,2]);

 ist := [   0*Z(2) ,  0*Z(2) ,   Z(2)^0  ];;


 
 WriteTEXRunFSR(output, t1, ist, 10);
  


 AppendTo(output, " * testing WriteAllFSR(output, t1, true) after run:\n");

 WriteAllFSR(output, t1, true);
 
 
   AppendTo(output, "\n\n\n\n");
 
   
 CloseStream(output);
 


 
 
 
Print("\nim done , where are u ? \n");
