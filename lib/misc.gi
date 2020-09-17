#############################################################################
##
#W  misc.gi                   GAP Package                   nusa zidaric
##
##


#############################################################################
##
#F  ChooseField( <F> )
##
##  choose the underlying finite field for the NLFSR
##  needed to create the indeterminates !!!!
##  :(
## ugly, take a second look at it !!!!
##

MaxNLFSRLen := 200;
MaxNrOfPresentMonomials := 200;

InstallGlobalFunction( ChooseField, function( F )
    local x, i , str,  xlist, s, strs, slist ;

	if(IsField(F)) then
		x := X(F, "x"); s := X(F, "s");
#		MaxNLFSRLen := 200;
#		MaxNrOfPresentMonomials := 200;
#		if not IsBoundGlobal("MaxNLFSRLen") then
#			BindGlobal("MaxNLFSRLen" , 200);
#			BindGlobal("MaxNrOfPresentMonomials" , 200);
#			MakeReadWriteGlobal("MaxNLFSRLen");
#			MakeReadWriteGlobal("MaxNrOfPresentMonomials");
#		fi;

		xlist := []; slist := [];
		for i in [1..MaxNLFSRLen] do
			str :=  Concatenation("x_",String(i-1));
			strs :=  Concatenation("s_",String(i-1));
			if IsBoundGlobal(str) then
	#			Print("changing: ",str," \n");
				str := Indeterminate(F,1000+(i-1));
				strs := Indeterminate(F,4000+(i-1));
			else

	#			Print("binding: ",str," \n");
				SetIndeterminateName(FamilyObj(x), 800+(i-1), str);
				SetIndeterminateName(FamilyObj(x), 3800+(i-1), strs);
				BindGlobal(str,Indeterminate(F,800+(i-1)));
				BindGlobal(strs,Indeterminate(F,3800+(i-1)));
				MakeReadWriteGlobal(str);
				MakeReadWriteGlobal(strs);
			fi;
			Add(xlist, str );
			Add(slist, strs );
		od;
		if not IsBoundGlobal("xlist") then
			BindGlobal("xlist" , xlist);
		fi;
		if not IsBoundGlobal("slist") then
			BindGlobal("slist" , slist);
		fi;
#Print("\nYou can now create an NLFSR or FILFUN with up to ", MaxNLFSRLen );
#Print("variables\n with up to  ", MaxNrOfPresentMonomials ," nonzero terms\n");

Print("\nYou can now use ", MaxNLFSRLen );
Print(" variables x_0 ...x_", MaxNLFSRLen -1 ,"\n");
	else
	    Error("F is not a field !!!! \n");
	  fi;
return;
end );




#############################################################################
##
#M  TrimLeadCoeff(<coefs>) 			Trim the leading coefficient
##
##

InstallMethod( TrimLeadCoeff, "Trim the leading coefficient off the list",
[IsRingElementCollection and IsRowVector], function(coefs)
  local trimmed, i;
  trimmed := [];
  for i in [1..Length(coefs)-1] do
  	trimmed[i] := coefs[i];
  od;
  return trimmed;
end);

InstallMethod( IdxNonzeroCoeffs, "Indeces of nonzero coefficients of the list",
  [IsRingElementCollection and IsRowVector], function(coefs)
  local t, tlist, len, i, K;
  len := Length(coefs);
  tlist := [];
  for i in [1.. len] do
  	if not (coefs[i] = Zero(PrimeField(DefaultField(coefs)))) then
  		Add(tlist,i);
  	fi;
  od;
  return tlist;
end);

InstallMethod( NrNonzeroCoeffs, "Number of nonzero indeces",
[IsRingElementCollection and IsRowVector], function(coefs)
  return Length(IdxNonzeroCoeffs(coefs));
end);


