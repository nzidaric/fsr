#############################################################################
##
#W  fsr.gi                   GAP Package                   nusa zidaric
##
##

#############################################################################
##
##
#F  ChooseField( <F> )
##
##  choose the underlying finite field for the NLFSR
##  needed to create the indeterminates !!!!
##  :(
InstallGlobalFunction( ChooseField, function( F )
    local x, i , str, MaxNLFSRLen, MaxNrOfPresentMonomials, xlist ;

	if(IsField(F)) then
		x := X(F, "x");
		MaxNLFSRLen := 100;
		MaxNrOfPresentMonomials := 100;
		if not IsBoundGlobal("MaxNLFSRLen") then 
			BindGlobal("MaxNLFSRLen" , 100);
			BindGlobal("MaxNrOfPresentMonomials" , 100);
			MakeReadWriteGlobal("MaxNLFSRLen");
			MakeReadWriteGlobal("MaxNrOfPresentMonomials");
		fi;

		xlist := [];
		for i in [1..MaxNLFSRLen] do  
			str :=  Concatenation("x_",String(i-1)); 
			if IsBoundGlobal(str) then 
				Print("changing: ",str," \n");
				str := Indeterminate(F,1000+(i-1));
			else

				Print("binding: ",str," \n");			
				SetIndeterminateName(FamilyObj(x), 1000+(i-1), str); 
				BindGlobal(str,Indeterminate(F,1000+(i-1)));
				MakeReadWriteGlobal(str);
			fi;
			Add(xlist, str );
		od;
		if not IsBoundGlobal("xlist") then 
			BindGlobal("xlist" , xlist);
		fi;
		Print("You can now create an NLFSR with up to ", MaxNLFSRLen ," stages\n");
		Print("with up to  ", MaxNrOfPresentMonomials ," nonzero terms\n");
	else 	
	    Error("F is not a field !!!! \n");
	  fi;
return;
end );







