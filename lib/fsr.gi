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

Print("fsr.gi OK,\t");