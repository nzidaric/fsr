#############################################################################
##
#W  fsr.gi                   GAP Package                   nusa zidaric
##
##



#############################################################################
##
#F  FSRFamily( <p> )
##  copied from FFEFamily :)
##
InstallGlobalFunction( FSRFamily, function( p )
    local fam;
    if MAXSIZE_GF_INTERNAL < p then
       fam:= NewFamily( "FSRFamily", IsFSR );
       SetCharacteristic( fam, p );
    else
      # small characteristic
      fam:= FamilyType( TYPE_FFE( p ) );
    fi;
 #   fam!.FSRType:= NewType( fam, IsFSR );
    return fam;
end );



#############################################################################
##
#M  GeneratorOfUnderlyingField( <fsr> )    . . . .. get generator of zechs log
##

InstallMethod(  GeneratorOfUnderlyingField, "generator of underlying field",  
	[IsFSR], function(x)
	return GeneratorOfField(UnderlyingField(x));
end);


#############################################################################
##
#M  FFEextCoefficients( <fsr> )    . . . coefs from ext field and their indices 
##


InstallMethod( FFExtCoefficients, "Coefficients from extension field",
  [IsFSR], function(x)

local fb, t, tlist, len, i, K, idxlist, n;
K := PrimeField(UnderlyingField(x));
fb := FeedbackVec(x);
len := Length(fb);
tlist := [];
idxlist := [];
n := Length(x);

for i in [1.. len] do
	if not (fb[i] = Zero(K) or fb[i] = One(K)) then
		Add(tlist,fb[i]);
		Add(idxlist, n-i);
	fi;
od;

return [tlist, idxlist];
end);





#############################################################################
##
#A  InternalStateSize( <fsr> )
##  still works after the move :)
InstallMethod(InternalStateSize, "size of FSR's internal state", [IsFSR], 	
	function(x)
local n, poly, s;
	n := Length(x);
	poly := FieldPoly(x);

	if poly=1 then
		s := n;
	else 	s := Degree(poly)*n;
	fi;
	SetInternalStateSize(x,s);
	return s;
end);


#############################################################################
##
#A  Threshold( <fsr> )
#(if LFSR and primitive thats one period plus one length of FSR + l)
#(if NLFSR and primitive thats one max possible period plus one length of FSR )

InstallMethod(Threshold, "threshold for the length of seq", [IsFSR], function(x)
local l,t,s;
	l := Length(x);
	t := InternalStateSize(x);

	s := Characteristic(x)^t + l;

	SetThreshold(x,s);
	return s;
end);



#############################################################################
##
#O  ChangeBasis( <fsr>, <B> )
##
##  identical for both lfsr and nlfsr
##
InstallMethod(ChangeBasis, "change the basis of underlying field of the FSR",
[IsFSR,  IsBasis], function(x, B)
local divs, deg;
	deg := DegreeOverPrimeField(UnderlyingField(x));
	divs := DivisorsInt(deg);
	if not  deg > Length(B) then

		if \in(Length(B),divs) then
			x!.basis := B;
		fi;

	else
		Error( "basis does not match the field!\n" );		return fail;
	fi;
	return true;
end);


#############################################################################
##
#O  WhichBasis( <fsr> )
##
##  identical for both lfsr and nlfsr
##
InstallMethod(WhichBasis, "which basis is currently set ?", [IsFSR], function(x)
	return x!.basis;
end);


#############################################################################
##
#O  LoadFSR( <lfsr>, <ist> )						fixed for IsFILFUN
##
##  almost identical for both
##
InstallMethod(LoadFSR, "load FSR with initial state ist",
 [IsFSR,  IsFFE], function(x, ist)
local i, F, tap, seq, tist, scist;
	tist := [ist];
	if Length(tist) <> Length(x) then
		Error( "initial state length doesnt match" );		return fail;
	fi;
	F := UnderlyingField(x);
	for i in [1..Length(tist)] do
		if not (\in(tist[i], F)) then
	Error("element at index=",i,"is not an element of the underlying field !!!");
					return fail;
		fi;
	od;

# update fields
	# NOT reversed !!!!
	scist := ShallowCopy((tist)); 	# without this the original ist outside here was changing too :(
	x!.init := Immutable(scist);
	x!.state := scist;

	#### LFSR, NLFSR vs FILFUN
	if not IsFILFUN(x) then 
		x!.numsteps := 0; ## load doesnt update numsteps for FILFUN
			# sequence starts with seq_0, seq_1, ...
		tap := OutputTap(x);
		if Length(tap)=1 then
			seq := ist[Length(x)-tap[1]];
		else  # this is rare !!! so dont make seq a list if not necessary
			seq := [];
			for i in [1.. Length(tap)] do
		 		seq[i] :=  ist[Length(x)-tap[i]]; # to get the corresponding index
		 	od;
		fi;
	else
		seq := Zero(F);
	fi;
	return seq;	
end);