#############################################################################
##
#F  FSRFamily( <p> ) 
##  copied from FFEFamily
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
#A  InternalStateSize( <fsr> )
##  still works after the move :) 
InstallMethod(InternalStateSize, "size of FSR's internal state", [IsFSR], function(x)
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
#O  LoadFSR( <lfsr>, <ist> )
##
##  almost identical for both 
##
InstallMethod(LoadFSR, "one step of FSR", [IsFSR,  IsFFECollection], function(x, ist)
local i, F, tap, seq, scist;
	if Length(ist) <> Length(x) then
		Error( "initial state length doesnt match" );		return fail;
	fi;
#	if FieldPoly(x)=1 then F := GF(Characteristic(x));
#	else F := FieldExtension(GF(Characteristic(x)), FieldPoly(x));
#	fi;
	F := UnderlyingField(x);
	for i in [1..Length(ist)] do 
		if not (\in(ist[i], F)) then
			Error( "initial state element at index=",i,"is not an element of the underlying field !!!" );
					return fail;
		fi;	
	od;	
	
# update fields
	# NOT reversed !!!!
	scist := ShallowCopy((ist)); 	# without this the original ist outside here was changing too :( 
	x!.init := Immutable(scist);
	x!.state := scist;
	x!.numsteps := 0;
	
## TO DO : UPDATE THE BoolState field for NLFSR 
# not having BoolState for NLFSR anymore !!! 
	
# sequence starts with seq_0, seq_1, ...
	tap := OutputTap(x); 
	if Length(tap)=1 then 
	#	Print("Length=",Length(x)," and tap =",tap[1]," and index =",Length(x)-tap[1],"\n");
		seq := ist[Length(x)-tap[1]];
	else  # this is rare !!! so dont make seq a list if not necessary
		seq := [];
		for i in [1.. Length(tap)] do  
	 		seq[i] :=  ist[Length(x)-tap[i]]; # to get the corresponding index 
	 	od;
	fi; 

	return seq; #must return first output seq_0, but numsteps=0
end);

#############################################################################
##
#O  StepFSR( <fsr> , <print>)
##

##this one is more commonly used 
## so whats faster: GAP calling the next menthod with elm = 0 
## or having an almost identical copy of the method (difference is only in the computation of new)
InstallMethod(StepFSR, "one step of FSR", [IsFSR], function(x )
local fb, st, new, tap,i, seq, n, F; 

	if x!.numsteps < 0 then 
		Error( "the LFSR is NOT loaded !!!" );
				return fail;
	fi;		
	F := UnderlyingField(x);
	n := Length(x);
	fb := FeedbackVec(x); 
	st := x!.state; 

# add for NLFSR
# the step
	new := fb * st; 
	if not(\in(new,F)) then
		Error( "computed feedback is not an element of the underlying field !!!" );		return fail;
	fi;
	
	
	RightShiftRowVector(st,1,new);	# NOT reversed !!!!  -> hence right shift to get rid of the lowst one
	Remove(st, n+1);
# if we didnt use the downto notation then:
#	LeftShiftRowVector(st,1);
#	st[n] := new;
	


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
	
# update fields
	x!.state := st;
	x!.numsteps := x!.numsteps + 1;
	
	return seq;
end);




InstallMethod(StepFSR, "one step of FSR with an external input", [IsFSR, IsFFE], function(x, elm)
local fb, st, new, tap,i, seq, F, n; 
	if x!.numsteps < 0 then 
		Error( "the FSR is NOT loaded !!!" );
		return fail;
	fi;		
	F := UnderlyingField(x);
	if not (\in(elm, F)) then
		Error( "second argument ",elm,"is not an element of the underlying field !!!" );
		return fail;
	fi;	

	n := Length(x);
	fb := FeedbackVec(x); 
	st := x!.state; 

# the step
	new := (fb * st) + elm; 
	if not(\in(new,F)) then
		Error( "computed feedback is not an element of the underlying field !!!" );		return fail;
	fi;

	RightShiftRowVector(st,1,new);	# NOT reversed !!!!  -> hence right shift to get rid of the lowst one
	Remove(st, n+1);
	

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
	
# update fields
	x!.state := st;
	x!.numsteps := x!.numsteps + 1;

	return seq;
end);




#############################################################################
##
#O  RunFSR( <FSR> , <num>, <pr> ) ......... I.   run for num steps with/without print to shell
#O  RunFSR( <FSR> , <num> ) ............... II.  run for num steps without print to shell
#O  RunFSR( <FSR> , <pr> ) ................ III. run with/without print to shell
#O  RunFSR( <FSR> ) ....................... IV.  run without print to shell
#O  RunFSR( <FSR> , <ist>, <num>, <pr>) ... V.   load new initial state then run for num-1 steps with/without print to shell
#O  RunFSR( <FSR> , <ist>, <num>) ......... VI.  load new initial state then run for num-1 steps without print to shell
#O  RunFSR( <FSR> , <ist>) ................ VII. load new initial state then run without print to shell
## nonlinear versions 
#O RunFSR(<FSR>, <elm>, <num>, <pr>) ...... VIII. run for num steps with the same nonlinear input on each step and with/without print to shell
#O RunFSR(<FSR>, <elm>, <num> ) ........... IX.   run for num steps with the same nonlinear input on each step without print to shell
#O RunFSR(<FSR>, <ist>, <elmvec>, <pr> ) .. X.    run for num steps with the different nonlinear input on each step with/without print to shell


# I. run for num steps with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsPosInt, IsBool], function(x, num, pr)
local seq, sequence, nrsteps, treshold, i; 
# check num
	treshold := Period(x) + Length(x); #(if primitive thats one period plus one length of FSR)
	if num > treshold then 
		Print("over the treshold, will only output the first ",treshold,"elements of the sequence");
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;
#start run
	sequence := [];		
	for i in [1.. nrsteps] do 
		seq := StepFSR(x);
		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step 
		if pr then 
			Print(IntVecFFExt(x!.state));  				# NOT reversed !!!! 
			if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(seq) , "\n");
			fi;			
		fi;
	od; 

	return sequence;
end);

# II. run for num steps without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsPosInt], function(x, num)
	return  RunFSR(x, num, false);	
end);

# III. run with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsBool], function(x, pr)		
	return RunFSR(x, Period(x) + Length(x), pr);
end);

# IV. run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR], function(x)		
	return RunFSR(x, Period(x) + Length(x), false);
end);


# PRIMARY METHOD FOR ALL PRACTICAL PURPOSES: because otherwise u need to handle the seq_0 elm urself 
# load with <ist> then call   RunFSR( FSR, num-1 , pr)
# V. load new initial state then run for num-1 steps with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection, IsPosInt, IsBool], function(x, ist, num, pr)
local  i, sequence,  seq, taps; 
# load FSR 
	seq := LoadFSR(x,ist); # the seq_0 element 
# print header, init state and seq_0
	if pr then 
		Print( "[ ",Length(x)-1,",");
		for i in [2.. Length(x)-1] do
			Print("...");
		od;
		Print(",0 ]");
		Print( "  with taps  ",OutputTap(x),"\n");		
		Print((IntVecFFExt(x!.state)));  				# NOT reversed !!!! 
		if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(seq) , "\n");
		else  Print("\t\t",  IntVecFFExt(seq) , "\n");
		fi;			
	fi;
