#############################################################################
##
#W  lfsr.gi                   GAP Package                   nusa zidaric
##
##

##codecov note: LFSR(p, m n)  and LFSR(p, m , n , tap) use RANDOM primitive poly 


#############################################################################
##
#F  LFSR( <F> )  . . . . . . . . . .  create an LFSR object 	# len 1 B
#F  LFSR( <F>, <feedbackpol> )  . . . . . . . . . .  create an LFSR object 	# len 2 B
#F  LFSR( <F>, <feedbackpol>, <B> )  . . . . . . . . . .  create an LFSR object 	# len 3 B
#F  LFSR( <K>, <fieldpol>, <feedbackpol>)					# len 3 B
#F  LFSR( <K>, <fieldpol>, <feedbackpol>, <B>)					# len 4 B
#F  LFSR( <F>, <feedbackpol>, <tap>)				# len 3 B
#F  LFSR( <F>, <feedbackpol>, <B>,  <tap>)	# len 4 B
#F  LFSR( <F>, <feedbackpol>,)						# len 2 B
#F  LFSR( <p>, <m>, <n>  )						# len 3 B
#F  LFSR( <K>, <fieldpol>, <feedbackpol>, <tap>)				# len 4 B
#F  LFSR( <K>, <fieldpol>, <feedbackpol>, <B>, <tap>)				# len 5 B
#F  LFSR( <p>, <m>, <n>, <tap>  )					# len 4

