#############################################################################
##
#W  nlfsr.gi                   GAP Package                   nusa zidaric
##
##

#############################################################################
##
## create an NLFSR object 
##
#F  NLFSR( <K>, <mpoly> , <len> ) . . . . . . . . . . . . . . . . . . .  # len 3
#F  NLFSR( <K>, <clist>, <mlist> , <len> )  . . . . . . . . . . . . . .  # len 4
#F  NLFSR( <K>, <fieldpol>,  <mpoly>, <len> ) . . . . . . . . . . . . .  # len 4
#F  NLFSR( <K>, <mpoly> , <len> , <tap>)    . . . . . . . . . . . . . .  # len 4
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len> )  . . . . . . . .  # len 5
#F  NLFSR( <K>, <clist>, <mlist> , <len> , <tap>)   . . . . . . . . . .  # len 5
#F  NLFSR( <K>, <fieldpol>, <mpoly> , <len>, <tap> )  . . . . . . . . .  # len 5
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len>, <tap> ) . . . . .  # len 6

InstallGlobalFunction( NLFSR,  function(arg)

local K, F, multpol, fieldpol, clist, mlist, m, n, tap, y, mpol, cm,	# for args
    fam, fb, st, coefs, nlfsr, d, i, j , idx, indlist, xlist, slist , mof, lin, basis, ml, cl;	# for constructor



# figure out which constructor is being used

if Length(arg)=3 then 
	if IsField(arg[1]) and IsPolynomial(arg[2]) and IsPosInt(arg[3]) then 	
			#F   FILFUN( <K>, <mpoly>, <len>  ) 
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);fieldpol := DefiningPolynomial(F);
			fi;
			mpol := arg[2];
			cm := SplitCoeffsAndMonomials(F, mpol);
			clist := cm[1];
			mlist := cm[2];
			d := arg[3]; tap := [0];
	else Error("check the args!!!"); 		return fail;
	fi;			


elif  Length(arg)=4 then
	if IsField(arg[1]) and IsPolynomial(arg[2]) and IsPolynomial(arg[3]) 
		and IsPosInt(arg[4]) then 	
			#F  NLFSR( <K>, <fieldpol>,  <mpoly>, <len> ) 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol);
			mpol := arg[3];
			cm := SplitCoeffsAndMonomials(F, mpol);
			clist := cm[1];
			mlist := cm[2];			
			d := arg[4]; tap := [0];


	elif IsField(arg[1]) and IsRingElementCollection(arg[2]) and IsList(arg[3]) and IsPosInt(arg[4]) then 	
			#F  NLFSR( <K>, <clist>, <mlist> , <len> )
			# we dont allow anything thats not a prime here, coz primepower is already an extension
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F);
			fi;
			clist := arg[2]; mlist := arg[3];
			d := arg[4]; tap := [0];
	elif IsField(arg[1]) and IsPolynomial(arg[2]) and IsPosInt(arg[3]) then 	
	  #NLFSR( <K>, <mpoly> , <len> , <tap>)  . . . .  create an NLFSR object 	# len 4		
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F);
			fi;
			mpol := arg[2];
			cm := SplitCoeffsAndMonomials(F, mpol);
			clist := cm[1];
			mlist := cm[2];			
			d := arg[3]; 
			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then		tap := [arg[4]];
			elif  IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	else Error("check the args!!!"); 		return fail;
	fi;
elif  Length(arg)=5 then
	if  IsField(arg[1]) and IsPolynomial(arg[2]) and IsRingElementCollection(arg[3]) 
		 and IsList(arg[4]) and IsPosInt(arg[5]) then 	
			#F   NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len> )
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol);
			clist := arg[3]; mlist := arg[4];
			d := arg[5]; tap := [0];			
	elif IsField(arg[1]) and IsRingElementCollection(arg[2]) and IsList(arg[3]) 
			and IsPosInt(arg[4])  then 			
			#F NLFSR( <K>, <clist>, <mlist> , <len> , <tap>) 
			# we dont allow anything thats not a prime here,
			# coz primepower is already an extension
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);fieldpol := DefiningPolynomial(F);
			fi;
			clist := arg[2]; mlist := arg[3];
			d := arg[4]; 
	
			if 	IsPosInt(arg[5]) or IsZero(arg[5]) then		tap := [arg[5]];
			elif  IsRowVector(arg[5]) then 			tap := arg[5];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	elif IsField(arg[1]) and IsPolynomial(arg[2]) and IsPolynomial(arg[3]) 
			and IsPosInt(arg[4]) then 	
	#F  NLFSR( <K>, <fieldpol>, <mpoly> , <len>, <tap> )  . . . .  create an NLFSR object 	# len 5

			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol);
			mpol := arg[3];
			cm := SplitCoeffsAndMonomials(F, mpol);
			clist := cm[1];
			mlist := cm[2];			
			d := arg[4]; 
			if 	IsPosInt(arg[5]) or IsZero(arg[5]) then		tap := [arg[5]];
			elif  IsRowVector(arg[5]) then 			tap := arg[5];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	
	else Error("check the args!!!"); 		return fail;
	fi;