#############################################################################
##
#O  LoadFSR( <lfsr>, <ist> )						fixed for IsFILFUN
##
##  almost identical for both
##
InstallMethod(LoadFSR, "load FSR with initial state ist",
 [IsFSR,  IsFFECollection], function(x, ist)
local i, F, tap, seq, scist;
	if Length(ist) <> Length(x) then
		Error( "initial state length doesnt match" );		return fail;
	fi;
	F := UnderlyingField(x);
	for i in [1..Length(ist)] do
		if not (\in(ist[i], F)) then
	Error("element at index=",i,"is not an element of the underlying field !!!");
					return fail;
		fi;
	od;

# update fields
	# NOT reversed !!!!
	scist := ShallowCopy((ist)); 	# without this the original ist outside here was changing too :(
	x!.init := Immutable(scist);
	x!.state := scist;

	#### LFSR, NLFSR vs FILFUN
	if not IsFILFUN(x) then 
		x!.numsteps := 0; ## load doesnt update numsteps for FILFUN
			# sequence starts with seq_0, seq_1, ...
		tap := OutputTap(x);
		if Length(tap)=1 then
			seq := ist[Length(x)-tap[1]];
		else  # this is rare !!! so dont make seq a list if not necessary
			seq := [];
			for i in [1.. Length(tap)] do
		 		seq[i] :=  ist[Length(x)-tap[i]]; # to get the corresponding index
		 	od;
		fi;
	else
		seq := Zero(F);
	fi;
	return seq;	
end);

# StepFSR is done for two cases, IsLFSR and IsNLFSR
# since this is the only one of Load, Step Run functions with the distinction
# its kept here instead of having separate calls for IsLFSR and IsNLFRS
# another reason: its used a lot and having if-else is faster than
# having a StepFSR(FSR) which would then call StepFSR(LFSR) or StepFSR(NLFSR)
# also: smaller code in terms of lines of code

InstallMethod(FeedbackFSR, "compute feedback", [IsFSR], function(x )
local fb, st, new, F, i, indlist, xlist, slist, idx;
	if x!.numsteps < 0 then
		Error( "the is NOT loaded !!!\n" );
		return fail;
	fi;

	F := UnderlyingField(x);
	fb := FeedbackVec(x);
	st := x!.state;

	# feedback computation
	if IsLFSR(x) then
		new := fb * st;
	else  
		xlist :=[]; slist :=[];
		indlist := IndetList(x);
		for i in [1.. Length(indlist)] do
			idx := indlist[i];
			Add(xlist,Indeterminate(F,800+idx));
		od;
		if IsNLFSR(x) then 
			for i in [1.. Length(indlist)] do
				idx := indlist[i];
				Add(slist,st[Length(x)-idx]); ## because states are DOWNTO !!!
			od;	
		elif IsFILFUN(x) then 
			slist := st;
		fi;		
			
		new := Value(MultivarPoly(x), xlist, slist);

	fi;

	if not(\in(new,F)) then
		Error( "computed feedback is not an element of the underlying field !!!");		
		return fail;
	else 
		return new;
	fi;
end);



#############################################################################
##
#O  StepFSR			fixed for IsFILFUN for both regular and nonlin step
##


