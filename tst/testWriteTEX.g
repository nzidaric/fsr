#start output file
dir := DirectoryHome();;
str:="testWriteTEX.tex";
nameWrite:=Filename(dir,str);
if IsExistingFile(nameWrite) then RemoveFile(nameWrite); fi;
output:=OutputTextFile(nameWrite,false);



AppendTo(output,"\\documentclass[12pt]{article}\n");
AppendTo(output,"\\usepackage[english]{babel}\n");
AppendTo(output,"\\usepackage{amsmath}\n\\usepackage{amssymb}\n");
AppendTo(output,"\\usepackage{array}\n");

AppendTo(output,"\\begin{document}\n");

	K := GF(2);;  x := X(K, "x");;  
 	y := X(K, "y");; l := y^3 + y + 1;;
 	lfsr :=  LFSR(K, l);

 AppendTo(output, "\\noindent LFSR testing WriteTEXAllFSR(output, lfsr, false, strGen, gen):\\\\\n");
 WriteTEXAllFSR(output, lfsr, false, "alpha", GeneratorOfField(K));

 AppendTo(output, "\n\n\n\n");


K := GF(2);
x := X(K,"x");
f := x^4+x^3+x^2+x+1;
F := FieldExtension(K,f);
w := RootOfDefiningPolynomial(F);
B := Basis(F, [w,w^2,w^4,w^8]);

l := y^3 + y + w;;
 	lfsr :=  LFSR(F, l, B);

strGen := "alpha";
gen := GeneratorOfField(F);

 AppendTo(output, "\n\n\n\n\\noindent ");

 WriteTEXAllFSR(output, lfsr, false, strGen, gen);

 AppendTo(output, "\n\n\n\n\\noindent ");
 WriteTEXAllFSR(output, lfsr, true, strGen, gen);

 ist := [ 0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
 LoadFSR(lfsr, ist);

 AppendTo(output, "\n\n\n\n\\noindent ");
 WriteTEXAllFSR(output, lfsr, true, strGen, gen); 
 
AppendTo(output, "\\clearpage\n");
 AppendTo(output, "\\noindent LFSR testing WriteTEXRunFSR(output, lfsr, ist, 5, strGen, gen):\\\\\n"); 
   AppendTo(output, "\n\n\n\n\\noindent ");
 WriteTEXRunFSR(output, lfsr, ist, 5, strGen, gen);
 
 AppendTo(output, "\\\\\n\n\n\n ");
 AppendTo(output, "\\noindent LFSR testing  WriteTEXRunFSRByGenerator(output, lfsr, ist, 5, strGen, gen):\\\\\n"); 
 
 WriteTEXRunFSRByGenerator(output, lfsr , ist, 5, strGen, gen);

 
 

	F := GF(2);; B:= Basis(F);; 
 	mpoly := x_0*x_1 + x_2;;
 	nlfsr:= NLFSR(F, mpoly, 3);
 	ist := [ 0*Z(2) ,  Z(2)^0 ,  Z(2)^0  ];;



AppendTo(output, "\\clearpage\n");
AppendTo(output, "\\noindent NLFSR testing WriteTEXAllFSR(output, nlfsr, false, strGen, gen):\\\\\n");
WriteTEXAllFSR(output, nlfsr, false, "alpha", GeneratorOfField(K));

 AppendTo(output, "\\\\\n\n\n\n");


 AppendTo(output, "\\noindent NLFSR testing  WriteTEXRunFSRByGenerator(output, nlfsr, ist, 5, strGen, gen):\\\\\n"); 
 
 WriteTEXRunFSRByGenerator(output, nlfsr , ist, 5, "alpha", GeneratorOfField(K));

 AppendTo(output, "\\\\\n\n\n\n");


 ist := [ s_2, s_1, s_0];; 
 sequence :=  RunFSR(nlfsr,  ist, 5);
 
AppendTo(output, "\\noindent NLFSR testing SYMBOLIC  \\\\\n WriteTEXSequenceFSRByGenerato(output, nlfsr, seq, strGen, gen) for initial state \n");
 WriteTEXSymVecByGenerator(output, F, ist, strGen, GeneratorOfField(F));
AppendTo(output, "\\quad after 5 steps:\\\\\n");
 

 WriteTEXSequenceFSRByGenerator(output, nlfsr, sequence, strGen, GeneratorOfField(F));
 
  AppendTo(output, "\n\n\n\n");
 
 
 
AppendTo(output,"\\end{document}\n");


CloseStream(output);