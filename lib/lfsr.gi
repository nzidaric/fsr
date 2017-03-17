#############################################################################
##
#W  lfsr.gi                   GAP Package                   nusa zidaric
##
##



#############################################################################
##
#F  LFSR( <K>, <charpol> )  . . . . . . . . . .  create an LFSR object 	# len 2 B
#F  LFSR( <K>, <charpol>, <B> )  . . . . . . . . . .  create an LFSR object 	# len 3 B
#F  LFSR( <K>, <fieldpol>, <charpol>)					# len 3 B
#F  LFSR( <K>, <fieldpol>, <charpol>, <B>)					# len 4 B
#F  LFSR( <K>, <charpol>, <tap>)				# len 3 B
#F  LFSR( <K>, <charpol>, <tap> ) 					# len 3 B
#F  LFSR( <K>, <charpol>, <B>,  <tap>)	# len 4 B
#F  LFSR( <F>, <charpol>, <B>)						# len 3 B
#F  LFSR( <F>, <charpol>,)						# len 2 B
#F  LFSR( <p>, <m>, <n>  )						# len 3 B
#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)				# len 4 B
#F  LFSR( <K>, <fieldpol>, <charpol>, <B>, <tap>)				# len 5 B
#F  LFSR( <F>, <charpol>, <tap>)					# len 3 B
#F  LFSR( <F>, <charpol>, <B>, <tap>)					# len 4 B
#F  LFSR( <p>, <m>, <n>, <tap>  )					# len 4

InstallGlobalFunction( LFSR,  function(arg)

local K, F, charpol, fieldpol, p, m, n, tap,y,	# for args
    fam, fb, st, coefs, lfsr, d, i, basis, B;		# for constructor

# figure out which constructor is being used
# 2 input constructors 
if Length(arg)=2 and IsUnivariatePolynomial( arg[2]) then  
 	if  IsPrimeField(arg[1])  then				
 		#F  LFSR( <K>, <charpol> )				#correct functionality :) 
		K := arg[1]; F := arg[1]; fieldpol := 1; charpol := arg[2]; tap := [0]; B := CanonicalBasis(F);
	elif IsField(arg[1]) then  		
		#F  LFSR( <F>, <charpol>) 
		F := arg[1]; K := PrimeField(F); fieldpol := DefiningPolynomial(F); charpol := arg[2]; 
		tap := [0]; B := CanonicalBasis(F);
	else Error("check the args!!!"); # we dont allow anything thats not a field here
	fi;
# 3 input constructors 	
elif  Length(arg)=3 then 
# problem with no-method found error on IsPrimeInt(GF(2)) and on IsPrimeField(2)!!!
	if (IsInt(arg[1]) and IsPosInt(arg[2]) and IsPosInt(arg[3])) then 	
			#F  LFSR( <p>, <m>, <n>  ) 
			# we dont allow anything thats not a prime here, primepower is already an extension
			if IsPrimeInt(arg[1]) then K:= GF(arg[1]);  
			else Error("arg p must be a prime!!\n");	return fail;
			fi;
			F := GF(arg[1],arg[2]); fieldpol := DefiningPolynomial(F); y := X(F, "y");
			charpol := RandomPrimitivePolynomial(F,arg[3]);  tap := [0]; B := CanonicalBasis(F);

	elif  IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  then 
			#F  LFSR( <K>, <fieldpol>, <charpol>)
			#error if fieldpol not irreducible !!!!! 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");		return fail;
			fi;
			F := FieldExtension(K,fieldpol); 
			charpol := arg[3]; tap := [0]; B := CanonicalBasis(F);

	
	
	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2]) and IsBasis(arg[3])  then 		#new

			# LFSR( <K>, <charpol>, <B> )
			K := arg[1]; F := arg[1]; fieldpol := 1; charpol := arg[2];	
			tap := [0];
			if DegreeOverPrimeField(F) = Length(arg[3]) then 
				B := arg[3];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;
	
	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  then 		#new

			#F  LFSR( <K>, <charpol>, <tap>)
			K := arg[1]; F := arg[1]; fieldpol := 1; charpol := arg[2];	
		   B := CanonicalBasis(F);
			if 	IsPosInt(arg[3]) or IsZero(arg[3]) then 	tap := [arg[3]];
			elif  	IsRowVector(arg[3]) then 			tap := arg[3];
			else 	Error("check the tap=",arg[3],"  !!!"); 	return fail;
			fi;	

	elif IsField(arg[1]) and IsUnivariatePolynomial( arg[2])  then 		

			#F  LFSR( <F>, <charpol>, <tap>)
			F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F); charpol := arg[2];	
				 B := CanonicalBasis(F);
				 
			if 	IsPosInt(arg[3]) or IsZero(arg[3]) then 	tap := [arg[3]];
			elif  	IsRowVector(arg[3]) then 			tap := arg[3];
			else 	Error("check the tap=",arg[3],"  !!!"); 	return fail;
			fi;
		
	else Error("check the args!!!"); 		return fail;
	fi;