InstallMethod(StepFSR, "one step of FSR", [IsFSR], function(x )
local fb, st, new, tap, i, seq, n;

	new := FeedbackFSR(x);	# regular step
	x!.numsteps := x!.numsteps + 1; #update for all three of em 

	#### LFSR, NLFSR vs FILFUN
	if not IsFILFUN(x) then 
		# update state
			n := Length(x);
			st := x!.state;	
			RightShiftRowVector(st,1,new);	
			Remove(st, n+1);
			x!.state := st;
						# if we didnt use the downto notation then:
						#	LeftShiftRowVector(st,1);	st[n] := new;	
		# sequence starts with seq_0, seq_1, ...
			tap := OutputTap(x);
			if Length(tap)=1 then
				seq := st[n-tap[1]];
			else  # this is rare !!! so dont make seq a list if not necessary
				seq := [];
				for i in [1.. Length(tap)] do
			 		seq[i] :=  st[n-tap[i]]; # to get the corresponding index
			 	od;
			fi;
		return seq;
	else 
		return new; #IsFILFUN
	fi;
	
end);





InstallMethod(StepFSR, "one step of FSR with an external input", [IsFSR, IsFFE],
 function(x, elm)
local fb, st, new, tap,i, seq, F, n, idx, indlist, slist, xlist;
	
	new := FeedbackFSR(x) + elm; # nonlinear step
	x!.numsteps := x!.numsteps + 1;

	if not IsFILFUN(x) then 
		# update state
		n := Length(x);
		st := x!.state;	
		RightShiftRowVector(st,1,new);	# NOT reversed !!!!  
		Remove(st, n+1);
		x!.state := st;		
	# sequence starts with seq_0, seq_1, ...
		tap := OutputTap(x);
		n := Length(x);
		if Length(tap)=1 then
			seq := st[n-tap[1]];
		else  # this is rare !!! so dont make seq a list if not necessary
			seq := [];
			for i in [1.. Length(tap)] do
		 		seq[i] :=  st[n-tap[i]]; # to get the corresponding index
		 	od;
		fi;
		return seq;
	else 
		return new;		#IsFILFUN 
	fi;	
	
end);




#############################################################################
##     LoadStepFSR one step at a time !!!!

InstallMethod(LoadStepFSR, "run FILFUN = load + 1step", 
[IsFILFUN, IsFFECollection, IsBool],
 function(x, ist,  pr)
local  i,  seq,  B ;

# load FSR
	LoadFSR(x,ist); # the seq_0 element
# start run
	seq := StepFSR(x);
# print 
	if pr then
		B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");
		Print("\t\t", (IntVecFFExt(B,x!.state)), "\t -> \t");  # NOT reversed !!!!
		Print("\t\t", IntFFExt(B,seq) , "\n");
	fi;	

	return seq;
end);

InstallMethod(LoadStepFSR, " nonlinear run FILFUN = load + 1step", 
[IsFILFUN, IsFFECollection, IsFFE, IsBool],
 function(x,  ist, elm, pr)
local  i,  seq,  B;

# load FSR
	LoadFSR(x,ist); # the seq_0 element
# start run
	seq := StepFSR(x, elm);
# print 
	if pr then
		B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");
		Print("\t\t", (IntVecFFExt(B,x!.state)), "\t -> \t"); # NOT reversed !!!!
		Print("\t\t", IntFFExt(B,seq) , "\n");
	fi;	

	return seq;
end);


InstallMethod(LoadStepFSR, "run FILFUN = load + 1step", 
[IsFILFUN, IsFFECollection],
 function(x, ist);
	return LoadStepFSR(x, ist, false);
end);
 
InstallMethod(LoadStepFSR, "run FILFUN = load + 1step", 
[IsFILFUN, IsFFECollection, IsFFE],
 function(x, ist, elm);
	return LoadStepFSR(x, ist, elm, false);
end);


InstallMethod(LoadStepFSR, "run FILFUN = load + 1step", 
[IsFILFUN, IsFFE, IsBool],
 function(x, ist,  pr)
return LoadStepFSR(x, [ist], pr);
end);



InstallMethod(LoadStepFSR, "run FILFUN = load + 1step", 
[IsFILFUN, IsFFE],
 function(x, ist)
return LoadStepFSR(x, [ist], false);
end);


InstallMethod(LoadStepFSR, " nonlinear run FILFUN = load + 1step", 
[IsFILFUN, IsFFE, IsFFE, IsBool],
 function(x,  ist, elm, pr)

return LoadStepFSR(x, [ist], elm, pr);
end);

