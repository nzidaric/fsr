#start output file
dir := DirectoryHome();;
str:="testWriteTEXstuff.tex";
nameWrite:=Filename(dir,str);
if IsExistingFile(nameWrite) then RemoveFile(nameWrite); fi;
output:=OutputTextFile(nameWrite,false);



AppendTo(output,"\\documentclass[12pt]{article}\n");
AppendTo(output,"\\usepackage[english]{babel}\n");
AppendTo(output,"\\usepackage{amsmath}\n\\usepackage{amssymb}\n");
AppendTo(output,"\\usepackage{array}\n");

AppendTo(output,"\\begin{document}\n");


K := GF(2);
H := GF(K,2);
G := GF(H,2);
G2 := GF(G,2);
G3 := GF(H, 4);

AppendTo(output,"\\noindent testing {\\tt WriteTEXFF}\\\\\n ");
WriteTEXFF(output, K); AppendTo(output, ", \n");
WriteTEXFF(output, H); AppendTo(output, ", \n");
WriteTEXFF(output, G); AppendTo(output, ", \n");
WriteTEXFF(output, G2); AppendTo(output, ",\n");
WriteTEXFF(output, G3); AppendTo(output, ", \\\\\n");


K := GF(2);
x := X(K,"x");
f := x^4+x^3+x^2+x+1;
F := FieldExtension(K,f);
w := RootOfDefiningPolynomial(F);
B := Basis(F, [w,w^2,w^4,w^8]);

strGen := "alpha";
gen := GeneratorOfField(F);
AppendTo(output, "\n\n\n\n");
AppendTo(output,"\\noindent switching to the finite field ");
WriteTEXFF(output, F); 
AppendTo(output,"\nwith defining polynomial  ");
WriteTEXFieldPolyByGenerator(output, F, f, "alpha", gen);
WriteTEXGeneratorWRTDefiningPolynomial(output, F,  "alpha", gen);
AppendTo(output,"\nusing the basis\\\\ \n");
WriteTEXBasisByGenerator(output, F, B, strGen, gen);
AppendTo(output, "\\\\\n\n\n\n");

AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXFFEByGenerator} and {\\tt WriteTEXFFE}:\\\\\n\n\\noindent ");
elm := w^4; 	WriteTEXFFEByGenerator(output, elm, strGen, gen); AppendTo(output, " = ");	WriteTEXFFE(output, B, elm); AppendTo(output, " \n");
elm := w^8; 	WriteTEXFFEByGenerator(output, elm, strGen, gen); AppendTo(output, " = ");	WriteTEXFFE(output, B, elm); AppendTo(output, ", \n");
elm := w^10; 	WriteTEXFFEByGenerator(output, elm, strGen, gen); AppendTo(output, " = ");	WriteTEXFFE(output, B, elm); AppendTo(output, ", \n");
elm := gen^3; 	WriteTEXFFEByGenerator(output, elm, strGen, gen); AppendTo(output, " = ");	WriteTEXFFE(output, B, elm); AppendTo(output, ", \n");
elm := gen^5; 	WriteTEXFFEByGenerator(output, elm, strGen, gen); AppendTo(output, " = ");	WriteTEXFFE(output, B, elm); AppendTo(output, ", \n");
elm := gen^10; 	WriteTEXFFEByGenerator(output, elm, strGen, gen); AppendTo(output, " = ");	WriteTEXFFE(output, B, elm); AppendTo(output, "\\\\\n\n\n\n");





vec := [w^4, w^12, elm];
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXFFEVecByGenerator} and {\\tt WriteTEXFFEVec}:\\\\\n\n\\noindent ");
WriteTEXFFEVecByGenerator(output, F, vec, strGen, gen); AppendTo(output, " = ");	WriteTEXFFEVec(output, B, vec); AppendTo(output, "\\\\ \n");


 AppendTo(output, "\n\n\n\n");
