#############################################################################
##
#W  outputs.gi                  FSR Package                  Nusa
##


#############################################################################
##
#O  IntFFExt( [<B>,] <ffe> )    . . . . . . . . write ffe as integer / vector of integers from the prime subfield
#O  IntVecFFExt( [<B>,] <vec> ) . . . . . . . . write vector of integers from the prime subfield
#O  IntMatFFExt( [<B>,] <M> )   . . . . . . . . write matrix of integers from the prime subfield


# -----------------------------------#
#O  IntFFExt( [<B>,] <ffe> ) 
InstallMethod(IntFFExt, "print nicely", [IsBasis, IsFFE], function(B,x)
	return IntVecFFE(Coefficients(B, x)); 			# human friendly vector
end);

#  non-basis version
InstallMethod(IntFFExt, "print nicely", [IsFFE], function(x)
local F , B, hfv; 
	hfv := [];
	F := DefaultField(x);
	if IsPrimeField(F) then 
		hfv := Int(x);	
	else 
		B := Basis(F);
#		Print("IntFFExt using basis :\t",Elements(Basis(F)),"\n");
		hfv := IntVecFFE(Coefficients(B, x)); 
	fi;
	return hfv; # human friendly vector
end);

# -----------------------------------#
#O  IntVecFFExt( [<B>,] <vec> )
InstallMethod(IntVecFFExt, "print nicely", [IsBasis, IsFFECollection], function(B, x)
local i, F ,  hfv; 
	hfv := [];
	for i in [1..Length(x)] do	
	 	hfv[i] := IntVecFFE(Coefficients(B, x[i]));
	od;

	return hfv;			# human friendly vector
end);


#  non-basis version calling the basis version

InstallMethod(IntVecFFExt, "print nicely", [IsFFECollection], function(x)
local  i, F , B, hfv; 
	hfv := [];
	F := DefaultField(x);
	if IsPrimeField(F) then 
		hfv := IntVecFFE(x);	
	else 
		B := Basis(F);
		hfv := IntVecFFExt(B,x);
	fi;
	return hfv;# human friendly vector
end);

# -----------------------------------#
#O  IntMatFFExt( [<B>,] <M> )
InstallMethod(IntMatFFExt, "print nicely", [IsBasis, IsFFECollColl], function(B, x)
local  i, j, F , H, row, hfv; 
	H := [];
	for i in [1..Length(x)] do	
		hfv := [];
		row := x[i];
		for j in [1..Length(row)] do
	 		hfv[j] := IntVecFFE( Coefficients(B, row[j]));
	 	od;
	 	H[i] := hfv;
	od;
	return H;
end);



#  non-basis version calling the basis version

InstallMethod(IntMatFFExt, "print nicely", [IsFFECollColl], function(x)
local  i, j, F , B, H, row, hfv; 
	H := [];
	F := DefaultFieldOfMatrix(x);
	if IsPrimeField(F) then 
		for i in [1..Length(x)] do	
			H[i] := IntVecFFE(x[i]);	
		od;
	else 
		B := Basis(F);
#		Print("IntMatFFExt using basis :\t",Elements(Basis(F)),"\n");
		H := IntMatFFExt(B,x);
	fi;
	return H;
end);


