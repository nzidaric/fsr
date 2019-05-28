
dirH := DirectoryHome();
imefajla := Filename(dirH,  "testWrite.txt");
Print("Writing to file : ",imefajla,"\n");
if IsExistingFile(imefajla) then RemoveFile(imefajla);  fi;
output := OutputTextFile(imefajla,  false);

 	K := GF(2);;  x := X(K, "x");;  
 	y := X(K, "y");; l := y^3 + y + 1;;
 	t1 :=  LFSR(K, l);

 AppendTo(output, " * LFSR testing WriteAllFSR(output, t1, true):\n");
 WriteAllFSR(output, t1, true);

	F := FieldExtension(K, x^4 + x^3 + 1);;B := Basis(F);;
	t2 := LFSR(F, l);
  
 sequence :=[];
 ist := [ 0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
 
 Add(sequence, LoadFSR(t2,ist));
 
 AppendTo(output, "* LFSR testing WriteAllFSR(output, t2, false) after loading :\n");
 WriteAllFSR(output, t2, false);

 sequence :=  RunFSR(t2, ist, 5); 
 
  
 AppendTo(output, "* sequence produced by run  t2 using basis :\n");
 WriteFFEVec(output, WhichBasis(t2), sequence);
 AppendTo(output,"\n");   

 AppendTo(output, " * LFSR testing WriteAllFSR(output, t2, true) after run:\n");
 WriteAllFSR(output, t2, true);
 
 sequence :=[];
 ist := [ 0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
 sequence := RunFSR(t2, ist, 5);
  
  
 AppendTo(output, "* LFSR testing WriteAllFSR(output, t2, false) after run :\n");
 WriteAllFSR(output, t2, false);

  
  
 AppendTo(output, "* LFSR testing WriteRunFSR(output, t2,  ist, 5):\n");
 WriteRunFSR(output, t2,  ist, 5);

  
  
 AppendTo(output, "* LFSR testing WriteExternalRunFSR(output, t2,  ist, [Z(2^4), Z(2^4)^5, Z(2)^0]):\n");
 WriteExternalRunFSR(output, t2,  ist, [Z(2^4), Z(2^4)^5, Z(2)^0]);


	F := FieldExtension(K, x^4 + x^3 + 1);;B := Basis(F);;
	t2 := LFSR(F, l, [0,2]); 
 

    ist := [ s_2, s_1, s_0];; 
 AppendTo(output, "* LFSR testing WriteRunFSR(output, t2,  ist, 5):\n");
 WriteRunFSR(output, t2,  ist, 5);
 
   



	F := GF(2);; B:= Basis(F);; 
 	mpoly := x_0*x_1 + x_2;;
 	t3 := NLFSR(F, mpoly, 3);
 	 ist := [ 0*Z(2) ,  Z(2)^0 ,  Z(2)^0  ];;

 sequence := RunFSR(t3, ist, 5); 
 AppendTo(output, "* NLFSR testing WriteAllFSR(output, t3, false) after run :\n");
 WriteAllFSR(output, t3, false);
 
     ist := [ s_2, s_1, s_0];; 
 
  AppendTo(output, "* NLFSR testing WriteExternalRunFSR(output, t3,  ist, [s_20, s_21, s_22, s_23]):\n");
 WriteExternalRunFSR(output, t2,  ist,[s_20, s_21, s_22, s_23]);

	t4 := FILFUN(F, mpoly);;   
 
 AppendTo(output, " * FILFUN testing WriteAllFSR(output, t4, false):\n");
 WriteAllFSR(output, t4, false);

   ist := [ 0*Z(2) ,  Z(2)^0 ,  Z(2)^0  ];;
  
 
  sequence :=[];
  ist := [s_2, s_1, s_0];; 
  LoadFSR(t4, ist );
  
 AppendTo(output, "* FILFUN testing WriteAllFSR(output, t4, true)  :\n");
 WriteAllFSR(output, t4, true);



    
 CloseStream(output);
 
 
 
Print("\nim done , where are u ? \n");