M := [ [ Z(2^4)^2, Z(2^4)^4, Z(2^4)^12, Z(2^4)^7 ], [ Z(2^4)^11, Z(2^4)^3, Z(2^4)^12, Z(2^4)^7 ], [ Z(2^4)^11, Z(2^4)^14, 0*Z(2), Z(2^4)^8 ] ];
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXFFEMatrix}:\n");
AppendTo(output, "\\begin{displaymath}\n");
WriteTEXFFEMatrix(output, B, M); 
AppendTo(output, "\\end{displaymath}\n");

 AppendTo(output, "\n\n\n\n");
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXFFEMatrixByGenerator}:\n");
AppendTo(output, "\\begin{displaymath}\n");
WriteTEXFFEMatrixByGenerator(output, F, M, strGen, gen); 
AppendTo(output, "\\end{displaymath}\n");


AppendTo(output, "\n\n\n\n");
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXUnivarFFPolyByGenerator}:\n");
WriteTEXUnivarFFPolyByGenerator(output, F, f, "x_0","alpha", gen);AppendTo(output, " \\\\\n");
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXFieldPolyByGenerator}:\n");
WriteTEXFieldPolyByGenerator(output, F, f, "alpha", gen);AppendTo(output, " \\\\\n");
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXLFSRPolyByGenerator}:\n");
WriteTEXLFSRPolyByGenerator(output, F, f, "alpha", gen);AppendTo(output, " \\\\\n");

AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXUnivarFFPolyByGenerator}:\n");
WriteTEXUnivarFFPolyByGenerator(output, F, w^4*x^15+w*x^11+x^5+gen^14, "z","alpha", gen);AppendTo(output, " \\\\\n");

 AppendTo(output, "\n\n\n\n");
AppendTo(output,"\n\\noindent testing {\\tt  WriteTEXMultivarFFPolyByGenerator}:\\\\\n");
mof1 := WriteTEXMultivarFFPolyByGenerator(output, F, x_0*x_2 + elm*x_1^12, "alpha", gen);AppendTo(output, ", \\quad");
mof2 := WriteTEXMultivarFFPolyByGenerator(output, F, x_0*x_2 + gen^13*x_1^120, "alpha", gen);AppendTo(output, ", \\quad");
mof3 := WriteTEXMultivarFFPolyByGenerator(output, F, x_10*x_12 + gen^13*x_11, "alpha", gen);AppendTo(output, ", \\quad");
mof4 := WriteTEXMultivarFFPolyByGenerator(output, F, s_10*s_12 + gen^13*s_11, "alpha", gen);AppendTo(output, ", \\quad");
# does not work for , need to redo 
mof5 := WriteTEXMultivarFFPolyByGenerator(output, F, x_0*x_2 + gen^13*x_1^121, "alpha", gen);AppendTo(output, " \\\\\n");


AppendTo(output, "\\clearpage\n");


AppendTo(output, "\n\n\n\n");
AppendTo(output,"\\noindent testing {\\tt WriteTEXElementTableByGenerator} : \\\\\n");
WriteTEXElementTableByGenerator(output, F, B, "alpha", gen);AppendTo(output, " \\\\\n");






K := GF(2);
x := X(K,"x");
f := x^4+x^3+1;
F := FieldExtension(K,f);
w := RootOfDefiningPolynomial(F);
B := Basis(F);
strGen := "alpha";
gen := GeneratorOfField(F);




AppendTo(output, "\\clearpage\n");
AppendTo(output, "\n\n\n\n");
AppendTo(output,"\\noindent switching to the finite field ");
WriteTEXFF(output, F); 
AppendTo(output,"\nwith defining polynomial  ");
WriteTEXFieldPolyByGenerator(output, F, f, "alpha", gen);AppendTo(output, ", where ");
WriteTEXGeneratorWRTDefiningPolynomial(output, F,  "alpha", gen);AppendTo(output, " \\\\\n");
AppendTo(output, "\n\n\n\n");
AppendTo(output,"\\noindent testing {\\tt WriteTEXElementTableByGenerator} : \\\\\n");
WriteTEXElementTableByGenerator(output, F, B, "alpha", gen);AppendTo(output, " \\\\\n");



AppendTo(output,"\\end{document}\n");