# 3 input constructors 	
elif  Length(arg)=4 then
	if IsInt(arg[1]) and IsPosInt(arg[2]) and IsPosInt(arg[3]) then 	
			#F  LFSR( <p>, <m>, <n>, <tap>  )
			# we dont allow anything thats not a prime here, coz primepower is already an extension
			if IsPrimeInt(arg[1]) then K:= GF(arg[1]); 
			else Error("arg p must be a prime!!\n"); 		return fail;
			fi;
			F := GF(arg[1],arg[2]);  fieldpol := DefiningPolynomial(F);  y := X(F, "y");
			charpol := RandomPrimitivePolynomial(F,arg[3]); 
			B := CanonicalBasis(F);
			
			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then 	tap := [arg[4]];
			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	elif  IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  and IsBasis(arg[4])  then 
			#F  LFSR( <K>, <fieldpol>, <charpol>, <B>)
			#error if fieldpol not irreducible !!!!! 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");		return fail;
			fi;
			F := FieldExtension(K,fieldpol); 
			charpol := arg[3]; tap := [0]; 
			
			if DegreeOverPrimeField(F) = Length(arg[4]) then 
				B := arg[4];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;



	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  then  
			#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol); B := CanonicalBasis(F);
			charpol := arg[3];
			
			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then		tap := [arg[4]];
			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
			
		
	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2]) and IsBasis(arg[3])  then 		#new

			#F  LFSR( <K>, <charpol>, <B>,  <tap>)
			K := arg[1]; F := arg[1]; fieldpol := 1; charpol := arg[2];	

			if DegreeOverPrimeField(F) = Length(arg[3]) then 
				B := arg[3];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;


			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then 	tap := [arg[4]];
			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap=",arg[4],"  !!!"); 	return fail;
			fi;
			
				
	elif IsField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsBasis(arg[3])  then 		

			#F  LFSR( <F>, <charpol>, <B>,  <tap>)
			F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F); charpol := arg[2];	
	
			if DegreeOverPrimeField(F) = Length(arg[3]) then 
				B := arg[3];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;	
	
		
			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then 	tap := [arg[4]];
			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap=",arg[4],"  !!!"); 	return fail;
			fi;
	else Error("check the args!!!"); 		return fail;
	fi;	
elif  Length(arg)=5 then		
	if  IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  and IsBasis(arg[4])  then 
			#F  LFSR( <K>, <fieldpol>, <charpol>, <B>, <tap>)
			#error if fieldpol not irreducible !!!!! 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");		return fail;
			fi;
			F := FieldExtension(K,fieldpol); 
			charpol := arg[3]; tap := [0]; 
			
			if DegreeOverPrimeField(F) = Length(arg[4]) then 
				B := arg[4];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;			
			
					
			if 	IsPosInt(arg[5]) or IsZero(arg[5]) then 	tap := [arg[5]];
			elif  	IsRowVector(arg[5]) then 			tap := arg[5];
			else 	Error("check the tap=",arg[5],"  !!!"); 	return fail;
			fi;
				
	else Error("check the args!!!"); 		return fail;
	fi;
# whatever input constructors - undefined
else Error("check the args!!!"); 		return fail;
fi;

#feedback and state
	coefs := CoefficientsOfUnivariatePolynomial(charpol);  
	coefs := TrimLeadCoeff(coefs);
	fb := Reversed(coefs);						# reversed !!!! 
	st := 0 * fb; 
	
# length  and tap
	d := Degree(charpol);
	for i in [1.. Length(tap)] do 
		if (tap[i]<0 or tap[i]>d) then 
			Print("argument tap[",i,"]=",tap[i]," is out of range 0..",d-1,", or not given => im taking S_0 instead!\n");
			tap[i] := 0;
		fi;
	od;	
