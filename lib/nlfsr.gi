#############################################################################
##
#W  nlfsr.gi                   GAP Package                   nusa zidaric
##
##

#############################################################################
##
#F  NLFSR( <K>, <clist>, <mlist> , <len> )  . . . .  create an LFSR object 	# len 4
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len> )  . . . .  create an LFSR object 	# len 5
#F  NLFSR( <K>, <clist>, <mlist> , <len> , <tap>)  . . . .  create an LFSR object 	# len 5
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len>, <tap> )  . . . .  create an LFSR object 	# len 6


InstallGlobalFunction( NLFSR,  function(arg)

local K, F, multpol, fieldpol, clist, mlist, m, n, tap, y,	# for args
    fam, fb, st, coefs, nlfsr, d, i, j , indlist, nonlin;	# for constructor

# figure out which constructor is being used

if  Length(arg)=4 then
	if IsField(arg[1]) and IsFFECollection(arg[2]) and IsList(arg[3]) and IsPosInt(arg[4]) then 	
			#F  NLFSR( <K>, <clist>, <mlist> , <len> )
			# we dont allow anything thats not a prime here, coz primepower is already an extension
			if IsPrimeField(arg[1]) then K:= GF(arg[1]);  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F);
			fi;
			clist := arg[2]; mlist := arg[3];
			d := arg[4]; tap := [0];


#	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  then  
#			#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)
#			K := arg[1]; fieldpol := arg[2]; 
#			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
#				Error("defining polynomial of the extension field must be irreducible!!!");
#						return fail;
#			fi;
#			F := FieldExtension(K,fieldpol);
#			charpol := arg[3];
#			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then		tap := [arg[4]];
#			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
#			else 	Error("check the tap arg !!!"); 		return fail;
#			fi;
		
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
			Error( "coefficient at index=",i,"is not an element of the underlying field !!!" );
					return fail;
		fi;	
	od;
	
	indlist := []; 
# get all the indeterminates in all monomials
	for i in [1 .. Length(mlist)] do 
		m := LeadingMonomial(mlist[i]);
		for j in [1..Length(m)] do 
			if IsOddInt(j) then 
				idx := m[j] - 1000;
				if idx >= d then 
					Error("Feedback contains an indeterminate thats out of range!!!"); 	return fail;
				fi;
				Add(indlist, m[j] - 1000 ); # get all the indeterminates in this monomial
			fi;
		od;
	od;
	# get ridof duplicate indeces: DuplicateFreeList(
	indlist :=  DuplicateFreeList(indlist);
	
#	for i in [1 .. Length(indlist)] do 
#		Add(varlist , xlist[indlist[i] + 1]);
#	od;
	
# get the feedback poly
	 multpol := clist * mlist; 
	 nonlin := (DegreeOfPolynomial(F,multpol)>1);
	 if not nonlin then 
		Error("Feedback is NOT linear, create an LFSR instead!!!"); 		return fail;
	 fi;

# set state to all 0 
	st := [];
	for i in [1.. d] do 
		st[i] := Zero(F); 
	od;
	
# set taps

	for i in [1.. Length(tap)] do 
		if (tap[i]<0 or tap[i]>d) then 
			Print("argument tap[",i,"]=",tap[i]," is out of range 0..",d-1,", or not given => im taking S_0 instead!\n");
			tap[i] := 0;
		fi;
	od;	
# new LFSR :) 
	fam :=FSRFamily(Characteristic(K));
	nlfsr := Objectify(NewType(fam, IsNLFSRRep),   rec(init:=st, state:= st, numsteps := -1));

	SetFieldPoly(nlfsr,fieldpol);
	SetUnderlyingField(nlfsr,F);
	SetMultivarPoly(nlfsr,multpol);  
	SetIsNonLinearFeedback(nlfsr, nonlin);  
	SetFeedbackVec(nlfsr,clist);    
	SetIndetList(nlfsr, indlist );
	SetLength(nlfsr,d); 
	SetOutputTap(nlfsr,tap); # this is S_tap or default S_0



return nlfsr;
end);

















#new := Value(MultivarPoly, strlist, statelist);
# looks like GAP will compute the result in a larger field 
#(that constains the default fields of all the values that enter computation as subfield)
#must manually check if : new in F


#	if not(\in(new,F)) then
#		Error( "computed feedback is not an element of the underlying field !!!" );		return fail;
#	fi;