InstallMethod( LeadingTerm, "leading term with coefficient w.r.t. K",
[ IsField, IsPolynomial], function(K, mon)
local lmlist, term , i;
	lmlist := LeadingMonomial(mon);
	term := LeadingCoefficient(mon);
	if (not term in K) then
			Error("coefficient ",term," does not belong to field ",K, "!!!\n");
				return fail;
	fi;
		for i in [1..Length(lmlist)-1] do
			if IsOddInt(i) then
				term := term * Indeterminate(K, lmlist[i])^(lmlist[i+1] );
			fi;
		od;
return term;
end);

InstallMethod( TermOverField, "reduce exponents of leading monomial",
[IsField, IsPolynomial], function(K, mon)
local cm, lmlist, term , m, i;
	lmlist := LeadingMonomial(mon);
	term := LeadingCoefficient(mon);
	if (not term in K) then
			Error("coefficient ",term," does not belong to field ",K, "!!!\n");
				return fail;
	fi;
	if (IsPrimeField(K) and Characteristic(K)=2) then
		for i in [1..Length(lmlist)] do
			if IsOddInt(i) then
				term := term * Indeterminate(K, lmlist[i]);
	 	 # in F_2: a^n = a for all n>0
			fi;
		od;
	else
		m := Size(K)-1;
		for i in [1..Length(lmlist)-1] do
			if IsOddInt(i) then
				term := term * Indeterminate(K, lmlist[i])^(lmlist[i+1] mod m);
			fi;
		od;
	fi;
return term;
end);

InstallMethod( MonomialOverField, "reduce exponents of leading monomial",
[IsField, IsPolynomial], function(K, mon)
local cm, lmlist, term , m, i;
	lmlist := LeadingMonomial(mon);
	term := One(K);
	if (not term in K) then
			Error("coefficient ",term," does not belong to field ",K, "!!!\n");
				return fail;
	fi;
	if (IsPrimeField(K) and Characteristic(K)=2) then
		for i in [1..Length(lmlist)] do
			if IsOddInt(i) then
				term := term * Indeterminate(K, lmlist[i]);
				 # in F_2: a^n = a for all n>0
			fi;
		od;
	else
		m := Size(K)-1;
		for i in [1..Length(lmlist)-1] do
			if IsOddInt(i) then
				term := term * Indeterminate(K, lmlist[i])^(lmlist[i+1] mod m);
			fi;
		od;
	fi;
return term;
end);

InstallMethod( SplitCoeffsAndMonomials, "split to clist and mlist",
[ IsField, IsPolynomial], function(K, poly)
local clist, mlist, i, condition, term, cf;
	clist := [];
	mlist := [];
	i := 0;
#	condition := (not poly in K);
#	condition := IsPolynomial(poly);
#	condition := not IsRingElement(poly);
	condition := not IsConstantRationalFunction(poly);
#	Print(poly,"-> ",condition,":\t");
#	Display(KnownTruePropertiesOfObject(poly));
#	Display(KnownAttributesOfObject(poly));

	while (condition) do
		term := LeadingTerm(K, poly);
#		Print(i," -> ",term,"\n");
		cf := LeadingCoefficient(poly);
		if (not cf in K) then
			Error("coefficient ",cf," does not belong to field ",K, "!!!\n");
				return fail;
		fi;

		Add(clist, cf);
		Add(mlist, term*Inverse(cf)); # cant be 0 :)
		poly := poly - term;
		i := i+1;
#		condition := (not poly in K);
#	condition := IsPolynomial(poly);
#	condition := not IsRingElement(poly);
	condition := not IsConstantRationalFunction(poly);
#		Print(poly,"-> ",condition,":\t");
#		Display(KnownTruePropertiesOfObject(poly));
#		Display(KnownAttributesOfObject(poly));
	od;

	if not IsZero(poly) then # original poly had a constant term
		Add(clist, LeadingCoefficient(poly));
		Add(mlist, One(K));
	fi;

	if Length(clist) <> Length(mlist) then
	Error("something went wrong: clist and mlist are of different lengths!!!\n");
		return fail;
	fi;

return [clist, mlist];
end);

