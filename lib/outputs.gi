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
InstallMethod(IntFFExt, "print nicely", [IsBasis, IsRingElement], function(B,x)
	return IntVecFFE(Coefficients(B, x)); 			# human friendly vector
end);

#  non-basis version
InstallMethod(IntFFExt, "print nicely", [IsRingElement], function(x)
local F , hfv;
	hfv := [];
	F := DefaultField(x);
	if IsPrimeField(F) then 		hfv := Int(x);
	else
		hfv := IntVecFFE(Coefficients(Basis(F), x));
	fi;
	return hfv; # human friendly vector
end);

# -----------------------------------#
#O  IntVecFFExt( [<B>,] <vec> )
InstallMethod(IntVecFFExt, "print nicely", [IsBasis, IsRingElementCollection],
function(B, x)
local i, F ,  hfv;
	hfv := [];
	for i in [1..Length(x)] do
	 	hfv[i] := IntVecFFE(Coefficients(B, x[i]));
	od;
	return hfv;			# human friendly vector
end);

#  non-basis version calling the basis version
InstallMethod(IntVecFFExt, "print nicely", [IsRingElementCollection], function(x)
local  i, F , hfv;
	hfv := [];
	F := DefaultField(x);
	if IsPrimeField(F) then		hfv := IntVecFFE(x);
	else		hfv := IntVecFFExt(Basis(F),x);
	fi;
	return hfv;# human friendly vector
end);

