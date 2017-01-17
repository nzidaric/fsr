#start output file
dir := DirectoryHome();;
str:="LFSRjan13/testWriteVectorExpected.txt";
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

AppendTo(output,"-----===========================-----\n");
AppendTo(output,"finite field with def. poly ",f,"\n");
AppendTo(output,"using Basis(GF(2^4))",BasisVectors(B),"\n");
AppendTo(output," *  writing basis elms: \n");
WriteVector(output,B,B);
AppendTo(output,"\n\n\n");
AppendTo(output,"using canonical basis",BasisVectors(B1),"\n");
WriteVector(output,B,B1);
AppendTo(output,"\n\n\n");
AppendTo(output,"using normal basis",BasisVectors(B2),"\n");
AppendTo(output," *  writing basis elms: \n");
WriteVector(output,B,B2);
AppendTo(output,"\n\n\n");
AppendTo(output," *  writing field elms:\n elm \t\t [elm]_{B} \t [elm]_{B1} \t [elm]_{B2} \n");
S := AsList(F);
for i in [1..Length(S)] do
	
	s:=S[i];
	AppendTo(output," ",s,"\t\t");
	WriteVector(output, B, s);
	AppendTo(output,"\t\t");
	WriteVector(output, B1, s);
	AppendTo(output,"\t\t");
	WriteVector(output,B2, s);
	AppendTo(output, "\n");
		
od;

# testing border cases
AppendTo(output,"\n\n*  testing border cases \n");

s := Z(2^2);
AppendTo(output,"* ",s,"\t->\t");
WriteVector(output, B, s);
AppendTo(output,"\n\n");
s := 5;
AppendTo(output,"* ",s,"\t->\t");
WriteVector(output, B, s);
AppendTo(output,"\n\n");
s := IdentityMat(3,K);
AppendTo(output,"* ",s,"\t->\t");
WriteVector(output, B, s);
AppendTo(output,"\n\n");


AppendTo(output,"* ",output,"\t ->\t");
WriteVector(output, B, output); # should tigger an error
AppendTo(output,"\n\n");

AppendTo(output,"* ",s,"\t->\t");
WriteVector(s, B, s);
AppendTo(output,"\n\n");

CloseStream(output);
Print("All done!!!");