InstallMethod(LoadStepFSR, " nonlinear run FILFUN = load + 1step", 
[IsFILFUN, IsFFE, IsFFE],
 function(x,  ist, elm)

return LoadStepFSR(x, [ist], elm, false);
end);






#############################################################################

# Ib. run for num steps with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsPosInt, IsBool], function(x, num, pr)
local seq, sequence, nrsteps, treshold, i, B;
	if IsFILFUN(x) then 
		Error("Must provide input values for the indeterminates!!!\n");
		return;
	fi;


# check num
	treshold := Threshold(x);
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold);
		Print(" elements of the sequence\n");
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;

#start run
	sequence := [];
		B := x!.basis;

	for i in [1.. nrsteps] do
		seq := StepFSR(x);
		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...

#print on every step
		if pr  then
			Print("\t\t", IntVecFFExt(B, x!.state));  		# NOT reversed !!!!
			if   Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B,seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(B, seq) , "\n");
			fi;
		fi;
	od;

	return sequence;
end);



# II. run for num steps without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsPosInt], function(x, num)
	return  RunFSR(x,  num, false);
end);


# IIIb. run with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR,   IsBool], function(x, pr)
	return RunFSR(x, 	 Threshold(x) , pr);
  ## change num to something huge then the called method will set the threshold
end);





# IV. run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR], function(x)
	return RunFSR(x, 	Threshold(x) , false);
  ## change num to something huge then the called method will set the threshold
end);


 
# PRIMARY METHOD FOR ALL PRACTICAL PURPOSES: 
# because otherwise u need to handle the seq_0 elm urself
# load with <ist> then call   RunFSR( FSR, num-1 , pr)
# Vb. load new initial state then run for num-1 steps with/without print to shell


InstallMethod(PrintHeaderRunFSR, "print header for run FSR", [IsFSR, IsFFE, IsPosInt],
 function(x, seq, m)
local  i, taps, B, nrsteps;
		B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");
		Print("elm");

	if not IsFILFUN(x) then
		for i in [1..m] do Print("\t"); od;
		Print( "[ ",Length(x)-1,",");
		for i in [2.. Length(x)-1] do
			Print("\t...");
		od;
		Print(",0 ]");
		Print( "  with taps  ",OutputTap(x),"\n");

		Print("\t\t", (IntVecFFExt(B,x!.state)));  				# NOT reversed !!!!
		if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B,seq) , "\n");
		else  Print("\t\t",  IntVecFFExt(B,seq) , "\n");
		fi;
	else 
		for i in [1..m] do Print("\t"); od;
		Print("input");
		for i in [2.. Length(x)-1] do
			Print("\t...");
		od;	
		Print("\t\t");
		Print( " with output   \n");			
	
	fi;
	
return;
end);

InstallMethod(PrintHeaderRunFSR, "print header for run FSR", [IsFSR, IsFFE, IsFFE, IsPosInt],
 function(x, elm, seq, m)
local  i, taps, B, nrsteps;
		B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");
		Print("elm");

	if not IsFILFUN(x) then
		for i in [1..m] do Print("\t"); od;
		Print( "[ ",Length(x)-1,",");
		for i in [2.. Length(x)-1] do
			Print("\t...");
		od;
		Print(",0 ]");
		Print( "  with taps  ",OutputTap(x),"\n");
		Print(IntFFExt(B,elm));
		Print("\t\t", (IntVecFFExt(B,x!.state)));  				# NOT reversed !!!!
		if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B,seq) , "\n");
		else  Print("\t\t",  IntVecFFExt(B,seq) , "\n");
		fi;
	else 
		for i in [1..m] do Print("\t"); od;
		Print("input");
		for i in [2.. Length(x)-1] do
			Print("\t...");
		od;	
		Print("\t\t");
		Print( " with output   \n");			
	
	fi;
	
return;
end);


InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsPosInt, IsBool],
 function(x,ist, num, pr)
local  i, sequence,treshold , seq, taps, B, nrsteps, m;
	sequence :=[];
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;
	
	if not IsFILFUN(x) then 
# check num
		treshold := Threshold(x);
		if num > treshold then
			Print("over the threshold, will only output the first ",treshold," elements of the sequence\n");
			nrsteps := treshold;
		else 	nrsteps := num;
		fi;

# load FSR

		seq := LoadFSR(x,ist); # the seq_0 element

