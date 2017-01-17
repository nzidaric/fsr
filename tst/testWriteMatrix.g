#start output file
dir := DirectoryHome();;
str:="LFSRjan13/testWriteMatrixExpected.txt";
nameWrite:=Filename(dir,str);
if IsExistingFile(nameWrite) then RemoveFile(nameWrite); fi;
output:=OutputTextFile(nameWrite,false);


K :=GF(2);
x :=X(K,"x");
#f :=x^2+x+1;
f :=x^4+x^3+x^2+x+1;
F :=FieldExtension(K,f);
w := RootOfDefiningPolynomial(F);
B := Basis(GF(2^4));
B1 := Basis(F);
B2 := Basis(F, [w,w^2,w^4,w^8]);

AppendTo(output,"finite field with def. poly ",f,"\n");


AppendTo(output," *  writing a matrix over ext field: \n");


AppendTo(output,"-----===========================-----\n");
AppendTo(output,"using Basis(GF(2^4))",BasisVectors(B),"\n");
AppendTo(output," *  writing basis elms: \n");
WriteVector(output,B,B);
AppendTo(output,"\n\n\n");

M := [ [ Z(2^4)^2, Z(2^4)^4, Z(2^4)^12, Z(2^4)^7 ], [ Z(2^4)^11, Z(2^4)^3, Z(2^4)^12, Z(2^4)^7 ], [ Z(2^4)^11, Z(2^4)^14, 0*Z(2), Z(2^4)^8 ] ];
AppendTo(output," -  AppendTo directly : \n");	
	AppendTo(output,M,"\n");
AppendTo(output," -  using WriteVector for B: \n");
	WriteVector(output,B,M);
	AppendTo(output,"\n");	
AppendTo(output," -  using WriteMatrix: \n");
	WriteMatrix(output,B,M);
	AppendTo(output,"\n");	
AppendTo(output,"\n\n\n");
	

AppendTo(output,"-----===========================-----\n");
AppendTo(output,"using canonical basis",BasisVectors(B1),"\n");
AppendTo(output," *  writing basis elms: \n");
WriteVector(output,B,B1);
AppendTo(output,"\n\n\n");
	
AppendTo(output," -  AppendTo directly : \n");	
	AppendTo(output,M,"\n");
AppendTo(output," -  using WriteVector for B: \n");
	WriteVector(output,B1,M);
	AppendTo(output,"\n");	
AppendTo(output," -  using WriteMatrix: \n");
	WriteMatrix(output,B1,M);
	AppendTo(output,"\n");	
AppendTo(output,"\n\n\n");
		
	
	

AppendTo(output,"-----===========================-----\n");	

AppendTo(output,"using normal basis",BasisVectors(B2),"\n");
AppendTo(output," *  writing basis elms: \n");
WriteVector(output,B,B2);
AppendTo(output,"\n\n\n");	
AppendTo(output," -  AppendTo directly : \n");	
	AppendTo(output,M,"\n");
AppendTo(output," -  using WriteVector for B: \n");
	WriteVector(output,B2,M);
	AppendTo(output,"\n");	
AppendTo(output," -  using WriteMatrix: \n");
	WriteMatrix(output,B2,M);
	AppendTo(output,"\n");		
AppendTo(output,"\n\n\n");
		
	
	
	
CloseStream(output);
Print("All done!!!");