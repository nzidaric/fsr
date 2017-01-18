#############################################################################
##
#W  fsr.gi                   GAP Library                   nusa zidaric
##
##



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
	if FieldPoly(x)=1 then F := GF(Characteristic(x));
	else F := FieldExtension(GF(Characteristic(x)), FieldPoly(x));
	fi;
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
local fb, st, new, tap,i, seq, n; 

	if x!.numsteps < 0 then 
		Error( "the LFSR is NOT loaded !!!" );
				return fail;
	fi;		

	n := Length(x);
	fb := FeedbackVec(x); 
	st := x!.state; 

# add for NLFSR
# the step
	new := fb * st; 
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
	if FieldPoly(x)=1 then F := GF(Characteristic(x));
	else F := FieldExtension(GF(Characteristic(x)), FieldPoly(x));
	fi;
	if not (\in(elm, F)) then
		Error( "second argument ",elm,"is not an element of the underlying field !!!" );
		return fail;
	fi;	

	n := Length(x);
	fb := FeedbackVec(x); 
	st := x!.state; 

# the step
	new := (fb * st) + elm; 
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





Print("fsr.gi OK,\t");