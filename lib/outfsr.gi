



















#############################################################################
##
#M  ViewObj( <nlfsr> ) . . . . . . . . . . . . . . . 
##
InstallMethod( ViewObj,    "for FSR",    true,    [ IsFSR ],    0,  function( x )
local uf; 
	uf := UnderlyingField(x);	
	if x!.numsteps=-1 then 
			if IsLFSR(x) then 	Print("< empty LFSR over ",uf," given by CharPoly = ", CharPoly(x), " >");
			else 	Print("< empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x), "> ");
			fi;
	else 	
			if IsLFSR(x) then  Print("< LFSR over ",uf,"  given by CharPoly = ", CharPoly(x), " >");
			else 		Print("< NLFSR of length ",Length(x)," over ",uf,",\n given by MultivarPoly = ", MultivarPoly(x), "> ");
			fi;
	fi;
end );

InstallMethod( Display,  "for FSR",	    true,    [ IsFSR ],        0,    function( x )
    ViewObj(x);
end );




#############################################################################
##
#M  PrintObj( <nlfsr> ) . . . . . . . . . . . . . . . . .
##
InstallMethod( PrintObj,     "for FSR",    true,    [IsFSR,  IsBool ],    0,  function( x, b )
local uf, B; 
	uf := UnderlyingField(x);	
	if x!.numsteps=-1 then 
			if IsLFSR(x) then 	Print("empty LFSR over ",uf," given by CharPoly = ", CharPoly(x));
			else 	Print("empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x));
			fi;
	else 	

			B := x!.basis;	
			if IsLFSR(x) then  Print("LFSR over ",uf,"  given by CharPoly = ", CharPoly(x));
			else 		Print("NLFSR of length ",Length(x)," over ",uf,",\n given by MultivarPoly = ", MultivarPoly(x));
			fi;
			
			Print("\nwith basis =");
			Print(BasisVectors(B)); 

			Print("\nwith current state =");
				if b  then 	Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!!
				else 	Print(((x!.state)));# NOT reversed !!!!
				fi;
			Print("\nafter  ",x!.numsteps," steps\n");
		fi;

end );

#############################################################################
##
#M  PrintObj( <nlfsr> ) . . . . . . . . . . . . . . . . .
##
InstallOtherMethod( PrintObj,     "for FSR",    true,    [ IsFSR ],    0,  function( x )
	PrintObj( x, false);
end );



#############################################################################
##
#M  PrintAll( <lfsr> , <b> ) . . . . . . . as binary vectors in a given basis
##
InstallMethod( PrintAll,     "for NLFSR",    true,    [IsFSR,  IsBool ],    0,  function( x, b )
local uf, tap, i, B;

	uf := UnderlyingField(x);	
	if x!.numsteps=-1 then 
			if IsLFSR(x) then 	Print("empty LFSR over ",uf," given by CharPoly = ", CharPoly(x));
			else 	Print("empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x));
			fi;
	else 	
			if IsLFSR(x) then  Print("LFSR over ",uf,"  given by CharPoly = ", CharPoly(x));
			else 		Print("NLFSR of length ",Length(x)," over ",uf,",\n given by MultivarPoly = ", MultivarPoly(x));
			fi;
	fi;
	B := x!.basis;
	Print("\nwith basis =");
	Print(BasisVectors(B)); 
	
	if IsLFSR(x) then
			Print("\nwith feedback coeff =");
			if b  then  Print(IntVecFFExt(B, FeedbackVec(x))); # NOT reversed !!!!
			else 		Print((FeedbackVec(x))); # NOT reversed !!!!	
			fi;
	fi;
	Print("\nwith initial state  =");
			if b  then 	Print((IntVecFFExt(B, x!.init))); # NOT reversed !!!!
			else 			Print(((x!.init))); # NOT reversed !!!!
			fi;	
	Print("\nwith current state  =");
			if b  then 	Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!!
			else 	Print(((x!.state)));# NOT reversed !!!!
			fi;
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
#M  PrintAll( <nlfsr> ) . . . . . . . using GAP native representation of field elms
##
InstallMethod( PrintAll,     "for FSR",    true,    [ IsFSR ],    0,  function( x )
	PrintAll(x, false);		
end );





#############################################################################
##
#
#F WriteAllLFSR( <output>, <lfsr> , <b>) . . . . . . . . . . . . . . . . . . view a GF2 vector
##
InstallGlobalFunction( WriteAllLFSR, function(output,  x, b)
local uf, tap, i, B;
	if (IsOutputStream( output )) then
		if IsBasis(B) then 
 			
 			uf := UnderlyingField(x);	


			if x!.numsteps=-1 then 
					if IsLFSR(x) then 	AppendTo(output,"empty LFSR over ",uf," given by CharPoly = ", CharPoly(x));
					else 	AppendTo(output,"empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x));
					fi;
			else 	
					if IsLFSR(x) then AppendTo(output,"LFSR over ",uf,"  given by CharPoly = ", CharPoly(x));
					else 		AppendTo(output,"NLFSR of length ",Length(x)," over ",uf,",\n given by MultivarPoly = ", MultivarPoly(x));
					fi;
			fi;			
			B := x!.basis;			
			
			AppendTo(output,"\nwith basis =");
			AppendTo(output,BasisVectors(B)); 
			
			if IsLFSR(x) then
					AppendTo(output,"\nwith feedback coeff =");
					if b  then  AppendTo(output,VecToString(B, FeedbackVec(x))); # NOT reversed !!!!
					else 		AppendTo(output,(FeedbackVec(x))); # NOT reversed !!!!	
					fi;
			fi;
			AppendTo(output,"\nwith initial state  =");
					if b  then 	AppendTo(output,(VecToString(B, x!.init))); # NOT reversed !!!!
					else 			AppendTo(output,((x!.init))); # NOT reversed !!!!
					fi;	
			AppendTo(output,"\nwith current state  =");
					if b  then 	AppendTo(output,(VecToString(B, x!.state)));# NOT reversed !!!!
					else 	AppendTo(output,((x!.state)));# NOT reversed !!!!
					fi;
			AppendTo(output,"\nafter ");
			if x!.numsteps>0 then 
				AppendTo(output,x!.numsteps," steps\n");
			elif x!.numsteps=0 then 
				AppendTo(output,"loading\n");
			else 	AppendTo(output,"initialization \n");
			fi;
			
			tap := OutputTap(x); 
			if Length(tap)=1 then 
				AppendTo(output,"with output from stage S_",tap[1],"\n");
			else 
				AppendTo(output,"with output from stages S_",tap,"\n");
			fi;

	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);



Print("outfsr.gi OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here