elif  Length(arg)=6 then
	if  IsField(arg[1]) and IsPolynomial(arg[2]) and IsRingElementCollection(arg[3]) 
			and IsList(arg[4]) and IsPosInt(arg[5]) then 	
			#F   NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len>, <tap> ) 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol);
			clist := arg[3]; mlist := arg[4];
			d := arg[5];
			
			if 	IsPosInt(arg[6]) or IsZero(arg[6]) then		tap := [arg[6]];
			elif  IsRowVector(arg[6]) then 			tap := arg[6];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	else Error("check the args!!!"); 		return fail;
	fi;

# whatever input constructors - undefined
else Error("check the args!!!"); 		return fail;
fi;




# check coeffs and monomials
	if Length(clist)<>Length(mlist) then 
		Error("coeff and monomial lists must have same length!!!");
				return fail;
	fi;
	for i in [1..Length(clist)] do
		if not (\in(clist[i], F)) then
			Error( "coefficient ",clist[i], "at index=",i,"is not an element of the underlying field !!!" );
					return fail;
		fi;	
	od;
	
# get the feedback poly

# whatif1: what if they cancel out !!!
#	 mof := ReduceMonomialsOverField(F, mlist);
#	 multpol := clist * mof; 

# fix for whatif1
	 multpol := ReduceMonomialsOverField(F, clist * mlist); 

	 lin := (DegreeOfPolynomialOverField(F,multpol)=1);
	 if lin then 
		Error("Feedback is linear, create an LFSR instead!!!"); 		return fail;
	 fi;
# fix for whatif1
cl := SplitCoeffsAndMonomials(F, multpol)[1];
ml := SplitCoeffsAndMonomials(F, multpol)[2];	
	

	indlist := []; 
# get all the indeterminates in all monomials
	for i in [1 .. Length(ml)] do 
		if IsPolynomial(ml[i]) then # to account for case when we have constants 
			m := LeadingMonomial(ml[i]);
	#		Print(m,"\n");
			for j in [1..Length(m)] do 
				if IsOddInt(j) then 
					idx := m[j] - 800;
					if idx >= d then 
						Error("Feedback needs an element from a stage that does not exist ( out of range) !!!"); 	return fail;
					fi;
					Add(indlist, m[j] - 800 ); 
					# get all the indeterminates in this monomial
				fi;
			od;
		fi;
	od;
	
	# get ridof duplicate indeces: DuplicateFreeList(
	indlist :=  DuplicateFreeList(indlist);
#	Print(indlist,"\n");
#	xlist :=[]; 
#	for i in [1.. Length(indlist)] do
#		Add(xlist,Indeterminate(F,800+indlist[i]));
#	od;
#	Print(xlist,"\n");		
	
#	for i in [1 .. Length(indlist)] do 
#		Add(varlist , xlist[indlist[i] + 1]);
#	od;
	


# set state to all 0 
	st := [];
	for i in [1.. d] do 
		st[i] := Zero(F); 
	od;
	
# set taps

	for i in [1.. Length(tap)] do 
		if (tap[i]<0 or tap[i]>d) then 
			Print("argument tap[",i,"]=",tap[i]," is out of range 0..",d-1);
			Print(", or not given => im taking S_0 instead!\n");
			tap[i] := 0;
		fi;
	od;	
# new NLFSR :) 
	fam :=FSRFamily(Characteristic(K));
	nlfsr := Objectify(NewType(fam, IsFSRRep),   
			rec(init:=st, state:= st, numsteps := -1, basis := CanonicalBasis(F)));

	SetFieldPoly(nlfsr,fieldpol);
	SetUnderlyingField(nlfsr,F);
	SetMultivarPoly(nlfsr,multpol);  
	SetIsNonLinearFeedback(nlfsr, (not lin));  
	SetIsLinearFeedback(nlfsr, lin);  
	SetIsFSRFilter(nlfsr, false);  	
	#SetFeedbackVec(nlfsr,clist);    # fix for whatif1
	SetFeedbackVec(nlfsr,cl);    
	#SetMonomialList(nlfsr, mlist ); 	# fix for whatif1
	SetMonomialList(nlfsr, ml );
	SetIndetList(nlfsr, indlist );
	SetLength(nlfsr,d); 
	SetOutputTap(nlfsr,tap); # this is S_tap or default S_0



return nlfsr;
end);



InstallMethod( ConstTermOfNLFSR, "const term of the multivariate polynomial",  	
	[IsNLFSR], function(x)
local F, tlist, clist, i, const;
	F := UnderlyingField(x);
	const := Zero(F);
	tlist := MonomialList(x);
	clist := FeedbackVec(x);
	for i in [1..Length(tlist)] do
		if tlist[i] = One(F) then 
			const := clist[i]; 
		fi;	 
	od;
return const;
end);



#new := Value(MultivarPoly, strlist, statelist);
# looks like GAP will compute the result in a larger field 
#(that constains the default fields of all the values that enter
# computation as subfield)
#must manually check if : new in F


#	if not(\in(new,F)) then
#	Error( "computed feedback is not an element of the underlying field !!!" );
#		return fail;
#	fi;



Print("nlfsr.gi OK,\t");