# new LFSR :) 
	fam :=FSRFamily(Characteristic(K));
	lfsr := Objectify(NewType(fam, IsLFSRRep),   rec(init:=st, state:= st, numsteps := -1, basis := B));

	SetFieldPoly(lfsr,fieldpol);
	SetUnderlyingField(lfsr,F);
	SetCharPoly(lfsr,charpol);  
	SetIsLinearFeedback(lfsr,IsUnivariatePolynomial(charpol));  
	SetFeedbackVec(lfsr,fb);    
	SetLength(lfsr,d); 
	SetOutputTap(lfsr,tap); # this is S_tap or default S_0



return lfsr;
end);


#############################################################################
##
#P  IsPeriodic( <lfsr> )
##
InstallMethod(IsPeriodic, "periodic or not", [IsLFSR], function(x)
local ct, flag; 
	# must check if CharPoly must be irr or primitive, but i think not
	ct := FeedbackVec(x)[Length(x)]; # constant term of CharPoly
	flag := ( ct <> Zero(GF(Characteristic(x))) ); 	#CITE is periodic (8.11 lidl, niederreiter)			

	SetIsPeriodic(x, flag);
	return flag;
end);


#############################################################################
##
#A  Period( <lfsr> )
##
InstallMethod(PeriodIrreducible, "period of the LFSR", [IsField, IsUnivariatePolynomial, IsPosInt], function(F, l, m)
local   period, candidates, c, i , poly,  y; 

## MUST CHECK !!!
	if IsIrreducibleRingElement(PolynomialRing(F),  l) then 
		y := X(F, "y");
		# candidates are in ascending order 
		# check if u really need the smallest one 
		candidates := DivisorsInt(m);
		for i in [1.. Length(candidates)] do 
			c := candidates[i];
			poly := y^c + 1;
			
			if Gcd(l, poly ) = l then 
				period := c; return period;
			fi;
		od;
	else 	Error("l not irreducible, why are u here ?!?"); 
		return fail;
	fi;
end);

InstallMethod(PeriodIrreducible, "period of the LFSR", [IsField, IsUnivariatePolynomial], function(F, l)
	if IsIrreducibleRingElement(PolynomialRing(F),  l) then 
			# will always have deg(l) distinct roots in its splitting field
			# all of them will have same order  
		return Order( RootsOfPolynomial( SplittingField(l), l)[1]);
	else 	Error("l not irreducible, why are u here ?!?"); 
		return fail;
	fi;
end);

InstallMethod(PeriodReducible, "period of the LFSR", [IsField, IsUnivariatePolynomial], function(F, l)
local flist, i, plist, blist, e, t, b, f, o;  

##### thm 2.1.55
	flist :=  Collected(Factors( PolynomialRing(SplittingField(l)), l));

	plist := []; blist := [];
		for i in [1.. Length(flist)] do 
			f := flist[i][1];
			o := Order( RootsOfPolynomial( SplittingField(f), f));
			if o > 0 then 			# this will ignore factors x^something
				plist[i] := o;
				blist[i] := flist[i][2];
			fi;		
		od; 	


		e := Lcm(plist);
		b := Maximum(blist);
		t := LogInt(b, 2)+1; # is plus 1 really there ???? 
		
	return e*Characteristic(F)^t;
 #### are u sure thats still correct once over extension field ???


end);

InstallMethod(Period, "period of the LFSR", [IsLFSR], function(x)
local n, q, l, period,  F; 


 

	n := Length(x); 
	l := CharPoly(x);
	F := UnderlyingField(x);
	q := Characteristic(x)^DegreeOverPrimeField(F);

	if IsPrimitivePolynomial(F,l) then 
		period := q^n -1; 
		SetIsMaxSeqLFSR(x,true);
	elif IsIrreducibleRingElement(PolynomialRing(F),  l) then 
		period := PeriodIrreducible(F, l, q^n -1);
	else 
		period := PeriodReducible(F, l);
	
	fi;
 
	SetPeriod(x,period);
	return period;
end);


InstallMethod(IsMaxSeqLFSR, "is m-sequence for LFSR", [IsLFSR], function(x)
local  tmp; 
	tmp := IsPrimitivePolynomial( UnderlyingField(x), CharPoly(x));
	SetIsMaxSeqLFSR(x,tmp);
	return tmp;
end);