# start run

	# print header, init state and seq_0
		if pr then
			PrintHeaderRunFSR(x, seq, m);
		fi;
		sequence := RunFSR(x, nrsteps, pr);
		Add(sequence,seq,1);	# seq_0 at the beginning
	else # FILFUN 
		if pr then
			PrintHeaderRunFSR(x, One(UnderlyingField(x)), m);
		fi;

		for i in [1.. Length(ist)] do 
			seq := LoadStepFSR(x, ist[i]);
			Add(sequence, seq);
		od;
	fi;

	return sequence;
end);


InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollColl, IsPosInt, IsBool],
 function(x,ist, num, pr)
local  i, sequence,treshold , seq, taps, B, nrsteps, m;
	sequence :=[];
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;
	
	if not IsFILFUN(x) then 
# check num
		treshold := Threshold(x);
		if num > treshold then
			Print("over the threshold, will only output the first ",treshold," elements of the sequence\n");
			nrsteps := treshold;
		else 	nrsteps := num;
		fi;

# load FSR

		seq := LoadFSR(x,ist); # the seq_0 element

# start run

	# print header, init state and seq_0
		if pr then
			PrintHeaderRunFSR(x, seq, m);
		fi;
		sequence := RunFSR(x, nrsteps, pr);
		Add(sequence,seq,1);	# seq_0 at the beginning
	else # FILFUN 
		if pr then
			PrintHeaderRunFSR(x, One(UnderlyingField(x)), m);
		fi;

		for i in [1.. Length(ist)] do 
			seq := LoadStepFSR(x, ist[i]);
			Add(sequence, seq);
		od;
	fi;

	return sequence;
end);

# VI. load new initial state then run for num-1 steps without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR,IsFFECollection, IsPosInt],
function(x, ist, num)
	return RunFSR(x, ist, num, false);
end);

InstallMethod(RunFSR, "run FSR", [IsFSR,IsFFECollColl, IsPosInt],
function(x, ist, num)
	return RunFSR(x, ist, num, false);
end);


# VIIb. load new initial state then run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsBool],
function(x, ist , pr)
	if IsFILFUN(x) then 
		RunFSR(x, ist, 1  , pr);
	else 
		return RunFSR(x, ist, Threshold(x)   , pr);
	fi;
end);
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollColl, IsBool],
function(x, ist , pr)
	if IsFILFUN(x) then 
		RunFSR(x, ist, 1  , pr);
	else 
		return RunFSR(x, ist, Threshold(x)   , pr);
	fi;
end);

# VII. load new initial state then run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection], function(x, ist )
	if IsFILFUN(x) then 
		return RunFSR(x, ist, 1   , false);
	else 
		return RunFSR(x, ist, Threshold(x)   , false);
	fi;
end);
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollColl], function(x, ist )
	if IsFILFUN(x) then 
		return RunFSR(x, ist, 1   , false);
	else 
		return RunFSR(x, ist, Threshold(x)   , false);
	fi;
end);


# NONLINEAR STEP
# rationale behind copied code is speed: could be a very long sequence, dont want to many functions calling eachother

# VIIIb. run for num steps with the same nonlinear input on each step and with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsPosInt, IsBool],
 function(x, elm, num, pr)
local seq, sequence, nrsteps, treshold, i, B;
	if IsFILFUN(x) then 
		Error("Can only do one step at a time!!!\n");
		return;
	fi;
# check num
		treshold := Threshold(x);
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold," elements of the sequence\n");
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;
#start run
	sequence := [];

	if pr then
			B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");
	fi;
	for i in [1.. nrsteps] do
		seq := StepFSR(x,elm);
		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step
		if pr then
			Print("\t\t", IntVecFFExt(B, x!.state));  				# NOT reversed !!!!
			if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B, seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(B, seq) , "\n");
			fi;
		fi;
	od;

	return sequence;
end);



# IX. run for num steps with the same nonlinear input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsPosInt], function(x, elm, num)
	return RunFSR(x, elm, num, false);
end);


# Xb. run for num steps with the same nonlinear input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsBool], function(x, elm, pr)
	return RunFSR(x,  elm,   Threshold(x) , pr); ## change num to something huge then the called method will set the threshold
end);