InstallGlobalFunction( LFSR,  function(arg)

local K, F, feedbackpol, fieldpol, p, m, n, tap,y,	# for args
    fam, fb, st, coefs, lfsr, d, i,  B, lin;		# for constructor

# figure out which constructor is being used
# 2 input constructors 

if Length(arg)=2 and IsUnivariatePolynomial( arg[2]) then  
 	if  IsPrimeField(arg[1])  then				
 		#F  LFSR( <K>, <feedbackpol> )				#correct functionality :) 
		K := arg[1]; F := arg[1]; fieldpol := 1; feedbackpol := arg[2];
	elif IsField(arg[1]) then  		
		#F  LFSR( <F>, <feedbackpol>) 
		F := arg[1]; K := PrimeField(F); fieldpol := DefiningPolynomial(F); 
	else Error("check the args!!!"); # we dont allow anything thats not a field here
	fi;
	feedbackpol := arg[2]; tap := [0]; B := CanonicalBasis(F); 	
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
			feedbackpol := RandomPrimitivePolynomial(F,arg[3]);  tap := [0]; B := CanonicalBasis(F);

	elif  IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  then 
			#F  LFSR( <K>, <fieldpol>, <feedbackpol>)
			#error if fieldpol not irreducible !!!!! 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");		return fail;
			fi;
			F := FieldExtension(K,fieldpol); 
			feedbackpol := arg[3]; tap := [0]; B := CanonicalBasis(F);

	
	
	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2]) and IsBasis(arg[3])  then 		#new

			# LFSR( <K>, <feedbackpol>, <B> )
			K := arg[1]; F := arg[1]; fieldpol := 1; feedbackpol := arg[2];	
			tap := [0];
			if DegreeOverPrimeField(F) = Length(arg[3]) then 
				B := arg[3];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;
	
	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  then 		#new

			#F  LFSR( <K>, <feedbackpol>, <tap>)
			K := arg[1]; F := arg[1]; fieldpol := 1; feedbackpol := arg[2];	
		   B := CanonicalBasis(F);
			if 	IsPosInt(arg[3]) or IsZero(arg[3]) then 	tap := [arg[3]];
			elif  	IsRowVector(arg[3]) then 			tap := arg[3];
			else 	Error("check the tap=",arg[3],"  !!!"); 	return fail;
			fi;	
	elif IsField(arg[1]) and IsUnivariatePolynomial( arg[2]) and IsBasis(arg[3])  then 		#new

			# LFSR( <F>, <feedbackpol>, <B> )
		F := arg[1]; K := PrimeField(F); fieldpol := DefiningPolynomial(F); feedbackpol := arg[2];	
			tap := [0];
			if DegreeOverPrimeField(F) = Length(arg[3]) then 
				B := arg[3];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;
	elif IsField(arg[1]) and IsUnivariatePolynomial( arg[2])  then 		

			#F  LFSR( <F>, <feedbackpol>, <tap>)
			F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F); feedbackpol := arg[2];	
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
			feedbackpol := RandomPrimitivePolynomial(F,arg[3]); 
			B := CanonicalBasis(F);
			
			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then 	tap := [arg[4]];
			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
	elif  IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  and IsBasis(arg[4])  then 
			#F  LFSR( <K>, <fieldpol>, <feedbackpol>, <B>)
			#error if fieldpol not irreducible !!!!! 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");		return fail;
			fi;
			F := FieldExtension(K,fieldpol); 
			feedbackpol := arg[3]; tap := [0]; 
			
			if DegreeOverPrimeField(F) = Length(arg[4]) then 
				B := arg[4];
			else 
				Print("Basis does not match field F!!! using canonical basis instead\n");
				 B := CanonicalBasis(F);
			fi;



	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2])  and IsUnivariatePolynomial( arg[3])  then  
			#F  LFSR( <K>, <fieldpol>, <feedbackpol>, <tap>)
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");
						return fail;
			fi;
			F := FieldExtension(K,fieldpol); B := CanonicalBasis(F);
			feedbackpol := arg[3];
			
			if 	IsPosInt(arg[4]) or IsZero(arg[4]) then		tap := [arg[4]];
			elif  	IsRowVector(arg[4]) then 			tap := arg[4];
			else 	Error("check the tap arg !!!"); 		return fail;
			fi;
			
		
	elif IsPrimeField(arg[1]) and IsUnivariatePolynomial( arg[2]) and IsBasis(arg[3])  then 		#new

			#F  LFSR( <K>, <feedbackpol>, <B>,  <tap>)
			K := arg[1]; F := arg[1]; fieldpol := 1; feedbackpol := arg[2];	

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

			#F  LFSR( <F>, <feedbackpol>, <B>,  <tap>)
			F := arg[1]; K := PrimeField(F);  fieldpol := DefiningPolynomial(F); feedbackpol := arg[2];	
	
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
			#F  LFSR( <K>, <fieldpol>, <feedbackpol>, <B>, <tap>)
			#error if fieldpol not irreducible !!!!! 
			K := arg[1]; fieldpol := arg[2]; 
			if not IsIrreducibleRingElement(PolynomialRing(K),  fieldpol) then 
				Error("defining polynomial of the extension field must be irreducible!!!");		return fail;
			fi;
			F := FieldExtension(K,fieldpol); 
			feedbackpol := arg[3]; tap := [0]; 
			
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
	lin := IsUnivariatePolynomial(feedbackpol);
	coefs := CoefficientsOfUnivariatePolynomial(feedbackpol);  
	coefs := TrimLeadCoeff(coefs);
	fb := Reversed(coefs);						# reversed !!!! 
	st := 0 * fb;
	 
	
# length  and tap
	d := Degree(feedbackpol);
	for i in [1.. Length(tap)] do 
		if (tap[i]<0 or tap[i]>=d) then 
			Print("argument tap[",i,"]=",tap[i]," is out of range 0..",d-1,", or not given => im taking S_0 instead!\n");
			tap[i] := 0;
		fi;
	od;	