#############################################################################
##
#O  VecToString
##
InstallMethod(VecToString, "print nicely", [IsBasis, IsVector], function(B, x)
local  vec, i, j, d, F , elm, hfv, str, tmp, temp, H; 
	str := []; 
	hfv := []; # human friendly vector
	if IsFFE(x) then 		
		hfv := IntFFExt(B, x);
		tmp := List(hfv, String);
		str := JoinStringsWithSeparator(tmp, "");	
	elif IsFFECollection(x) then 
		F := DefaultField(x);
		if IsPrimeField(F) then 
			hfv := IntVecFFE(x);
			tmp := List(hfv, String);
			str := JoinStringsWithSeparator(hfv, "");	
#			Print(" i ended up IsFFECollection(x) PrimeField ....", x, " with string", str, "and ",tmp,"\n");

		else 
			hfv := IntVecFFExt(B, x);
			for i in [1..Length(hfv)] do	
				tmp := List(hfv[i], String);
				str[i] := JoinStringsWithSeparator(tmp, "");
			 od;
#			Print(" i ended up IsFFECollection(x) ....", x, " with string", str,"and ",tmp,"\n");
#if i want a true string (but thats not practical !!!  i want to be able to get a string for each component ... thats something i can use, if i have a true string i have to parse it at the commas AGAIN )
#						hfv := IntVecFFExt(B, x);
#						tmp := List(hfv[1], String);
#						tmp := JoinStringsWithSeparator(tmp, "");
#						str := Concatenation(tmp, ",");			
#						for i in [2..Length(hfv)] do	
#							tmp := List(hfv[i], String);
#							tmp := JoinStringsWithSeparator(tmp, "");
#							str := Concatenation(str, ",", tmp);
#						 od;
		fi;	
	elif IsMatrix(x) then 
		F := DefaultFieldOfMatrix(x);
		if IsPrimeField(F) then 		
			for i in [1..Length(x)] do	
				elm := IntVecFFE(x[i]);
				tmp := List(elm, String);
				str[i] := JoinStringsWithSeparator(tmp, "");
			od;
		else 
			H := IntMatFFExt(B,x);
			d := DimensionsMat(x);
			for i in [1 .. d[1]] do #rows 
				hfv := H[i]; 
				temp:=[];
				for j in [1..Length(hfv)] do	
					elm := hfv[j];
					tmp := List(elm, String);
					temp[j] := JoinStringsWithSeparator(tmp, "");
				 od;			
				Add(str,temp);
			od;
		fi;
	else  
		tmp := List(x, String);
		str := JoinStringsWithSeparator(tmp, "");
	fi;
	return str;
end);

#new version, getting default basis and calling the basis version
InstallMethod(VecToString, "print nicely", [IsVector], function(x)
local  vec, i, j, d, F, B , elm, hfv, str, tmp, temp, H; 
	str := []; 
	hfv := [];
	if IsFFECollection(x) or IsFFE(x) then 
#		Print(" i ended up IsFFECollection or IsFFE ....", x, "\n");
		F := DefaultField(x);
		B := Basis(F);
		str := VecToString(B, x);
	elif IsMatrix(x) then 
#		Print(" i ended up IsMatrix ....", x, "\n");
		F := DefaultFieldOfMatrix(x);
		B := Basis(F);
		str := VecToString(B, x);
	elif IsInt(x) then 	
#		Print(" i ended up IsInt ....", x, "\n");
		str := String(x);	
	
	else 
#		Print(" i ended up here ....", x, "\n");
		tmp := List(x, String);
		str := JoinStringsWithSeparator(tmp, "");
	fi;
	return str;
end);




#############################################################################
##
#F  WriteVector( <output>,<B>, <vec> ) . . . . . . . . write vector
##

# removed outputstream check coz GAP will do that anyway (AppendTo will)
# basis version
InstallGlobalFunction( WriteVector,  function(output, B, vec)
local j, m, str;

	if IsBasis(B) then 
		if (IsRowVector(vec) or IsFFE(vec) or IsInt(vec) or IsFFECollColl(vec)) then 
			if IsFFE(vec) then  # zech log in whatever field 
				vec := IntFFExt(B, vec);
			fi;
			if IsInt(vec) then # prime subfield 
				AppendTo(output, vec); #
				return;
			fi;
			str := VecToString(B,vec);
			if IsString(str) then 	AppendTo(output, str); # 
			else 
				for j in [1.. Length(str)-1] do 
					AppendTo(output, str[j], ", ");  
				od;
				AppendTo(output, str[Length(str)], " ");
			fi;
		else 
		AppendTo(output, "ERROR: elm is not a vector nor a FFE nor integer!!!! \n\t did you use Add instead of Append to merge sequences ?  \n", vec, "\n");
		Error("argument elm is not a row vector nor a FFE nor integer !!!!\n\t did you use Add instead of Append to merge sequences ? \n");
		fi;
	else 
	  Error("B is not a basis !!!! \n");
	fi;

return;
end);

