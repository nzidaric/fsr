#############################################################################
##
#W  nlfsr.gi                   GAP Package                   nusa zidaric
##
##

#############################################################################
##
#F  NLFSR( <K>, <clist>, <mlist> , <len> )  . . . .  create an NLFSR object 	# len 4
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len> )  . . . .  create an NLFSR object 	# len 5
#F  NLFSR( <K>, <clist>, <mlist> , <len> , <tap>)  . . . .  create an NLFSR object 	# len 5
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len>, <tap> )  . . . .  create an NLFSR object 	# len 6


InstallGlobalFunction( NLFSR,  function(arg)

local K, F, multpol, fieldpol, clist, mlist, m, n, tap, y,	# for args
    fam, fb, st, coefs, nlfsr, d, i, j , idx, indlist, xlist, slist , mof, lin;	# for constructor

# figure out which constructor is being used

if  Length(arg)=4 then
	if IsField(arg[1]) and IsFFECollection(arg[2]) and IsList(arg[3]) and IsPosInt(arg[4]) then 	
			#F  NLFSR( <K>, <clist>, <mlist> , <len> )
			# we dont allow anything thats not a prime here, coz primepower is already an extension
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F);
			fi;
			clist := arg[2]; mlist := arg[3];
			d := arg[4]; tap := [0];
	else Error("check the args!!!"); 		return fail;
	fi;
elif  Length(arg)=5 then
	if  IsField(arg[1]) and IsPolynomial(arg[2]) and IsFFECollection(arg[3]) and IsList(arg[4]) and IsPosInt(arg[5]) then 	
			#F   NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len> )
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol);
			clist := arg[3]; mlist := arg[4];
			d := arg[5]; tap := [0];			
	elif IsField(arg[1]) and IsFFECollection(arg[2]) and IsList(arg[3]) and IsPosInt(arg[4])  then 			
			#F NLFSR( <K>, <clist>, <mlist> , <len> , <tap>) 
			# we dont allow anything thats not a prime here, coz primepower is already an extension
			if IsPrimeField(arg[1]) then K:= arg[1];  F := arg[1]; fieldpol := 1;
			else F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F);
			fi;
			clist := arg[2]; mlist := arg[3];
			d := arg[4]; 
	
			if 	IsPosInt(arg[5]) or IsZero(arg[5]) then		tap := [arg[5]];
			elif  IsRowVector(arg[5]) then 			tap := arg[5];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	else Error("check the args!!!"); 		return fail;
	fi;
elif  Length(arg)=6 then
	if  IsField(arg[1]) and IsPolynomial(arg[2]) and IsFFECollection(arg[3]) and IsList(arg[4]) and IsPosInt(arg[5]) then 	
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
			Error( "coefficient at index=",i,"is not an element of the underlying field !!!" );
					return fail;
		fi;	
	od;
	
	indlist := []; 
# get all the indeterminates in all monomials
	for i in [1 .. Length(mlist)] do 
		m := LeadingMonomial(mlist[i]);
#		Print(m,"\n");
		for j in [1..Length(m)] do 
			if IsOddInt(j) then 
				idx := m[j] - 1000;
				if idx >= d then 
					Error("Feedback needs an element from a stage that does not exist ( out of range) !!!"); 	return fail;
				fi;
				Add(indlist, m[j] - 1000 ); # get all the indeterminates in this monomial
			fi;
		od;
	od;
	
	# get ridof duplicate indeces: DuplicateFreeList(
	indlist :=  DuplicateFreeList(indlist);
#	Print(indlist,"\n");
#	xlist :=[]; 
#	for i in [1.. Length(indlist)] do
#		Add(xlist,Indeterminate(F,1000+indlist[i]));
#	od;
#	Print(xlist,"\n");		
	
#	for i in [1 .. Length(indlist)] do 
#		Add(varlist , xlist[indlist[i] + 1]);
#	od;
	
# get the feedback poly

 	 mof := MonomialsOverField(F, mlist);
	 multpol := clist * mof; 
	 lin := (DegreeOfPolynomial(multpol)=1);
	 if lin then 
		Error("Feedback is linear, create an LFSR instead!!!"); 		return fail;
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
	SetIsNonLinearFeedback(nlfsr, (not lin));  
	SetIsLinearFeedback(nlfsr, lin);  
	SetFeedbackVec(nlfsr,clist);    
	SetIndetList(nlfsr, indlist );
	SetLength(nlfsr,d); 
	SetOutputTap(nlfsr,tap); # this is S_tap or default S_0



return nlfsr;
end);







