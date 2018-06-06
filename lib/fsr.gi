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


InstallMethod(LoadFSR, "load FSR with initial state ist",
 [IsFSR,  IsFFE], function(x, ist)
 return LoadFSR(x ,[ist]);
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
#O  StepFSR			fixed for IsFILFUN for both regular and external step
##


InstallMethod(StepFSR, "one regular step of FSR", [IsFSR], function(x )
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





InstallMethod(StepFSR, "one external step of FSR", [IsFSR, IsFFE],
 function(x, elm)
local fb, st, new, tap,i, seq, F, n, idx, indlist, slist, xlist;
	
	new := FeedbackFSR(x) + elm; #external step
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

InstallMethod(LoadStepFSR, "load + 1 regular step", 
[IsFSR, IsFFECollection],
 function(x, ist)
local  i,  seq, seqlist;

seqlist := [];
# load FSR
	seq := LoadFSR(x,ist); # the seq_0 element
	Add(seqlist, seq);
# start run
	seq := StepFSR(x);

	if IsFILFUN(x) then
		return seq;
	else 
		Add(seqlist, seq);
		return seqlist;
	fi;
end);

InstallMethod(LoadStepFSR, " load + 1 external step", 
[IsFSR, IsFFECollection, IsFFE],
 function(x,  ist, elm)
local  i,  seq, seqlist;
	seqlist := [];
# load FSR
	seq := LoadFSR(x,ist); # the seq_0 element
	Add(seqlist, seq);
# start run
	seq := StepFSR(x, elm);

	if IsFILFUN(x) then
		return seq;
	else 
		Add(seqlist, seq);
		return seqlist;
	fi;
end);



InstallMethod(LoadStepFSR, "load + 1 regular step", 
[IsFSR, IsFFE],
 function(x, ist)
return LoadStepFSR(x, [ist]);
end);



InstallMethod(LoadStepFSR, "load + 1 external step", 
[IsFSR, IsFFE, IsFFE],
 function(x,  ist, elm)

return LoadStepFSR(x, [ist], elm);
end);






#############################################################################

# I. run for num steps with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsPosInt, IsBool], function(x, num, pr)
local seq, sequence, nrsteps, treshold, i, B;

# check num
	treshold := Threshold(x);
	if num > treshold then
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
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold);
		Print(" elements of the sequence\n");
	fi;
	return sequence;
end);

# Ia. run for num steps without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsPosInt], function(x, num)
	return  RunFSR(x,  num, false);
end);

# Ib. run with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR,   IsBool], function(x, pr)
	return RunFSR(x, 	 Threshold(x) , pr);
  ## change num to something huge then the called method will set the threshold
end);

# Ic. run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR], function(x)
	return RunFSR(x, 	Threshold(x) , false);
  ## change num to something huge then the called method will set the threshold
end);




InstallMethod(PrintHeaderRunFSR, "print header for run FSR", 
[IsFSR, IsFFE, IsPosInt], function(x, seq, m)
local  i, taps, B;
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

InstallMethod(PrintHeaderRunFSR, "print header for run FSR",
 [IsFSR, IsFFE, IsFFE, IsPosInt],  function(x, elm, seq, m)
local  i, taps, B;
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



 
# PRIMARY METHOD FOR ALL PRACTICAL PURPOSES: 
# because otherwise u need to handle the seq_0 elm urself
# load with <ist> then call   RunFSR( FSR, num-1 , pr)
# Vb. load new initial state then run for num-1 steps with/without print to shell
# load + run
# II. load initial state then run for num-1 steps without/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsPosInt, IsBool],
 function(x,ist, num, pr)
local  i, sequence,treshold , seq, taps, B, m;
	sequence :=[];
		
# load FSR
	seq := LoadFSR(x,ist); # the seq_0 element
	
# print header, init state and seq_0
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;
	if pr then
		PrintHeaderRunFSR(x, seq, m);
	fi;

# start run
	sequence := RunFSR(x, num, pr);
	Add(sequence,seq,1);	# seq_0 at the beginning

	return sequence;
end);


# IIa. load new initial state then run for num-1 steps without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsPosInt],
function(x, ist, num)
	return RunFSR(x, ist, num, false);
end);

# IIb. load new initial state then run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsBool],
function(x, ist , pr)
		return RunFSR(x, ist, Threshold(x)   , pr);
end);

# IIc. load new initial state then run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection], function(x, ist )
		return RunFSR(x, ist, Threshold(x)   , false);
end);



# EXTERNAL STEP
# rationale behind copied code is speed: could be a very long sequence, dont want to many functions calling eachother

# III. run for num steps with the same external input on each step and with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsPosInt, IsBool],
 function(x, elm, num, pr)
local seq, sequence, nrsteps, treshold, i, B;
		sequence := [];
# check num
		treshold := Threshold(x);
	if num > treshold then
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;

	if pr then
			B := x!.basis;
		Print("using basis B := ",BasisVectors(B),"\t\n");
	fi;
	
#start run	
	for i in [1.. nrsteps] do
		seq := StepFSR(x,elm);
		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step
		if pr then
			Print("\t\t", IntVecFFExt(B, x!.state));  		# NOT reversed !!!!
			if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B, seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(B, seq) , "\n");
			fi;
		fi;
	od;
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold);
		Print(" elements of the sequence\n");
	fi;
	return sequence;
end);



# IIIa. run for num steps with the same external input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsPosInt], function(x, elm, num)
	return RunFSR(x, elm, num, false);
end);
## change num to something huge then the called method will set the threshold

# IIIb. run with the same external input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsBool], function(x, elm, pr)
	return RunFSR(x,  elm,   Threshold(x) , pr); 
end);


# IIIc. run with the same external input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE], function(x, elm)
	return RunFSR(x,  elm,  Threshold(x) , false); 
