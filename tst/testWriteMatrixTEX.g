



#start output file
dir:=DirectoryHome();
str:="LFSRjan13/testWriteMatrixTEXexpected.txt";
nameWrite:=Filename(dir,str);
if IsExistingFile(nameWrite) then RemoveFile(nameWrite); fi;
output:=OutputTextFile(nameWrite,false);


K:=GF(2);
M := IdentityMat(3,K);
AppendTo(output,"-----===========================-----\n");
AppendTo(output,"3x3 matrix over ",K,"\n");
AppendTo(output,M,"\n");
WriteMatrixTEX(output,M);
	
M := RandomMat(3,5,K);
AppendTo(output,"-----===========================-----\n");
AppendTo(output,"3x5 matrix over ",K,"\n");
AppendTo(output,M,"\n");
WriteMatrixTEX(output,M);		



K:=GF(5);
M := IdentityMat(3,K);
AppendTo(output,"-----===========================-----\n");
AppendTo(output,"3x3 matrix over ",K,"\n");
AppendTo(output,M,"\n");
WriteMatrixTEX(output,M);

K:=GF(5);
M := [ [ Z(5)^0, Z(5)^2 ], [ 0*Z(5), 0*Z(5) ], [ Z(5)^3, Z(5)^0 ] ];
AppendTo(output,"-----===========================-----\n");
AppendTo(output,"3x2 matrix over ",K,"\n");
AppendTo(output,M,"\n");
WriteMatrixTEX(output,M);


CloseStream(output);
Print("All done!!!");