#############################################################################
##
#M  ViewObj( <lfsr> ) . . . . . . . . . . . . . . . 
##
InstallMethod( ViewObj,    "for LFSR",    true,    [ IsLFSR ],    0,  function( x )
	if x!.numsteps=-1 then 
		Print("< empty LFSR given by CharPoly = ", CharPoly(x), ">");
	else 	
	Print("< LFSR given by CharPoly = ", CharPoly(x), ">");
	fi;
end );

InstallMethod( Display,
    "for LFSR",	    true,    [ IsLFSR ],        0,    function( x )
    ViewObj(x);
end );

#############################################################################
##
#M  PrintObj( <lfsr> ) . . . . . . . . . . . . . . . . .
##
InstallOtherMethod( PrintObj,     "for LFSR",    true,    [ IsLFSR ],    0,  function( x )
local B; 
	if x!.numsteps=-1 then 
		Print("Empty LFSR given by CharPoly = ", CharPoly(x), "\n");
	else 	
		B := x!.basis;

		Print("LFSR given by CharPoly = ", CharPoly(x), "\n");
		Print("with basis =");
		Print(BasisVectors(B)); 
		Print("\nwith initial state =");
		Print(((x!.init))); # NOT reversed !!!! 
		Print("\nwith current state =");
		Print(((x!.state)));# NOT reversed !!!! 
		Print("\nafter  ",x!.numsteps," steps\n");
	fi;
end );


#############################################################################
##
#M  PrintObj( <lfsr> ) . . . . . . . . . . . . . . . . .
##
InstallMethod( PrintObj,     "for LFSR",    true,    [ IsLFSR, IsBool ],    0,  function(  x, b )
local B; 
	if x!.numsteps=-1 then 
		Print("Empty LFSR given by CharPoly = ", CharPoly(x), "\n");
	else 	
		if b  then 
			B := x!.basis;

			Print("LFSR given by CharPoly = ", CharPoly(x), "\n");
			Print("with basis =");
			Print(BasisVectors(B)); 
			Print("\nwith initial state =");
			Print((IntVecFFExt(B, x!.init))); # NOT reversed !!!! 
			Print("\nwith current state =");
			Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!! 
			Print("\nafter  ",x!.numsteps," steps\n");
	 	fi;
	fi;
end );

#############################################################################
##
#M  PrintAll( <lfsr> ) . . . . . . . . . . . . . . . . . . view a GF2 vector
##
InstallMethod( PrintAll,     "for LFSR",    true,    [ IsLFSR ],    0,  function( x )
local uf, tap, i, B;

	uf := UnderlyingField(x);
	
	if x!.numsteps=-1 then 
		Print("Empty LFSR over ",uf," given by CharPoly = ", CharPoly(x), "\n");
	else 	
		Print("LFSR over ",uf,"  given by CharPoly = ", CharPoly(x), "\n");
	fi;
	B := x!.basis;
	Print("with basis =");
	Print(BasisVectors(B),"\n"); 
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
#M  PrintAll( <lfsr>, <B> ) . . . . . . . . . . . . . . . . . . view a GF2 vector
##
InstallMethod( PrintAll,     "for LFSR",    true,    [ IsLFSR, IsBool ],    0,  function(  x, b )
local uf, tap, i, B;

	if FieldPoly(x) = 1 then 
		uf := Concatenation("GF(",String(Characteristic(x)),")");
	else 
		uf := Concatenation("GF(",String(Characteristic(x)),"^",String(Degree(FieldPoly(x))),") defined by FieldPoly=",String(FieldPoly(x)));
	fi;
	
	if x!.numsteps=-1 then 
		Print("Empty LFSR over ",uf," given by CharPoly = ", CharPoly(x), "\n");
	else 	
		Print("LFSR over ",uf,"  given by CharPoly = ", CharPoly(x), "\n");
	fi;
	if b  then 
			B := x!.basis;	
		Print("with basis =");
		Print(BasisVectors(B),"\n"); 
			
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
	fi;
	
	tap := OutputTap(x); 
	if Length(tap)=1 then 
		Print("with output from stage S_",tap[1],"\n");
	else 
		Print("with output from stages S_",tap,"\n");
	fi;
	
end );








Print("lfsr.gi OK,\t");