end);



# LOAD + RUN
# IV. load and run for num steps with a different external input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR",
[IsFSR,  IsFFECollection, IsFFECollection, IsBool],
function(x,  ist, elmvec, pr)
local  sequence,  treshold, num, nrsteps, seq , seq0, i, B, m;
	
	sequence := [];
	treshold := Threshold(x);
	num := Length(elmvec);
	if num > treshold then
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;
	
# load FSR
	seq0 := LoadFSR(x,ist); # the seq_0 element

# print header, init state and seq_0
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;	
	B := x!.basis;
	if pr then
		PrintHeaderRunFSR(x,Zero(UnderlyingField(x)), seq0, m);
	fi;	
	
#start run
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
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold);
		Print(" elements of the sequence\n");
	fi;
	return sequence;
end);


# IVb. run for num steps with the different external input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsFFECollection],
 function(x, ist, elmvec)
	return RunFSR(x, ist, elmvec, false);
end);





# V. continue run with the different external input on each step with/without print to shell,
# without loading first
InstallMethod(RunFSR, "run FSR", [IsFSR, IsZero, IsFFECollection, IsBool],
 function(x, z, elmvec, pr)
local  sequence,  treshold, num, nrsteps, seq , i, B, m ;

	treshold := Threshold(x);
	num := Length(elmvec);
	if num > treshold then
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;

# print header, init state and seq_0
	if pr then
		if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
		else m:= 1;
		fi;
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

#note: there will be an element missing coz we start output with CURRENT state, without step ...
#the seq elm that came from step is already in the sequence, we dont want to repeat it
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
			if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(B, seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(B, seq) , "\n");
			fi;
		fi;
	od;
	if num > treshold then
		Print("over the threshold, will only output the first ",treshold);
		Print(" elements of the sequence\n");
	fi;
	return sequence;
end);


# Va. run for num steps with the different external input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsZero, IsFFECollection], 
function(x, z, elmvec)
	return RunFSR(x, z, elmvec, false);
end);


#FILFUN RUN

# VI. run for FILFUN with diff ist on each step (using LoadStepFSR)
InstallMethod(RunFSR, "run FSR", [IsFILFUN, IsFFECollColl,  IsBool],
 function(x,ist, pr)
local  i, sequence, seq, taps, B, m;
	sequence :=[];
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;
	if pr then
		B := x!.basis;
		PrintHeaderRunFSR(x, Zero(UnderlyingField(x)), m);
	fi;
	B := x!.basis;
# start run
	for i in [1.. Length(ist)] do 
		seq := LoadStepFSR(x, ist[i]);
		Add(sequence, seq);
	# print 
		if pr then
		Print("\t\t", (IntVecFFExt(B,x!.state)), "\t -> \t");  # NOT reversed !!!!
		Print("\t\t", IntFFExt(B,seq) , "\n");
		fi;		
	od;

	return sequence;
end);


# VIa. run for FILFUN with diff ist on each step (using LoadStepFSR) without print to shell
InstallMethod(RunFSR, "run FSR", [IsFILFUN, IsFFECollColl],
function(x, ist)
	return RunFSR(x, ist, false);
end);


# EXTERNAL STEP


# VII. run for FILFUN with diff ist  but same external elm on each step (using LoadStepFSR)
InstallMethod(RunFSR, "run FSR", [IsFILFUN, IsFFECollColl,  IsFFE, IsBool],
 function(x, ist, elm, pr)
local  i, sequence, seq, taps, B, m;
	sequence :=[];
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;
	if pr then
		B := x!.basis;
		PrintHeaderRunFSR(x, Zero(UnderlyingField(x)), m);
	fi;

# start run
	for i in [1.. Length(ist)] do 
		seq := LoadStepFSR(x, ist[i], elm);
		Add(sequence, seq);
	# print 
		if pr then
		Print("\t\t", (IntVecFFExt(B,x!.state)), "\t -> \t");  # NOT reversed !!!!
		Print("\t\t", IntFFExt(B,seq) , "\n");
		fi;				
	od;

	return sequence;
end);


# VIIa. run for FILFUN with diff ist but the same external elm  on each step (using LoadStepFSR) without print to shell
InstallMethod(RunFSR, "run FSR", [IsFILFUN, IsFFECollColl, IsFFE],
function(x, ist, elm)
	return RunFSR(x, ist, elm, false);
end);



# VIII. run for FILFUN with diff ist  and diff  external elm on each step (using LoadStepFSR)
InstallMethod(RunFSR, "run FSR", [IsFILFUN, IsFFECollColl,  IsFFECollection, IsBool],
 function(x, ist, elmvec, pr)
local  i, sequence, seq, taps, B, m;
	if Length(ist) <> Length(elmvec) then
		Error("number of different initial states <> number of external elements\n");
	fi;
	sequence :=[];
	if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
	else m:= 1;
	fi;
	if pr then
		B := x!.basis;
		PrintHeaderRunFSR(x, Zero(UnderlyingField(x)), m);
	fi;

# start run
	for i in [1.. Length(ist)] do 
		seq := LoadStepFSR(x, ist[i], elmvec[i]);
		Add(sequence, seq);
	# print 
		if pr then
		Print("\t\t", (IntVecFFExt(B,x!.state)), "\t -> \t");  # NOT reversed !!!!
		Print("\t\t", IntFFExt(B,seq) , "\n");
		fi;		
	od;

	return sequence;
end);


# VIIIa. run for FILFUN with diff ist on each step (using LoadStepFSR) without print to shell
InstallMethod(RunFSR, "run FSR", [IsFILFUN, IsFFECollColl, IsFFECollection],
function(x, ist, elmvec)
	return RunFSR(x, ist, elmvec, false);
end);

Print("fsr.gi OK,\t");