# -----------------------------------#
#O  IntMatFFExt( [<B>,] <M> )
InstallMethod(IntMatFFExt, "print nicely", [IsBasis, IsRingElementCollColl],
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
InstallMethod(IntMatFFExt, "print nicely", [IsRingElementCollColl], function(x)
local  i,  F ,  H, row, hfv;
	H := [];
	F := DefaultFieldOfMatrix(x);
	if IsPrimeField(F) then
		for i in [1..Length(x)] do
			H[i] := IntVecFFE(x[i]);
		od;
	else
		H := IntMatFFExt(Basis(F),x);
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

	if IsMatrix(x) then
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

	elif IsRingElement(x) then
		hfv := IntFFExt(B, x);
		tmp := List(hfv, String);
		str := JoinStringsWithSeparator(tmp, "");
	elif IsRingElementCollection(x) then
		F := DefaultField(x);
		if IsPrimeField(F) then
			j := true;
			for i in x do
				if not IsInt(i) then j := false;
				fi;
			od;
			if not j then 	hfv := IntVecFFE(x);
			else hfv := x;
			fi;
			tmp := List(hfv, String);
			str := JoinStringsWithSeparator(hfv, "");
		else
			hfv := IntVecFFExt(B, x);
			for i in [1..Length(hfv)] do
				tmp := List(hfv[i], String);
				str[i] := JoinStringsWithSeparator(tmp, "");
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
local  F, hfv, str, tmp;
	str := [];
	hfv := [];
	if IsInt(x) then
		str := String(x);
	elif IsMatrix(x) then
		F := DefaultFieldOfMatrix(x);
		str := VecToString(Basis(F), x);
	elif IsRingElementCollection(x) or IsRingElement(x) then
		F := DefaultField(x);
		str := VecToString(Basis(F), x);
	else
		tmp := List(x, String);
		str := JoinStringsWithSeparator(tmp, "");
	fi;
	return str;
end);

#############################################################################
##
#F  WriteVector( <output>,<B>, <vec> ) . . . . . . . . write vector
##
InstallGlobalFunction( WriteFFEVec,  function(output, B, vec)
local j, m, str;
SetPrintFormattingStatus(output, false);
		if (IsRowVector(vec) or IsRingElement(vec) or IsInt(vec)) then #or IsRingElementCollColl(vec)) then
			if IsInt(vec) then # prime subfield
				AppendTo(output, vec); #
				return;
			fi;
			if IsRingElement(vec) and not IsMatrix(vec) then vec := IntFFExt(B, vec);
			fi;

			str := VecToString(B,vec);
			if IsString(str) then AppendTo(output, str); #
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
return;
end);



#############################################################################
##
#F  WriteMatrix( <output>, <B>, <M> ) . . . . . . . . write matrix
##
## for nicely formatted matrix (each row in new line)
## if u dont care about that u can just call WriteVector

InstallGlobalFunction( WriteFFEMatrix, function(output, B, M)
local i,j,d,str, row, F;
SetPrintFormattingStatus(output, false);
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
return;
end);

#############################################################################
##
#F  WriteTEXFF( <output>, <F> ) . . . . . .
##
InstallGlobalFunction(  WriteTEXFF, function(output,  F)
local char, m, pwrlist, K, i;

SetPrintFormattingStatus(output, false);
			char := Characteristic(F);
			m := DegreeOverPrimeField(F);
			if m=1 then	# prime field
				AppendTo(output,"$\\mathbb{F}_{",char,"}$");
			elif m=Dimension(F) then # one extension
				AppendTo(output,"$\\mathbb{F}_{{",char,"}^{",m,"}}$");
			else 	#tower
				pwrlist := []; K := F;
				while not IsPrimeField(K) do
					Add(pwrlist, Dimension(K));
					K := LeftActingDomain(K);
				od;
				pwrlist := Reversed(pwrlist);
				AppendTo(output,"$\\mathbb{F}_{");
				for i in [1..Length(pwrlist)-1] do
							AppendTo(output,"(");
				od;
				AppendTo(output,"{",char,"}");
				for i in [1..Length(pwrlist)-1] do
							AppendTo(output,"^{",pwrlist[i],"})");
				od;
				AppendTo(output,"^{",pwrlist[Length(pwrlist)],"}}$");
			fi;
	return;
end);

#############################################################################
##
## WriteTEXFFE
##
InstallGlobalFunction(WriteTEXFFE,  function(output, B, ffe)
 	SetPrintFormattingStatus(output, false);
	AppendTo(output,  "$",VecToString(B,ffe),"$");
	return;
end);

#############################################################################
##
## WriteTEXFFEByGeneratorNC
##
InstallGlobalFunction(WriteTEXFFEByGenerator,
 function(output,  ffe, strGen, gen)
local exp;
      if IsZero(ffe) then
          AppendTo(output,  "$0$");
      elif IsOne(ffe) then
          AppendTo(output,  "$1$");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then 	AppendTo(output,  "$\\",strGen,"$");
         else 						AppendTo(output,  "$\\",strGen,"^{",exp,"}$");
         fi;
      fi;
	return;
end);

InstallGlobalFunction(WriteTEXFFEByGeneratorNM,
 function(output,  ffe, strGen, gen)
local exp;
      if IsZero(ffe) then
          AppendTo(output,  "0");
      elif IsOne(ffe) then
          AppendTo(output,  "1");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then 	AppendTo(output,  "\\",strGen);
         else 						AppendTo(output,  "\\",strGen,"^{",exp,"}");
         fi;
      fi;
	return;
end);

#############################################################################
##
## WriteTEXFFEVec
##
InstallGlobalFunction(WriteTEXFFEVec,  function(output, B, vec)
local ffe , j;
SetPrintFormattingStatus(output, false);
	 	if	IsRingElementCollection(vec) then
				AppendTo(output,  "[ ");
				for j in [1.. Length(vec)] do
					ffe := vec[j];
			    AppendTo(output,  "$",VecToString(B,ffe),"$");
					if j < Length(vec) then 	AppendTo(output,  ",\\,");
					fi;
				od;
				AppendTo(output,  " ]");
		else	Error(vec," is not a vector!!!!\n");
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

	if IsString(strGen)  then
		if Order(gen)=Size(F)-1 then
	 		if IsRingElementCollection(vec) then
				AppendTo(output,  "[ ");
				for j in [1.. Length(vec)] do
					ffe := vec[j];
			   	WriteTEXFFEByGenerator(output, ffe, strGen, gen);
					if j < Length(vec) then AppendTo(output,  ",\\,");
					fi;
				od;
			AppendTo(output,  " ]");
			else  Error(vec," is not a vector!!!!\n");
			fi;
		else 	Error(gen," is not a generator of ",F,"!!!!\n");
    fi;
  else	Error(strGen," is not a string  !!!!\n");
  fi;
	return;
end);

######################################################WriteTEXFFEByGenerator#######################
##
#F  WriteTEXMatrix( <output>, <B>, <M> ) . . . writes the TEX code for  matrix
##

InstallGlobalFunction( WriteTEXFFEMatrix, function(output, B, M)
local d, drows, dcols, i, j, row,  ffe;
SetPrintFormattingStatus(output, false);
 if (IsMatrix(M) or IsRingElementCollColl(M)) then
		d := DimensionsMat(M);
		drows := d[1];
		dcols := d[2];
#			AppendTo(output, "\\begin{displaymath}\\tiny \n");
			AppendTo(output, "\\left[ \n");
			AppendTo(output, "\\setcounter{MaxMatrixCols}{", dcols, "} \n");
			AppendTo(output, "\\begin{matrix} \n");
			for i in [1..drows] do
				row := M[i];
				for j in [1..dcols] do
					ffe := row[j];
					AppendTo(output, VecToString(B, ffe));
					if j<dcols then AppendTo(output, "&");
					else  					AppendTo(output, "\\");
					fi;
				od;
				AppendTo(output, "\\\n");
			od;
		AppendTo(output, "\\end{matrix} \\right] \n");
#		AppendTo(output, "\\end{displaymath} \n");
  else 	Error("M is not a matrix !!!! \n");
	fi;
return;
end);


#############################################################################
##
#F  WriteTEXMatrixByGenenator. . . writes the TEX code for  matrix
##

InstallGlobalFunction( WriteTEXFFEMatrixByGenerator, function(output,F, M, strGen, gen)
local d, drows, dcols, i, j, row, ffe;

SetPrintFormattingStatus(output, false);
  if (IsMatrix(M) or IsRingElementCollColl(M)) then
	if IsString(strGen) then
	 if Order(gen)=Size(F)-1 then
		d := DimensionsMat(M);
		drows := d[1];
		dcols := d[2];
#			AppendTo(output, "\\begin{displaymath}\\tiny \n");
			AppendTo(output, "\\left[ \n");
			AppendTo(output, "\\setcounter{MaxMatrixCols}{", dcols, "} \n");
			AppendTo(output, "\\begin{matrix} \n");
			for i in [1..drows] do
				row := M[i];
				for j in [1..dcols] do
				  ffe := row[j];
				  WriteTEXFFEByGeneratorNM(output,  ffe, strGen, gen);
					if j<dcols then AppendTo(output, "&");
					else  AppendTo(output, "\\");
					fi;
				od;
				AppendTo(output, "\\\n");
			od;
		AppendTo(output, "\\end{matrix} \\right] \n");
#		AppendTo(output, "\\end{displaymath} \n");
		else	Error(gen," is not a generator of ",F,"!!!!\n");
		fi;
	else 	Error(strGen," is not a string !!!!\n");
	fi;
 else	Error("M is not a matrix !!!! \n");
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
   if  IsUnivariatePolynomial(f) then
    if IsString(strGen)  then
     if Order(gen)=Size(F)-1 then
      coeffvec := Reversed(CoefficientsOfUnivariatePolynomial(f));
      m := Degree(f);
      AppendTo(output,  "$");

      for i in [1 .. Length(coeffvec)-2] do
        ffe := coeffvec[i];
        if IsZero(ffe) then  continue;
        elif IsOne(ffe) then AppendTo(output, strIndet, "^{",m-(i-1),"}+");
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
      if IsZero(ffe)  then  AppendTo(output,  " ");
      elif IsOne(ffe) then  AppendTo(output, strIndet, "+");
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
      if IsOne(ffe) then  AppendTo(output,"1");
      else
         exp := LogFFE(ffe,gen);
         if exp = 1 then 	AppendTo(output, "\\", strGen);
         else 		  			AppendTo(output, "\\", strGen,"^{",exp,"}");
         fi;
      fi;
      AppendTo(output,  "$");
      else		Error(gen," is not a generator of ",F,"!!!!\n");
      fi;
    else	Error(strGen," is not a string   !!!!\n");
    fi;
  else	Error(f," is not a an univariate polynomial !!!!\n");
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
## WriteTEXMultivarFFPolyByGenerator    --FIXED for sym :)
##
InstallGlobalFunction(WriteTEXMultivarFFPolyByGenerator,
function(output,  F, mpoly, strGen, gen)
local ffe, i, j,mof, idx, pwr, m, exp, clist, mlist, mofstr, xtrue, strue,
varstr, varconst;
	clist := SplitCoeffsAndMonomials(F, mpoly)[1];
	mlist := SplitCoeffsAndMonomials(F, mpoly)[2];
 	mof := ReduceMonomialsOverField(F, mlist); # must reduce BEFORE split!
AppendTo(output,  "$");
# get all the indeterminates in all monomials
	for i in [1 .. Length(mof)] do
		ffe := clist[i];
		if IsPolynomial(mof[i]) and not IsOne(mof[i])  then # to account for case when we have constants
			mofstr := SplitString(String(mof[i]), "_", "*");
			strue :=  \in("s", mofstr);
			xtrue :=  \in("x", mofstr);
			if strue and xtrue then
				Error("only works for monomials with either x_i or s_i");
				return;
			elif not (strue or xtrue) then
				Error("only works for monomials with x_i or s_i");
				return;
			elif strue then varstr := "s"; varconst := 3800;
			else varstr := "x"; varconst := 800;
			fi;
			m := LeadingMonomial(mof[i]);
			if IsZero(ffe) then 	 			continue;
			elif IsOne(ffe) then
				for j in [1..Length(m)-1] do
					if IsOddInt(j) then
						idx := m[j] - varconst; # symbols or indeterminates
						pwr := m[j+1];
					 if   pwr = 1 then 	AppendTo(output, varstr, "_{",idx,"}");
					 elif pwr = 0 then 	AppendTo(output, "");
					 else								AppendTo(output, varstr, "_{",idx,"}^{",pwr,"}");
					 fi;
					fi;
				od;
	 		else
	 			exp := LogFFE(ffe,gen);
	 			if exp = 1 then			AppendTo(output, "\\",strGen," ");
	 			else								AppendTo(output, "\\", strGen,"^{",exp,"} ");
	 			fi;
				for j in [1..Length(m)-1] do
					if IsOddInt(j) then
						idx := m[j] - varconst;
						pwr := m[j+1];
						if pwr = 1 then 	AppendTo(output, varstr, "_{",idx,"}");
					  elif pwr = 0 then	AppendTo(output, "");
 					  else							AppendTo(output, varstr, "_{",idx,"}^{",pwr,"}");
 					  fi;
					fi;
				od;
			fi;
	 		else # constant term
			if IsOne(ffe) then		AppendTo(output,"1");
			else
				 exp := LogFFE(ffe,gen);
				 if exp = 1 then 		AppendTo(output, "\\", strGen);
				 else 		 					AppendTo(output, "\\", strGen,"^{",exp,"}");
				 fi;
			fi;
		fi;
			if i<Length(mof) then	AppendTo(output, "+");	fi;
	od;
	AppendTo(output,  "$");
  return;
 end);





 #############################################################################
 ##
 ##  WriteTEXSymVecByGenerator - for sym
 ##
 InstallGlobalFunction(WriteTEXSymVecByGenerator ,
 function(output, F, vec, strGen, gen)
 local j, mv;
	AppendTo(output,  "[ ");
	for j in [1.. Length(vec)] do
		mv := vec[j];
		AppendTo(output,  "\\;\t");
		WriteTEXMultivarFFPolyByGenerator(output, F, mv, strGen, gen);
		if j < Length(vec) then
			AppendTo(output,  "\n,");
		fi;
	od;
	AppendTo(output, "\\;]\n");
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
		else	Error(gen," is not a generator of ",F,"!!!!\n");
		fi;
	else	Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
	fi;
return;
end);


InstallGlobalFunction(WriteTEXBasisByGenerator,
 function(output, F, B, strGen, gen)
SetPrintFormattingStatus(output, false);
	 if IsBasis(B) and (Length(B) = Dimension(F)) then
					AppendTo(output,  "B = [$\\beta_i$] = ");
					WriteTEXFFEVecByGenerator(output, F, BasisVectors(B), strGen, gen);
	else	Error(B,"is not a basis or does not match the field!!!!!\n");
	fi;
 return;
end);

InstallGlobalFunction(WriteTEXElementTableByGenerator,
 function(output, F, B, strGen, gen)
local  i,j, elms,  eb, elm;

SetPrintFormattingStatus(output, false);
			if IsString(strGen) and  strGen <> "omega" then
				if Order(gen)=Size(F)-1 then
	 				if IsBasis(B) and (Length(B) = Dimension(F)) then
								 elms := Elements(F);
										# starte table
								AppendTo(output,  "{\\footnotesize\n \\begin{table}[h!]\n");
								AppendTo(output,  "\\begin{center}");
								AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
								AppendTo(output,  "\\begin{tabular}{|c|");
								for i in [1.. Length(B)] do
										AppendTo(output,  "c");
								od;
								AppendTo(output,  "|c");
								AppendTo(output,  "|} \n\\hline\n");
								AppendTo(output,"elm&\\multicolumn{",Length(B));
								AppendTo(output,"}{c|}{given basis B}& \\\\\n");
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
									if IsZero(elm) then 	AppendTo(output, "-");
									else									AppendTo(output, Order(elm));
									fi;
									eb := IntFFExt(B,elm);
									for j in [1.. Length(B)] do
											if IsZero(eb[j]) then
												AppendTo(output, "&\\, ",VecToString(eb[j]),"\\,");
											else
												AppendTo(output,  "	&\\, ",VecToString(eb[j]),"\\,");
											fi;
									od;
									AppendTo(output,  "&\\,");
									WriteTEXFFEByGenerator(output, elm, strGen, gen);
									AppendTo(output,  " \\\\\n");
								od;
								# end table
								AppendTo(output, "\\hline\n");
								AppendTo(output, "\\end{tabular}}\n");
 								AppendTo(output, "\\caption{{\\footnotesize ");
 								AppendTo(output, "Element table for ");
 				WriteTEXFF(output, F);
 								AppendTo(output," using basis ");
				WriteTEXBasisByGenerator(output, F, B, strGen, gen);
 								AppendTo(output," with generator $\\",strGen,"$\\quad");
				WriteTEXGeneratorWRTDefiningPolynomial(output, F, strGen, gen);
								AppendTo(output, ".}}\\label{LABEL}");
								AppendTo(output,  "\\end{center}\n\\end{table}\n}");
							  AppendTo(output,  " \n");
					 else	Error(B,"is not a basis or does not match the field!!!!!\n");
					 fi;
				else 	Error(gen," is not a generator of ",F,"!!!!\n");
				fi;
			else	Error(strGen," is not a string  or is equal to \"omega\" !!!!\n");
			fi;
	return ;
end);


Print("outputs.gi OK,\t");
#E  outputs.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