#############################################################################
##
#M  ViewObj( <nlfsr> ) . . . . . . . . . . . . . . . 
##
InstallMethod( ViewObj,    "for NLFSR",    true,    [ IsNLFSR ],    0,  function( x )
	if x!.numsteps=-1 then 
		Print("< empty NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	else 	
	Print("< NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), "\n>");
	fi;
end );

InstallMethod( Display,
    "for NLFSR",	    true,    [ IsNLFSR ],        0,    function( x )
    ViewObj(x);
end );

#############################################################################
##
#M  PrintObj( <nlfsr> ) . . . . . . . . . . . . . . . . .
##
InstallOtherMethod( PrintObj,     "for NLFSR",    true,    [ IsNLFSR ],    0,  function( x )
	if x!.numsteps=-1 then 
		Print("< empty NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	else 	
		Print("< NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), "\n>");
		Print("\nwith initial state =");
		Print(((x!.init))); # NOT reversed !!!! 
		Print("\nwith current state =");
		Print(((x!.state)));# NOT reversed !!!! 
		Print("\nafter  ",x!.numsteps," steps\n");
	fi;
end );


#############################################################################
##
#M  PrintObj( <nlfsr> ) . . . . . . . . . . . . . . . . .
##
InstallMethod( PrintObj,     "for nLFSR",    true,    [IsBasis, IsNLFSR ],    0,  function( B, x )
	if x!.numsteps=-1 then 
		Print("< empty NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	else 	
		Print("< NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
		Print("\nwith initial state =");
		Print((IntVecFFExt(B, x!.init))); # NOT reversed !!!! 
		Print("\nwith current state =");
		Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!! 
		Print("\nafter  ",x!.numsteps," steps\n");
	fi;
end );

#############################################################################
##
#M  PrintAll( <nlfsr> ) . . . . . . . using GAP native representation of field elms
##
InstallMethod( PrintAll,     "for NLFSR",    true,    [ IsNLFSR ],    0,  function( x )
local uf, tap, i;

	uf := UnderlyingField(x);
	if x!.numsteps=-1 then 
		Print("< empty NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	else 	
		Print("< NLFSR of length ",Length(x)," over ",uf,",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	fi;
	Print("with feedback coeff =");
	Print((FeedbackVec(x))); # NOT reversed !!!!
	Print("\nwith initial state  =");
	Print(((x!.init))); # NOT reversed !!!!
	Print("\nwith current state  =");
	Print(((x!.state)));# NOT reversed !!!!
	Print("\nafter ");
	if x!.numsteps>0 then 
		Print(x!.numsteps," steps\n");
	elif x!.numsteps=0 then 
		Print("loading\n");
	else 	Print("initialization \n");
	fi;
	
	tap := OutputTap(x); 
	if Length(tap)=1 then 
		Print("with output from stage S_",tap[1],"\n");
	else 
		Print("with output from stages S_",tap,"\n");
	fi;
	
end );

#############################################################################
##
#M  PrintAll( <B>,<nlfsr> ) . . . . . . . as binary vectors in a given basis
##
InstallMethod( PrintAll,     "for NLFSR",    true,    [ IsBasis, IsNLFSR ],    0,  function( B , x )
local uf, tap, i;

	uf := UnderlyingField(x);	
	if x!.numsteps=-1 then 
		Print("< empty NLFSR of length ",Length(x),",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	else 	
		Print("< NLFSR of length ",Length(x)," over ",uf,",\n given by MultivarPoly = ", MultivarPoly(x), ">\n");
	fi;
	Print("with feedback coeff =");
	Print(IntVecFFExt(B, FeedbackVec(x))); # NOT reversed !!!!
	Print("\nwith initial state  =");
	Print((IntVecFFExt(B, x!.init))); # NOT reversed !!!!
	Print("\nwith current state  =");
	Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!!
	Print("\nafter ");
	if x!.numsteps>0 then 
		Print(x!.numsteps," steps\n");
	elif x!.numsteps=0 then 
		Print("loading\n");
	else 	Print("initialization \n");
	fi;
	
	tap := OutputTap(x); 
	if Length(tap)=1 then 
		Print("with output from stage S_",tap[1],"\n");
	else 
		Print("with output from stages S_",tap,"\n");
	fi;
	
end );













#new := Value(MultivarPoly, strlist, statelist);
# looks like GAP will compute the result in a larger field 
#(that constains the default fields of all the values that enter computation as subfield)
#must manually check if : new in F


#	if not(\in(new,F)) then
#		Error( "computed feedback is not an element of the underlying field !!!" );		return fail;
#	fi;



Print("nlfsr.gi OK,\t");