# X. run for num steps with the same nonlinear input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE], function(x, elm)
	return RunFSR(x,  elm,  Threshold(x) , false); ## change num to something huge then the called method will set the threshold
end);




# XIb. run for num steps with the different nonlinear input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR",
[IsFSR,  IsFFECollection, IsFFECollection, IsBool],
function(x,  ist, elmvec, pr)
local  sequence,  treshold, num, nrsteps, seq , seq0, i, B, m;
	if IsFILFUN(x) then
		if Length(ist) <> Length(elmvec) then  
			Error("use two lists of same lengrth !!!\n");
			return;
		fi;
	fi;
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;	
			B := x!.basis;
 if not IsFILFUN(x) then 
# load FSR
	seq0 := LoadFSR(x,ist); # the seq_0 element
	treshold := Threshold(x);
	num := Length(elmvec);
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold," elements of the sequence\n");
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;
	
# print header, init state and seq_0

#start run
		# print header, init state and seq_0
			if pr then
				PrintHeaderRunFSR(x,Zero(UnderlyingField(x)), seq0, m);
			fi;
sequence := [];
	for i in [1.. nrsteps] do
			seq := StepFSR(x,elmvec[i]);
			Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step
			if pr then
				Print(IntFFExt(B,elmvec[i]),"\t\t");  				# NOT reversed !!!!
				Print(IntVecFFExt(B,x!.state));  				# NOT reversed !!!!
				if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B, seq) , "\n");
				else  	Print("\t\t",  IntVecFFExt(B, seq) , "\n");
				fi;
			fi;
		od;
		Add(sequence,seq0,1);	# seq_0 at the beginning
	else # FILFUN 
			if pr then
				PrintHeaderRunFSR(x, One(UnderlyingField(x)), m);
			fi;
			sequence :=[];
			for i in [1.. Length(ist)] do 
				seq := LoadStepFSR(x, ist[i]);
				Add(sequence, seq);
			od;
	fi;


	return sequence;
end);


# XI. run for num steps with the different nonlinear input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsFFECollection],
 function(x, ist, elmvec)
	return RunFSR(x, ist, elmvec, false);

end);

# XIIb. run for num steps with the different nonlinear input on each step with/without print to shell,
# without loading first
InstallMethod(RunFSR, "run FSR", [IsFSR, IsZero, IsFFECollection, IsBool],
 function(x, z, elmvec, pr)
local  sequence,  treshold, num, nrsteps, seq , i, B, m ;
	if IsFILFUN(x) then 
		Error("use RunFSR with two sequences!!!\n");
		return;
	fi;


		if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
		else m:= 1;
		fi;

# print header, init state and seq_0
	if pr then

			B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");

		Print("elm");
		for i in [1..m] do Print("\t"); od;
		Print( "[ ",Length(x)-1,",");
		for i in [2.. Length(x)-1] do
			Print("\t...");
		od;
		Print(",0 ]");
		Print( "  with taps  ",OutputTap(x),"\n");
		Print(IntFFExt(B,Zero(UnderlyingField(x))),"\t\t");
		Print((IntVecFFExt(B,x!.state)),"\n");  				# NOT reversed !!!!
#		if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B,seq) , "\n");
#		else  Print("\t\t",  IntVecFFExt(B,seq) , "\n");
#		fi;
# note: there will be an element missing coz we start output with CURRENT state, without step ...
#the seq elm that came from step is already in the sequence, we dont want to repeat it
	fi;

	treshold := Threshold(x);
	num := Length(elmvec);
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold," elements of the sequence\n");
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;
#start run
	sequence := [];
	for i in [1.. nrsteps] do
		seq := StepFSR(x,elmvec[i]);
		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step
		if pr then
			Print(IntFFExt(B,elmvec[i]),"\t\t");  				# NOT reversed !!!!
			Print(IntVecFFExt(B,x!.state));  				# NOT reversed !!!!
			if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B, seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(B, seq) , "\n");
			fi;
		fi;
	od;



	Add(sequence,seq,1);	# seq_0 at the beginning
	return sequence;
end);


# XII. run for num steps with the different nonlinear input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsZero, IsFFECollection], function(x, z, elmvec)
	return RunFSR(x, z, elmvec, false);

end);

Print("fsr.gi OK,\t");