########### METHODS REMOVED, KEPT FUNCTIONS FOR COMPATIBILITY
# -----------------------------------#
# for element (happens if called IntFFExt was called first and it was  from the  prime subfield)
# i think i can remove this one 
#InstallMethod( WriteVector, "write human friendly version of the FFE to a file", [IsOutputStream, IsInt] , function(output, vec)
##	Print("WriteVector: IsInt ....", vec, "\n");
#	AppendTo(output, vec);  
#return;
#end);
# -----------------------------------#
#InstallMethod( WriteVector, "write human friendly version of the FFE to a file", [IsOutputStream, IsBasis, IsFFE] , function(output,B, vec)
#local j, m, str;
##	Print("WriteVector: IsFFE basis version....", vec, "\n");
##	str := VecToString(IntFFExt(B,vec));
#	str := VecToString(B,vec);
#	if IsString(str) then 	AppendTo(output, str);  
#	else 
#		for j in [1.. Length(str)-1] do 
#			AppendTo(output, str[j], ", ");  
#		od;
#		AppendTo(output, str[Length(str)], " ");
#	fi;
#return;
#end);

## calling the basis version
#InstallMethod( WriteVector, "write human friendly version of the FFE to a file", [IsOutputStream, IsFFE] , function(output, vec)
#local B;
##	Print("WriteVectorM: IsFFE ....", vec, "\n");
#	B := Basis(DefaultField( vec));
#	WriteVector(output, B, vec);	
#
##
#return;
#end);

## -----------------------------------#
## for vector

#InstallMethod( WriteVector, "write human friendly version of the FFE vector to a file", [IsOutputStream, IsBasis, IsRowVector],  function(output, B, vec)
#local j,  str;
##	Print("WriteVector: IsRowVector basis version....", vec, "\n");
#	str := VecToString(B, vec);
#	if IsString(str) then 	AppendTo(output, str); # 
#	else 
#		for j in [1.. Length(str)-1] do 
#	AppendTo(output, str[j], ", ");  
#		od;
#		AppendTo(output, str[Length(str)], " ");
#	fi;
#return;
#end);
#
## calling the basis version
#InstallMethod( WriteVector, "write human friendly version of the FFE vector to a file", [IsOutputStream, IsRowVector],  function(output, vec)
#local B;
##	Print("WriteVector: IsRowVector ....", vec, "\n");
#	B := Basis(DefaultField( vec));
#	WriteVector(output, B, vec);	
#return;
#end);

## -----------------------------------#
## for row vestors (like the thing returned by Basis)
#InstallMethod( WriteVector, "write human friendly version of FFE matrix to a file", [IsOutputStream, IsBasis, IsFFECollColl],  function(output, B, M)
#local j, str;
##	Print("WriteVector: IsFFECollColl basis version ....", M, "\n");
#	str := VecToString(B, M);
#	if IsString(str) then 	AppendTo(output, str); # 
#	else 
#		for j in [1.. Length(str)-1] do 
#			AppendTo(output, str[j], ", ");  
#		od;
#		AppendTo(output, str[Length(str)], " ");
#	fi;
#return;
#end);


## calling the basis version
#InstallMethod( WriteVector, "write human friendly version of FFE matrix to a file", [IsOutputStream, IsFFECollColl],  function(output, M)
#local B;
##	Print("WriteVector: IsFFECollColl ....", M, "\n");
#		B := Basis(DefaultField(M));
#	  	WriteVector(output, B, M);
#return;
#end);

#############################################################################
##
#F  WriteMatrix( <output>, <M> ) . . . . . . . . write matrix
##
## for nicely formatted matrix (each row in new line)
## if u dont care about that u can just call WriteVector/WriteVectorM 