InstallMethod(ReduceMonomialsOverField, "reduce expomnents of monomials in list",
 [IsField, IsList],  function(K, mlist)
local newlist, i;
		newlist := [];
		for i in [1..Length(mlist)] do
			if IsPolynomial(mlist[i]) then
				newlist[i] := TermOverField(K, mlist[i]);
			else
				newlist[i] := mlist[i];
				# to account for case when we have constants
			fi;
		od;
return newlist;
end);

InstallMethod( ReduceMonomialsOverField, "reduce expomnents of monomials",
[IsField, IsPolynomial], function(K, mon)
  local cm, clist, mlist, poly;

  cm := SplitCoeffsAndMonomials(K, mon);
  # will return fail if some coefficient not a member of K
  clist := cm[1];
  mlist := cm[2];
  mlist := ReduceMonomialsOverField(K, mlist);
  poly := clist * mlist; #exponents w.r.t. K

  return poly;
end);


InstallMethod( LeadingTermOverField, "reduce expomnents of monomials",
[IsField, IsPolynomial], function(K, mon)
local  poly;
	poly := ReduceMonomialsOverField(K, mon); #exponents w.r.t. K
  if not IsConstantRationalFunction(poly) then
  	return TermOverField(K, poly);
  else
  #	Print("tu \n");
  	return poly;
  fi;
end);

InstallMethod( LeadingMonomialOverField, "reduce expomnents of monomials",
[IsField, IsPolynomial], function(K, mon)
local term;
	term := LeadingTermOverField(K, mon); #exponents w.r.t. K
	#Print(term,"-> \t");
	return SplitCoeffsAndMonomials(K, term)[2][1];
end);


InstallMethod( DegreeOfPolynomialOverField, "degree of polynomial",
 [IsField, IsPolynomial], function( K, mon)
 local rmon, lmon, lmlist, d, i;

	d := 0;
 	if IsConstantRationalFunction(mon) then
	#if \in(rmon, K) then # reduces to a constant
		return d;
	else
    rmon := ReduceMonomialsOverField(K, mon); #exponents w.r.t. K
		lmon := LeadingMonomialOverField(K, rmon);
		lmlist := LeadingMonomial(lmon);
		for i in [1..Length(lmlist)] do
			if IsEvenInt(i) then
				d := d + lmlist[i];
			fi;
		od;
		return d;
	fi;
end);


InstallMethod( DegreeOfPolynomialOverField, "degree of multivariate polynomial",
 [IsField, IsRingElementCollection, IsList], function(F, clist, mlist)
local mon;
	if Length(clist)<>Length(mlist) then
		Error("coeff and monomial lists must have same length!!!");
				return fail;
	fi;
	mon := ReduceMonomialsOverField(F, mlist);
  return DegreeOfPolynomialOverField(F, clist * mon);
end);

InstallMethod( ReciprocalPolynomial, "reciprocal polynomial",
 [IsField, IsPolynomial], function(K, poly)
 local  rcoefs ;
rcoefs := Reversed(CoefficientsOfUnivariatePolynomial(poly));  # reversed !!!!
return UnivariatePolynomial(K, rcoefs);
end);

#############################################################################
##
#M  GeneratorOfField( <F> )    . . . root or gen
##  prefer RootOfDefiningPolynomial to PrimitiveRoot

InstallMethod(  GeneratorOfField, "generator of underlying field",
[IsField and IsFinite], function(F)
local w;
	w := RootOfDefiningPolynomial(F);
	if Order(w)=Size(F)-1 then return w;
	else return First(Elements(F),x->not IsZero(x) and Order(x)=Size(F)-1);
	fi;
end);

#############################################################################
##
#M  GeneratorWRTDefiningPolynomial( <F> )    . . . .. get generator of zechs log
## dont remember why i needed that :(

InstallMethod( GeneratorWRTDefiningPolynomial, "generator of underlying field",
  [IsField and IsFinite], function(F)
	return Coefficients(Basis(F), GeneratorOfField(F));
end);



Print("misc.gi OK,\t");