# new LFSR :) 
	fam :=FSRFamily(Characteristic(K));
	lfsr := Objectify(NewType(fam, IsFSRRep),   rec(init:=st, state:= st, numsteps := -1, basis := B));



	SetFieldPoly(lfsr,fieldpol);
	SetUnderlyingField(lfsr,F);
	SetFeedbackPoly(lfsr,feedbackpol);  
	SetIsLinearFeedback(lfsr, lin);  
	SetIsNonLinearFeedback(lfsr, not lin);  
	SetIsFSRFilter(lfsr, false);  
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
	# must check if FeedbackPoly must be irr or primitive, but i think not
	ct := FeedbackVec(x)[Length(x)]; # constant term of FeedbackPoly
	flag := ( ct <> Zero(GF(Characteristic(x))) ); 	#CITE is periodic (8.11 lidl, niederreiter)			

	SetIsPeriodic(x, flag);
	return flag;
end);


#############################################################################
##
#A  Period( <lfsr> )
##
#InstallMethod(PeriodIrreducible, "period of the LFSR", [IsField, IsUnivariatePolynomial, IsPosInt], function(F, l, m)
#local   period, candidates, c, i , poly,  y; 

## MUST CHECK !!!
#	if IsIrreducibleRingElement(PolynomialRing(F),  l) then 
#		y := X(F, "y");
#		# candidates are in ascending order 
#		# check if u really need the smallest one 
#		candidates := DivisorsInt(m);
#		for i in [1.. Length(candidates)] do 
#			c := candidates[i];
#			poly := y^c + 1;
#			
#			if Gcd(l, poly ) = l then 
#				period := c; return period;
#			fi;
#		od;
#	else 	Error("l not irreducible, why are u here ?!?"); 
#		return fail;
#	fi;
#end);

InstallMethod(PeriodPrimitive, "period of the LFSR", [IsField, IsUnivariatePolynomial], function(F, l)
	if IsPrimitivePolynomial(F,l) then 
		return Size(F)^Degree(l) -1; 
	else 	Error("l not primitive, why are u here ?!?"); 
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

##### thm 2.1.55 --> returns order of poly l 
#	flist :=  Collected(Factors( PolynomialRing(SplittingField(l)), l));
		flist :=  Collected(Factors( PolynomialRing(F), l));

	plist := []; blist := [];
		for i in [1.. Length(flist)] do 
			f := flist[i][1];
			o := Order( RootsOfPolynomial( SplittingField(f), f)[1]);
			if o > 0 then 			# this will ignore factors x^something
				plist[i] := o;
				blist[i] := flist[i][2];
			fi;		
		od; 	
#Print(flist,"\n");
#Print(plist,"\n");
#Print(blist,"\n");

plist := Compacted(plist);
blist := Compacted(blist);

		e := Lcm(plist);
		b := Maximum(blist);
		t := LogInt(b, Characteristic(F)); # is plus 1 really there ????
		if  Characteristic(F)^t < b then 
			t := t+1;
		fi;
	
#Print(e, " ", Characteristic(F), " ",t,"\n");		
	return e*Characteristic(F)^t;
 #### are u sure thats still correct once over extension field ???


end);




InstallMethod(Period, "period of the LFSR", [IsLFSR], function(x)
local  l, period,  F; 

	l := FeedbackPoly(x);
	F := UnderlyingField(x);


	if IsPrimitivePolynomial(F,l) then 
		period := PeriodPrimitive(F, l);
		SetIsMaxSeqLFSR(x,true);
	elif IsIrreducibleRingElement(PolynomialRing(F),  l) then 
		period := PeriodIrreducible(F, l);
		Print("warning: the polynomial is irreducible !!!\n");
				SetIsMaxSeqLFSR(x,false);
	else 
		period := PeriodReducible(F, l);
		Print("warning: the polynomial is reducible !!!\n");
				SetIsMaxSeqLFSR(x,false);
	fi;
 
	SetPeriod(x,period);
	return period;
end);


InstallMethod(IsMaxSeqLFSR, "is m-sequence for LFSR", [IsLFSR], function(x)
local  tmp; 
	tmp := IsPrimitivePolynomial( UnderlyingField(x), FeedbackPoly(x));
	SetIsMaxSeqLFSR(x,tmp);
	return tmp;
end);







Print("lfsr.gi OK,\t");