# basis version
# removed outputstream check coz GAP will do that anyway (AppendTo will)
InstallGlobalFunction( WriteMatrix, function(output, B, M)
local i,j,d,str, row, F;
	
	 if IsBasis(B) then 
		 if (IsMatrix(M)) then 
			d := DimensionsMat(M);
			str := VecToString(B, M);
			F :=  DefaultFieldOfMatrix(M);
			if IsPrimeField(F) then 
				for i in [1..d[1]] do # rows
					row := str[i];
					AppendTo(output, row);
					if i<>d[1] then AppendTo(output,"\n");
					fi; # dont want a newline at the end of the last row
				od;			
			else
				for i in [1..d[1]] do # rows
					row := str[i];
					for j in [1.. Length(row)-1] do 	 		
						AppendTo(output, row[j], ", ");  
					od;
					AppendTo(output, row[Length(row)]);
					if i<>d[1] then AppendTo(output,"\n");
					fi; # dont want a newline at the end of the last row
				od;
			fi;
		  else 
		    Error("M is not a matrix !!!! \n");
		    AppendTo(output, "ERROR: M is not a matrix !!!! \n", M, "\n");
		  fi;
	  else 
	    Error("B is not a basis !!!! \n");
	  fi;

return;
end);




#InstallMethod( WriteMatrix, "write human friendly version of FFE matrix to a file - formatted (rows x cols)", [IsOutputStream, IsBasis, IsMatrix],  function(output, B, M)
#local d, str, i, j, row;
##	Print("WriteMatrixM:  IsMatrix basis version ....", M, "\n");
#	d := DimensionsMat(M);
#	str := VecToString(B,M);
#	if IsPrimeField(DefaultFieldOfMatrix(M)) then 
#		for i in [1..d[1]] do # rows
#			row := str[i];
#			AppendTo(output, row);
#			if i<>d[1] then AppendTo(output,"\n");
#			fi; # dont want a newline at the end of the last row
#		od;			
#	else
#		for i in [1..d[1]] do # rows
#			row := str[i];
#			for j in [1.. Length(row)-1] do 	 		
#				AppendTo(output, row[j], ", ");  
#			od;
#			AppendTo(output, row[Length(row)]);
#			if i<>d[1] then AppendTo(output,"\n");
#			fi; # dont want a newline at the end of the last row
#		od;
#	fi;
#return;
#end);




#non-basis version calling the basis version
#InstallMethod( WriteMatrix, "write human friendly version of FFE matrix to a file - formatted (rows x cols)", [IsOutputStream, IsMatrix],  function(output, M)
#local B;
##	Print("WriteMatrix:  IsMatrix ....", M, "\n");
#	B := Basis(DefaultFieldOfMatrix(M));
#	WriteMatrix(output, B, M);
#return;
#end);

#############################################################################
##
#F  WriteMatrixTEX( <output>, <M> ) . . . writes the TEX code for  matrix 
##
##  do a version with matrix entries from ext field?


InstallGlobalFunction( WriteMatrixTEX, function(output, M)
local d, drows, dcols, i, j, row,  F;

 if (IsMatrix(M) or IsFFECollColl(M)) then 
	if (IsPrimeField(DefaultFieldOfMatrix(M))) then 
		d := DimensionsMat(M);
		drows := d[1];
		dcols := d[2];

			AppendTo(output, "\\begin{displaymath}\\tiny \n");
			AppendTo(output, "\\left[ \n");
			AppendTo(output, "\\setcounter{MaxMatrixCols}{", dcols, "} \n\\begin{matrix} \n");
			for i in [1..drows] do
				row := M[i];
				for j in [1..dcols] do
					AppendTo(output, Int(row[j]));
					if j<dcols then AppendTo(output, "&");
					else  AppendTo(output, "\\");
					fi;
				od;
				AppendTo(output, "\\\n");
			od;
		AppendTo(output, "\\end{matrix} \\right] \n");
		AppendTo(output, "\\end{displaymath} \n");
	else 
	    Error("M is not over a prime field !!!! \n");
	    AppendTo(output, "ERROR: M is not over a prime field !!!! \n", M, "\n");
	  fi;	
	
	
  else 
	    Error("M is not a matrix !!!! \n");
	    AppendTo(output, "ERROR: M is not a matrix !!!! \n", M, "\n");
	  fi;
return;
end);





Print("outputs.gi OK,\t");
#E  outputs.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
