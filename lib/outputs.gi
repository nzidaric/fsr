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
InstallMethod(IntMatFFExt, "print nicely", [IsBasis, IsFFECollColl],
function(B, x)
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
SetPrintFormattingStatus(output, false);
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
AppendTo(output, "ERROR: ", vec, " is not a vector nor a FFE nor integer!!!! ");
	Error("argument ", vec, " is not a row vector nor a FFE nor integer !!!!\n");
		fi;
	else
	  Error("B is not a basis !!!! \n");
	fi;

return;
end);



#############################################################################
##
#F  WriteMatrix( <output>, <B>, <M> ) . . . . . . . . write matrix
##
## for nicely formatted matrix (each row in new line)
## if u dont care about that u can just call WriteVector/WriteVectorM



# basis version
# removed outputstream check coz GAP will do that anyway (AppendTo will)
InstallGlobalFunction( WriteMatrix, function(output, B, M)
local i,j,d,str, row, F;
SetPrintFormattingStatus(output, false);
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


#############################################################################
##
#F  WriteTEXFF( <output>, <F> ) . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="WriteTEXFF">
##  <ManSection>
##  <Func Name="WriteTEXFF" Arg="output, F"/>
##  <Func Name="WriteTEXFFEByGenerator" Arg="output, F, ffe"/> # in case its a subfield elm
##  <Func Name="WriteTEXUnivarFFPolyByGenerator" Arg="output, F, f, indet"/>
##  <Func Name="WriteTEXMultivarFFPolyByGenerator" Arg="output, F, f"/>
##  <Func Name="WriteTEXFieldPolyByGenerator" Arg="output, F"/>
##  <Func Name="WriteTEXLFSRPolyByGenerator" Arg="output, F, l"/>
##
##  <Description>
##  Equivalent to PrintAll, but it writes to an output stream. NOTE: The basis
##   switch must be present and if <E>true</E>, the currently set basis of the
##   <A>fsr</A> is used.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##DeclareGlobalFunction( "WriteTEXFF" );
##DeclareGlobalFunction( "WriteTEXFFEByGenerator" );
##DeclareGlobalFunction( "WriteTEXUnivarFFPolyByGenerator" );
#DeclareGlobalFunction( "WriteTEXMultivarFFPolyByGenerator" ); TO DO (will need indet list)
##DeclareGlobalFunction( "WriteTEXFieldPolyByGenerator" );
##DeclareGlobalFunction( "WriteTEXLFSRPolyByGenerator" );

#############################################################################
##
#F  WriteTEXFF( <output>, <F> ) . . . . . .
##
InstallGlobalFunction(  WriteTEXFF, function(output,  F)
local char, m;

SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then
			char := Characteristic(F);
			m := DegreeOverPrimeField(F);
			if m=1 then
				AppendTo(output,"$\\mathbb{F}_{",char,"}$");
			else
				AppendTo(output,"$\\mathbb{F}_{{",char,"}^{",m,"}}$");
			fi;

		else
		Error(F," is not a finite field !!!!\n");
		fi;

	return;
end);

#############################################################################
##
## WriteTEXFFE
##
InstallGlobalFunction(WriteTEXFFE,
 function(output, B, ffe)
 local F;
 F := UnderlyingLeftModule(B);

SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then
        AppendTo(output,  "$",VecToString(B,ffe),"$");
		else
		Error(F," is not a finite field !!!!\n");
		fi;

	return;
end);




#############################################################################
##
## WriteTEXFFEByGeneratorNC
##
InstallGlobalFunction(WriteTEXFFEByGeneratorNC,
 function(output,  ffe, strGen, gen)
local exp;

      if IsZero(ffe) then
          AppendTo(output,  "$0$");
      elif IsOne(ffe) then
          AppendTo(output,  "$1$");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then 			 AppendTo(output,  "$\\",strGen,"$");
         else 		AppendTo(output,  "$\\",strGen,"^{",exp,"}$");
         fi;
      fi;

	return;
end);

#############################################################################
##
## WriteTEXFFEByGeneratorNCM
##
InstallGlobalFunction(WriteTEXFFEByGeneratorNCM,
 function(output,  ffe, strGen, gen)
local exp;

      if IsZero(ffe) then
          AppendTo(output,  "0");
      elif IsOne(ffe) then
          AppendTo(output,  "1");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then 			 AppendTo(output,  "\\",strGen);
         else 		AppendTo(output,  "\\",strGen,"^{",exp,"}");
         fi;
      fi;

	return;
end);

#############################################################################
##
## WriteTEXFFEByGenerator
##
InstallGlobalFunction(WriteTEXFFEByGenerator,
 function(output,  F, ffe, strGen, gen)
local exp;

SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then
   if IsString(strGen) and  strGen <> "omega" then
     if Order(gen)=Size(F)-1 then

		 WriteTEXFFEByGeneratorNC(output,  ffe, strGen, gen);

      else
        Error(gen," is not a generator of ",F,"!!!!\n");
        fi;
      else
      Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
      fi;
		else
		Error(F," is not a finite field !!!!\n");
		fi;
	return;
end);

#############################################################################
##
## WriteTEXFFEVec
##
InstallGlobalFunction(WriteTEXFFEVec,
 function(output, B, vec)
 local F, ffe,j;
 F := UnderlyingLeftModule(B);

SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then
	 	if	IsFFECollection(vec) then
			AppendTo(output,  "[ ");
				for j in [1.. Length(vec)] do
					ffe := vec[j];
			        AppendTo(output,  "$",VecToString(B,ffe),"$");
					if j < Length(vec) then
						AppendTo(output,  ",\\,");
					fi;
				od;
				AppendTo(output,  " ]");
			else
				Error(vec," is not a finite field vector!!!!\n");
			fi;
		else
		Error(F," is not a finite field !!!!\n");
		fi;

	return;
end);

#############################################################################
##
## WriteTEXFFEVecByGenerator
##
InstallGlobalFunction(WriteTEXFFEVecByGenerator,
 function(output, F, vec, strGen, gen)
 local  ffe, j;


SetPrintFormattingStatus(output, false);
if IsField(F) and IsFinite(F) then
	if IsString(strGen) and  strGen <> "omega" then
		if Order(gen)=Size(F)-1 then
	 		if IsFFECollection(vec) then
				AppendTo(output,  "[ ");
				for j in [1.. Length(vec)] do
					ffe := vec[j];
			      	WriteTEXFFEByGeneratorNC(output, ffe, strGen, gen);
					if j < Length(vec) then
						AppendTo(output,  ",\\,");
					fi;
				od;
			AppendTo(output,  " ]");
			else
				Error(vec," is not a finite field vector!!!!\n");
			fi;
		else
      Error(gen," is not a generator of ",F,"!!!!\n");
    fi;
  else
    Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
  fi;
else
	Error(F," is not a finite field !!!!\n");
fi;

	return;
end);

#############################################################################
##
#F  WriteTEXMatrix( <output>, <B>, <M> ) . . . writes the TEX code for  matrix
##

InstallGlobalFunction( WriteTEXMatrix, function(output, B, M)
local d, drows, dcols, i, j, row,  F, ffe;

F := UnderlyingLeftModule(B);

SetPrintFormattingStatus(output, false);

 if (IsMatrix(M) or IsFFECollColl(M)) then
		if IsField(F) and IsFinite(F) then
		d := DimensionsMat(M);
		drows := d[1];
		dcols := d[2];

#			AppendTo(output, "\\begin{displaymath}\\tiny \n");
			AppendTo(output, "\\left[ \n");
			AppendTo(output, "\\setcounter{MaxMatrixCols}{", dcols, "} \n\\begin{matrix} \n");
			for i in [1..drows] do
				row := M[i];
				for j in [1..dcols] do
					ffe := row[j];
					AppendTo(output, VecToString(B, ffe));
					if j<dcols then AppendTo(output, "&");
					else  AppendTo(output, "\\");
					fi;
				od;
				AppendTo(output, "\\\n");
			od;
		AppendTo(output, "\\end{matrix} \\right] \n");
#		AppendTo(output, "\\end{displaymath} \n");
	else
		  Error(M," is not over a finite field !!!!\n");
	  fi;
  else
	    Error("M is not a matrix !!!! \n");
	  fi;

return;
end);


#############################################################################
##
#F  WriteTEXMatrixByGenenator. . . writes the TEX code for  matrix
##

InstallGlobalFunction( WriteTEXMatrixByGenerator, function(output,F, M, strGen, gen)
local d, drows, dcols, i, j, row, ffe;

SetPrintFormattingStatus(output, false);
 if IsField(F) and IsFinite(F) then
  if (IsMatrix(M) or IsFFECollColl(M)) then

	if IsString(strGen) and  strGen <> "omega" then
	 if Order(gen)=Size(F)-1 then
		d := DimensionsMat(M);
		drows := d[1];
		dcols := d[2];

#			AppendTo(output, "\\begin{displaymath}\\tiny \n");
			AppendTo(output, "\\left[ \n");
			AppendTo(output, "\\setcounter{MaxMatrixCols}{", dcols, "} \n\\begin{matrix} \n");
			for i in [1..drows] do
				row := M[i];
				for j in [1..dcols] do
				  ffe := row[j];
				  WriteTEXFFEByGeneratorNCM(output,  ffe, strGen, gen);

					if j<dcols then AppendTo(output, "&");
					else  AppendTo(output, "\\");
					fi;
				od;
				AppendTo(output, "\\\n");
			od;
		AppendTo(output, "\\end{matrix} \\right] \n");
#		AppendTo(output, "\\end{displaymath} \n");
		else
			Error(gen," is not a generator of ",F,"!!!!\n");
			fi;
		else
		Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
		fi;
		else
		    Error("M is not a matrix !!!! \n");
		  fi;
	else
	Error(F," is not a finite field !!!!\n");
	fi;

return;
end);

#############################################################################
##
## WriteTEXUnivarFFPolyByGenerator
##
InstallGlobalFunction(WriteTEXUnivarFFPolyByGenerator,
function(output,  F, f, strIndet, strGen, gen)
local exp, coeffvec, m, i, ffe;

SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then
   if  IsUnivariatePolynomial(f) then
    if IsString(strGen) and  strGen <> "omega" then
     if Order(gen)=Size(F)-1 then
      coeffvec := Reversed(CoefficientsOfUnivariatePolynomial(f));
      m := Degree(f);
        AppendTo(output,  "$");

      for i in [1 .. Length(coeffvec)-2] do
        ffe := coeffvec[i];


        if IsZero(ffe) then
         continue;
        elif IsOne(ffe) then
            AppendTo(output, strIndet, "^{",m-(i-1),"}+");
        else
           exp := LogFFE(ffe,gen);
           if exp = 1 then
           		 AppendTo(output, "\\",strGen," ", strIndet, "^{",m-(i-1),"}+");
           else
              AppendTo(output, "\\", strGen,"^{",exp,"} ");
              AppendTo(output, strIndet, "^{",m-(i-1),"}+");

           fi;
        fi;
      od;
      ffe := coeffvec[ Length(coeffvec)-1];
      if IsZero(ffe) then
               AppendTo(output,  " ");
      elif IsOne(ffe) then
          AppendTo(output, strIndet, "+");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then
             AppendTo(output, "\\",strGen," ", strIndet, "+");
         else
            AppendTo(output, "\\", strGen,"^{",exp,"} ");
            AppendTo(output, strIndet, "+");

         fi;
      fi;

      ffe := coeffvec[ Length(coeffvec)];
      if IsOne(ffe) then
          AppendTo(output,"1");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then 			 AppendTo(output, "\\", strGen);
         else 		 AppendTo(output, "\\", strGen,"^{",exp,"}");
         fi;
      fi;

      AppendTo(output,  "$");
      else
        Error(gen," is not a generator of ",F,"!!!!\n");
        fi;
      else
      Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
      fi;
      else
  		Error(f," is not a an univariate polynomial !!!!\n");
  		fi;

    else
		Error(F," is not a finite field !!!!\n");
		fi;

	return;
end);

#############################################################################
##
## WriteTEXFieldPolyByGenerator
##
InstallGlobalFunction(WriteTEXFieldPolyByGenerator,
function(output,  F, f, strGen, gen)
 WriteTEXUnivarFFPolyByGenerator(output,  F, f, "x", strGen, gen);
 return;
end);

#############################################################################
##
## WriteTEXLFSRPolyByGenerator
##
InstallGlobalFunction(WriteTEXLFSRPolyByGenerator,
function(output,  F, f, strGen, gen)
 WriteTEXUnivarFFPolyByGenerator(output,  F, f, "y", strGen, gen);
  return;
end);


#############################################################################
##
## WriteTEXMultivarFFPolyByGenerator
##
InstallGlobalFunction(WriteTEXMultivarFFPolyByGenerator,
function(output,  F, clist, mlist, strGen, gen)

local ffe, i, j,mof, idx, pwr, m, exp;
# check coeffs and monomials
	if Length(clist) = Length(mlist) then

	for i in [1..Length(clist)] do
		if not (\in(clist[i], F)) then
			Error( "coefficient at index=",i,"is not an element of the underlying field !!!" );
					return fail;
		fi;
	od;

 	mof := MonomialsOverField(F, mlist);
	# multpol := clist * mof;

AppendTo(output,  "$");
# get all the indeterminates in all monomials
	for i in [1 .. Length(mof)] do
		ffe := clist[i];
		if IsPolynomial(mof[i]) then # to account for case when we have constants
			m := LeadingMonomial(mof[i]);
	#		Print(m,"\n");

			if IsZero(ffe) then
	 			continue;
			elif IsOne(ffe) then
				for j in [1..Length(m)-1] do
					if IsOddInt(j) then
						idx := m[j] - 800;
						pwr := m[j+1];
					 if pwr = 1 then 	AppendTo(output, "x_{",idx,"}");
					 else	AppendTo(output, "x_{",idx,"}^{",pwr,"}");
					 fi;
					fi;
				od;

	 		else
	 			exp := LogFFE(ffe,gen);
	 			if exp = 1 then
			 		AppendTo(output, "\\",strGen," ");
	 			else
					AppendTo(output, "\\", strGen,"^{",exp,"} ");
	 			fi;
				for j in [1..Length(m)-1] do
					if IsOddInt(j) then
						idx := m[j] - 800;
						pwr := m[j+1];
						if pwr = 1 then 	AppendTo(output, "x_{",idx,"}");
 					 else	AppendTo(output, "x_{",idx,"}^{",pwr,"}");
 					 fi;
					fi;
				od;
			fi;
	 		else # constant term
			if IsOne(ffe) then
					AppendTo(output,"1");
			else
				 exp := LogFFE(ffe,gen);
				 if exp = 1 then 			 AppendTo(output, "\\", strGen);
				 else 		 AppendTo(output, "\\", strGen,"^{",exp,"}");
				 fi;
			fi;
		fi;
			if i<Length(mof) then
					AppendTo(output, "+");
			fi;

	od;

	AppendTo(output,  "$");

	else
		Error("coeff and monomial lists must have same length!!!");
	fi;


	 return;
 end);


#############################################################################
##
##  WriteTEXGeneratorWRTDefiningPolynomial
##

InstallGlobalFunction( WriteTEXGeneratorWRTDefiningPolynomial,
function(output, F, strGen, gen)
local genvec, i, plus;

SetPrintFormattingStatus(output, false);

	if IsString(strGen) and  strGen <> "omega" then
		if Order(gen)=Size(F)-1 then

			if gen = RootOfDefiningPolynomial(F) then
      AppendTo(output, "$\\",strGen," $ is a root of ");
  WriteTEXFieldPolyByGenerator(output,  F, DefiningPolynomial(F), strGen, gen);

			else
				genvec := Coefficients(Basis(F), gen);
				plus := false;
				AppendTo(output, " where $\\",strGen,"=");
				if genvec[1] = One(F) then
					AppendTo(output, "1");
					plus := true;
				fi;
				for i in [2.. Length(genvec)-1] do
					if genvec[i] = One(F) then
						if plus then
							AppendTo(output, "+");
							plus := false;
						fi;
						AppendTo(output, "\\omega^{", i-1,"}");
						plus := true;
					fi;
				od;
				if genvec[Length(genvec)] = One(F) then
					if plus then
						AppendTo(output, "+");
					fi;
					AppendTo(output, "\\omega^{",Length(genvec)-1, "}");
				fi;
		AppendTo(output, "$ and $\\omega$ is a root of ");
WriteTEXFieldPolyByGenerator(output,  F, DefiningPolynomial(F), strGen, gen);

			fi;

		else
			Error(gen," is not a generator of ",F,"!!!!\n");
		fi;

	else
		Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
	fi;

return;
end);


InstallGlobalFunction(WriteTEXBasisByGenerator,
 function(output, F, B, strGen, gen)
local  i,j, elms,  tmp,  m, divs, eb, exp, elm, roots;

SetPrintFormattingStatus(output, false);

	 if IsBasis(B) then
			m:= DegreeOverPrimeField(F);
							divs := DivisorsInt(m);
			if m>1 and (not  m > Length(B)) and \in(Length(B),divs) then
               # basis ok for field
					AppendTo(output,  "B = [$\\beta_i$] = ");
					WriteTEXFFEVecByGenerator(output, F, BasisVectors(B), strGen, gen);
     			else
     				Error("basis does not match the field!\n" );
     			fi;

	else
		Error(B,"is not a basis !!!!\n");
	fi;

   return;
end);

InstallGlobalFunction(WriteTEXElementTableByGenerator,
 function(output, F, B, strGen, gen)
local  i,j, elms,  tmp,  m, divs, eb, exp, elm;

SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then
		 if IsBasis(B) then
			if IsString(strGen) and  strGen <> "omega" then
				if Order(gen)=Size(F)-1 then

							m:= DegreeOverPrimeField(F);
							divs := DivisorsInt(m);
							if m>1 and (not  m > Length(B)) and \in(Length(B),divs) then
               # basis ok for field
								 elms := Elements(F);
										# starte table
		AppendTo(output,  "{\\footnotesize\n \\begin{table}[h!]\n	\\begin{center}");
		AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
		AppendTo(output,  "\\begin{tabular}{|c|");
											for i in [1.. Length(B)] do
												AppendTo(output,  "c");
											od;
											AppendTo(output,  "|c");
											AppendTo(output,  "|} \n\\hline\n");
AppendTo(output,"elm&\\multicolumn{",Length(B),"}{c|}{given basis B}& \\\\\n");
											AppendTo(output,  "\\cline{2-",+Length(B)+1,"}\n");
											AppendTo(output,  "order");
											for i in [1.. Length(B)] do
												AppendTo(output,  "&\\,$\\beta_{",i-1,"}$\\,");
											od;

											AppendTo(output,  "&\\,$\\",strGen,"^i$\\,");
											AppendTo(output,  " \\\\\n");
											AppendTo(output,  "\\hline\\hline\n");
											for i in [1.. Length(elms)] do
												elm := elms[i];
												if IsZero(elm) then
													AppendTo(output, "-");
												else
													AppendTo(output, Order(elm));
												fi;

												eb := IntFFExt(B,elm);
												for j in [1.. Length(B)] do
														AppendTo(output,  "&\\, ",VecToString(eb[j]),"\\,");
												od;
													AppendTo(output,  "&\\,");
											  WriteTEXFFEByGeneratorNC(output, elm, strGen, gen);
											AppendTo(output,  " \\\\\n");

											od;

											# end table
											AppendTo(output,  "\\hline\n");
											AppendTo(output,  "\\end{tabular}}\n");

 AppendTo(output,"\\caption{{\\footnotesize Element table for ");
 WriteTEXFF(output, F);
 AppendTo(output," using basis ");
WriteTEXBasisByGenerator(output, F, B, strGen, gen);
 AppendTo(output," with generator $\\",strGen,"$\\quad");
	WriteTEXGeneratorWRTDefiningPolynomial(output, F, strGen, gen);
										AppendTo(output, ".}}\\label{LABEL}");

										AppendTo(output,  "\\end{center}\n\\end{table}\n}");


# AppendTo(output,  "\n\n \n\nThe generator $\\",strGen);
#            if gen=RootOfDefiningPolynomial(F) then
#AppendTo(output,  "$ is a root of defining polynomial ");
#WriteTEXFieldPolyByGenerator(output,  F, DefiningPolynomial(F), strGen, gen);
#            else
#AppendTo(output,  "=$");
#WriteTEXGeneratorWRTDefiningPolynomial(output, F, strGen, gen);
#AppendTo(output,  ", where $\\omega$ is a root of defining polynomial ");
#WriteTEXFieldPolyByGenerator(output,  F, DefiningPolynomial(F), strGen, gen);

#fi;

									   AppendTo(output,  " \n");
							else
							Error("basis does not match the field!\n" );
							fi;
						else
						Error(gen," is not a generator of ",F,"!!!!\n");
						fi;
					else
					Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
					fi;
				else
				Error(B,"is not a basis !!!!\n");
				fi;
			else
			Error(F,"is not a finite field !!!!\n");
			fi;

	return ;
end);



Print("outputs.gi OK,\t");
#E  outputs.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
