#############################################################################
##
#W  fsrfil.gi                   GAP Package                   nusa zidaric
##
##

#############################################################################
##
#F  FILFUN( <K>, <mpoly>  )   . . . . . . . . . . . . . create  FILFUN # len 2
#F  FILFUN( <K>, <clist>, <mlist>  )  . . . . . . . . . create  FILFUN # len 3
#F  FILFUN( <K>, <fieldpol>, <clist>, <mlist> ,)  . . . create  FILFUN # len 4


InstallGlobalFunction( FILFUN,  function(arg)

local K, F, multpol, fieldpol, clist, mlist, m, n, y, mpol, cm, 	# for args
    fam, fb, st, coefs, fsrfil, d, i, j , idx, indlist, xlist, slist , mof, lin, basis, ml, cl;	# for constructor

# figure out which constructor is being used

if Length(arg)=2 then 
	if IsField(arg[1]) and IsPolynomial(arg[2]) then 	
			#F   FILFUN( <K>, <mpoly> ) 
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);fieldpol := DefiningPolynomial(F);
			fi;
			mpol := arg[2];
			cm := SplitCoeffsAndMonomials(F, mpol);
			clist := cm[1];
			mlist := cm[2];
	else Error("check the args!!!"); 		return fail;
	fi;			



elif  Length(arg)=3 then
	if IsField(arg[1]) and IsRingElementCollection(arg[2]) and IsList(arg[3]) then 	
			#F   FILFUN( <K>, <clist>, <mlist> ) 
			# we dont allow anything thats not a prime here, coz primepower is already an extension
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);fieldpol := DefiningPolynomial(F);
			fi;
			clist := arg[2]; mlist := arg[3];
	else Error("check the args!!!"); 		return fail;
	fi;
elif  Length(arg)=4 then
	if  IsField(arg[1]) and IsPolynomial(arg[2]) and IsRingElementCollection(arg[3]) 
			and IsList(arg[4]) then 	
			#F   NLFSR( <K>, <fieldpol>, <clist>, <mlist> )
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol);
			clist := arg[3]; mlist := arg[4];
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

					Add(indlist, m[j] - 800 ); 
					# get all the indeterminates in this monomial
				fi;
			od;
		fi;
	od;
	
	# get ridof duplicate indeces: DuplicateFreeList(
	indlist :=  DuplicateFreeList(indlist);
	
	d := Length(indlist);


# set state to all 0 
#	st := [];
#	for i in [1.. d] do 
#		st[i] := Zero(F); 
#	od;
	st := ListWithIdenticalEntries( d, Zero(F) );	
	
# new FILFUN :) 
	fam :=FSRFamily(Characteristic(K));
	fsrfil := Objectify(NewType(fam, IsFSRRep),   
			rec(init:=st, state:= st, numsteps := 0, basis := CanonicalBasis(F)));
#	fsrfil := Objectify(NewType(fam, IsFSRRep),   
#	rec(state:= st, numsteps := 0, basis := CanonicalBasis(F)));
#  without init works just fine, but rather not since there are so many methods 
#  maybe one of em uses init 
#  just keep init = state at all times, doesnt bother noone 

	SetFieldPoly(fsrfil,fieldpol);
	SetUnderlyingField(fsrfil,F);

	SetIsNonLinearFeedback(fsrfil, false);  
	SetIsLinearFeedback(fsrfil, false); 
	SetIsFSRFilter(fsrfil, true);  
	
	SetIsNonLinearFSRFilter(fsrfil, (not lin));  
	SetIsLinearFSRFilter(fsrfil, lin);
	 
	SetMultivarPoly(fsrfil,multpol);  
	#SetFeedbackVec(fsrfil,clist);    # fix for whatif1
	SetFeedbackVec(fsrfil,cl);    
	#SetMonomialList(fsrfil, mlist ); 	# fix for whatif1
	SetMonomialList(fsrfil, ml );
	SetIndetList(fsrfil, indlist );
	SetLength(fsrfil,d); 
	SetOutputTap(fsrfil,[0]); 
	#misuse the term OutputTap for easier GAPtoVHDL - it will generate one output


return fsrfil;
end);



InstallMethod( ConstTermOfFILFUN, "const term of the multivariate polynomial", 
	 [IsFILFUN], function(x)
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
# must manually check if : new in F


#	if not(\in(new,F)) then
#		Error( "computed feedback is not an element of the underlying field !!!");
#		return fail;
#	fi;



Print("fsrfil.gi OK,\t");
