#start output file
dir := DirectoryHome();;
str:="testDrawTEX.tex";
nameWrite:=Filename(dir,str);
if IsExistingFile(nameWrite) then RemoveFile(nameWrite); fi;
output:=OutputTextFile(nameWrite,false);



AppendTo(output,"\\documentclass[12pt]{article}\n");
AppendTo(output,"\\usepackage[english]{babel}\n");
AppendTo(output,"\\usepackage{amsmath}\n\\usepackage{amssymb}\n");
AppendTo(output,"\\usepackage{array}\n");
AppendTo(output,"\\usepackage{tikz}\n");

AppendTo(output,"\\begin{document}\n");

	K := GF(2);;  x := X(K, "x");;  
 	y := X(K, "y");; l := y^3 + y + 1;;
 	lfsr :=  LFSR(K, l);


 AppendTo(output, "\\noindent LFSR testing TikzWSimple\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzWSimple_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzWSimple_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzW\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzW_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzW_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzNSimple\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 

 TikzNSimple_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzNSimple_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzN\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzN_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzN_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 
  
 
 AppendTo(output, "\\clearpage\n\n\n\n"); 


 

	K := GF(2^2);;  x := X(K, "x");;  
 	y := X(K, "y");; l :=y^5 +  Z(2^2)*y^2 + 1;;
 	lfsr :=  LFSR(K, l, [0,3]);


 AppendTo(output, "\\noindent LFSR testing TikzWComplex\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzWComplex_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzWComplex_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));

 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzW\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzW_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzW_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));

 AppendTo(output, "\\clearpage\n\n\n\n"); 

 
 AppendTo(output, "\\noindent LFSR testing TikzNComplex\\_?LFSR(output, lfsr, alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzNComplex_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzNComplex_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzN\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzN_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzN_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));

 AppendTo(output, "\\clearpage\n\n\n\n"); 
	K := GF(2^2);;  x := X(K, "x");;  
 	y := X(K, "y");; l :=y^5 +  Z(2^2)*y^2 +  Z(2^2)^2;;
 	lfsr :=  LFSR(K, l, [0,3]);


 AppendTo(output, "\\noindent LFSR testing TikzWComplex\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzWComplex_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzWComplex_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));

 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzW\\_?LFSR(output, lfsr, alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzW_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzW_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));


 AppendTo(output, "\\clearpage\n\n\n\n");  
 AppendTo(output, "\\noindent LFSR testing TikzNComplex\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzNComplex_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzNComplex_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 AppendTo(output, "\\noindent LFSR testing TikzN\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzN_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzN_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 
 
 
	F := GF(2);;  x := X(F, "x");; f := x^4 + x^3 +1;  
	K := FieldExtension(F, f);	
	gen := GeneratorOfField(K);
 	y := X(K, "y");; l :=y^4 + y^3 + y +  gen;;
 	lfsr :=  LFSR(K, l, [0,2]);
 
 AppendTo(output, "\\noindent LFSR testing TikzW\\_?LFSR(output, lfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 TikzW_LFSR(output, lfsr, "alpha", GeneratorOfField(K));
 TikzW_extLFSR(output, lfsr, "alpha", GeneratorOfField(K));
 AppendTo(output, "\\clearpage\n\n\n\n"); 
 
 
#### NLFSR




	K := GF(2);; 
 	mpoly := x_0*x_1 + x_2;;
 	nlfsr:= NLFSR(K, mpoly, 3);
 	
 	AppendTo(output, "\\clearpage\n\n\n\n");  
   AppendTo(output, "\\noindent NLFSR testing TikzWSimple\\_?NLFSR(output, nlfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 	TikzWSimple_NLFSR(output, nlfsr,  "alpha", GeneratorOfField(K));
 
 
 

	F := GF(2);;  x := X(F, "x");; f := x^4 + x^3 +1;  
	K := FieldExtension(F, f);	
	gen := GeneratorOfField(K);
 	mpoly := gen^7*x_0*x_1 + gen*x_5;;
 	nlfsr:= NLFSR(K, mpoly, 7, [0,1,2,3]);
 	
 	AppendTo(output, "\\clearpage\n\n\n\n");  
   AppendTo(output, "\\noindent NLFSR testing TikzWSimple\\_?NLFSR(output, nlfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 	TikzWSimple_NLFSR(output, nlfsr,  "alpha", GeneratorOfField(K));
 	
 		AppendTo(output, "\\clearpage\n\n\n\n");  

 	TikzWSimple_extNLFSR(output, nlfsr,  "alpha", GeneratorOfField(K));
 
 	AppendTo(output, "\\clearpage\n\n\n\n");  
   AppendTo(output, "\\noindent NLFSR testing TikzNSimple\\_?NLFSR(output, nlfsr,  alpha, GeneratorOfField(K)):\\\\\n"); 
 	TikzNSimple_NLFSR(output, nlfsr,  "alpha", GeneratorOfField(K));
 	
		AppendTo(output, "\\clearpage\n\n\n\n");  

 	TikzNSimple_extNLFSR(output, nlfsr,  "alpha", GeneratorOfField(K));
 
AppendTo(output,"\\end{document}\n");


CloseStream(output);