# start run
	sequence := RunFSR(x, num-1, pr);		
	Add(sequence,seq,1);	# seq_0 at the beginning	

	return sequence;
end);

# VI. load new initial state then run for num-1 steps without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR,IsFFECollection, IsPosInt], function(x, ist, num)
	return RunFSR(x,ist, num, false);
end);

# VII. load new initial state then run without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR,IsFFECollection], function(x, ist )
	return RunFSR(x,ist,Period(x) + Length(x), false);
end);


# NONLINEAR STEP 

# VIII. run for num steps with the same nonlinear input on each step and with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE, IsPosInt, IsBool], function(x, elm, num, pr)
local seq, sequence, nrsteps, treshold, i; 
# check num
	treshold := Period(x) + Length(x); #(if primitive thats one period plus one length of FSR)
	if num > treshold then 
		Print("over the treshold, will only output the first ",treshold,"elements of the sequence");
		nrsteps := treshold;
	else 	nrsteps := num;
	fi;
#start run
	sequence := [];		
	for i in [1.. nrsteps] do 
		seq := StepFSR(x,elm);
		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step 
		if pr then 
			Print(IntVecFFExt(x!.state));  				# NOT reversed !!!! 
			if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(seq) , "\n");
			fi;			
		fi;
	od; 

	return sequence;
end);

# IX. run for num steps with the same nonlinear input on each step without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFE], function(x, elm)
	return RunFSR(x,elm, Period(x) + Length(x), false);
end);

#PROBLEM : method dselection cant decide between this and  VII. RunFSR( <FSR> , <ist>, <pr> ) 
#InstallMethod(RunFSR, "run FSR", [IsFSR, IsFFECollection], function(x,  elmvec, pr)
#local  sequence,  treshold, num, nrsteps, seq , i; 
# check num NOTE: nonlinear can be much much longer , FIX THRESHOLD
#	treshold := Period(x) + Length(x);  
#	num := Length(elmvec);
#	if num > treshold then 
#		Print("over the treshold, will only output the first ",treshold,"elements of the sequence");
#		nrsteps := treshold;
#	else 	nrsteps := num;
#	fi;
#start run
#	sequence := [];		
#	for i in [1.. nrsteps] do 
#		seq := StepFSR(x,elmvec[i]);
#		Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
#print on every step 
#		if pr then 
#			Print(IntFFExt(elmvec[i]),"\t\t");  				# NOT reversed !!!! 		
#			Print(IntVecFFExt(x!.state));  				# NOT reversed !!!! 
#			if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(seq) , "\n");
#			else  	Print("\t\t",  IntVecFFExt(seq) , "\n");
#			fi;			
#		fi;
#	od; 
#
#	return sequence;
#end);



# X. run for num steps with the different nonlinear input on each step with/without print to shell
InstallMethod(RunFSR, "run FSR", [IsFSR,  IsFFECollection, IsFFECollection, IsBool], function(x, ist, elmvec, pr)
local  sequence,  treshold, num, nrsteps, seq , i; 
# load FSR 
	seq := LoadFSR(x,ist); # the seq_0 element 
# print header, init state and seq_0
	if pr then 
		Print("elm \t\t");
		Print( "[ ",Length(x)-1,",");
		for i in [2.. Length(x)-1] do
			Print("...");
		od;
		Print(",0 ]");
		Print( "  with taps  ",OutputTap(x),"\n");	
		Print(" \t\t");
		Print((IntVecFFExt(x!.state)));  				# NOT reversed !!!! 
		if Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(seq) , "\n");
		else  Print("\t\t",  IntVecFFExt(seq) , "\n");
		fi;			
	fi;


# check num NOTE: nonlinear can be much much longer , FIX THRESHOLD
	treshold := Period(x) + Length(x);  
	num := Length(elmvec);
	if num > treshold then 
		Print("over the treshold, will only output the first ",treshold,"elements of the sequence");
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
			Print(IntFFExt(elmvec[i]),"\t\t");  				# NOT reversed !!!! 		
			Print(IntVecFFExt(x!.state));  				# NOT reversed !!!! 
			if 	Length(OutputTap(x))=1 then Print("\t\t", IntFFExt(seq) , "\n");
			else  	Print("\t\t",  IntVecFFExt(seq) , "\n");
			fi;			
		fi;
	od; 



	Add(sequence,seq,1);	# seq_0 at the beginning
	return sequence;
end);




Print("fsr.gi OK,\t");