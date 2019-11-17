
#############################################################################
##
##
#W  outfsr.gi          FSR Package                  Nusa
##
##




#############################################################################
##
#M  ViewObj( <fsr> ) . . . . . . . . . . . . . . . fixed for FILFUN
##
InstallMethod( ViewObj,    "for FSR",    true,    [ IsFSR ],  0, function( x )
local uf;
	uf := UnderlyingField(x);
	if x!.numsteps=-1 then
		Print("< empty ");
	else
		Print("< ");
	fi;

	if IsLFSR(x) then
			Print("LFSR over ",uf,"  given by FeedbackPoly = ");
			Print(FeedbackPoly(x), " >");
	elif IsNLFSR(x) then
			Print("NLFSR of length ",Length(x)," over ",uf);
			Print(",\n given by MultivarPoly = ", MultivarPoly(x), "> ");
	else
		Print("FILFUN of length ",Length(x)," over ",uf);
		Print(",\n  with the MultivarPoly = ", MultivarPoly(x), "> ");
	fi;
end );

InstallMethod( Display,  "for FSR",	    true,    [ IsFSR ], 0,    function( x )
    ViewObj(x);
end );




#############################################################################
##
#M  PrintObj( <nlfsr> ) . . . . . . . . . . . . . . . . .fixed for FILFUN
##
InstallMethod( PrintObj, "for FSR", true, [IsFSR,  IsBool ], 0, function( x, b )
local uf, B, prflag;
	uf := UnderlyingField(x);
	if x!.numsteps=-1 then
		Print("empty ");
	fi;
	if IsLFSR(x) then
		Print("LFSR over ",uf," given by FeedbackPoly = ", FeedbackPoly(x));
	elif IsNLFSR(x) then
		Print("NLFSR of length ",Length(x)," over ",uf);
		Print(",\n  given by MultivarPoly = ", MultivarPoly(x));
	else
		Print("FILFUN of length ",Length(x)," over ",uf);
		Print(",\n  with the MultivarPoly = ", MultivarPoly(x));
	fi;

	B := x!.basis;
	Print("\nwith basis =");
	Print(BasisVectors(B));

	Print("\nwith current state =");
	if b and not x!.sym then
				Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!!
	else 	Print(((x!.state)));# NOT reversed !!!!
	fi;
	if not IsFILFUN(x) then
				Print("\nafter  ",x!.numsteps," steps\n");
	fi;

end );

#############################################################################
##
#M  PrintObj( <nlfsr> ) . . . . . . . . . . . . . . . . .fixed for FILFUN
##
InstallOtherMethod( PrintObj, "for FSR",true,  [ IsFSR ],    0,  function( x )
	PrintObj( x, false);
end );


#############################################################################
##
#M  PrintAll( <lfsr> , <b> ) . . . . . . . as binary vectors in a given basis
##																			fixed for FILFUN
InstallMethod( PrintAll,"for FSR",true, [IsFSR,  IsBool ], 0, function( x, b )
local uf, tap, i, B;

	uf := UnderlyingField(x);
	if x!.numsteps=-1 then 		Print("empty ");
	fi;
	if IsLFSR(x) then
		Print("LFSR over ",uf," given by FeedbackPoly = ", FeedbackPoly(x));
	elif IsNLFSR(x) then
		Print("NLFSR of length ",Length(x)," over ",uf);
		Print(",\n  given by MultivarPoly = ", MultivarPoly(x));
	else
		Print("FILFUN of length ",Length(x)," over ",uf);
		Print(",\n  with the MultivarPoly = ", MultivarPoly(x));
	fi;

	B := x!.basis;
	Print("\nwith basis =", BasisVectors(B));

	if IsLFSR(x) then
			Print("\nwith feedback coeff =");
			if b and not x!.sym then
						Print(IntVecFFExt(B, FeedbackVec(x))); # NOT reversed !!!!
			else 	Print((FeedbackVec(x))); # NOT reversed !!!!
			fi;
	fi;
	if not IsFILFUN(x)  then
	 		Print("\nwith initial state  =");
			if b and not x!.sym then
						 	Print((IntVecFFExt(B, x!.init))); # NOT reversed !!!!
			else 		Print(((x!.init))); # NOT reversed !!!!
			fi;
	fi;
	Print("\nwith current state  =");
	if b and not x!.sym then
		 		Print((IntVecFFExt(B, x!.state)));# NOT reversed !!!!
	else	Print(x!.state);# NOT reversed !!!!
	fi;
	if not IsFILFUN(x) then
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
	else
			Print( "\n");
	fi;

end );



#############################################################################
##
#M  PrintAll( <fsr> ) . . . . . using GAP native representation of field elms
##																				fixed for FILFUN
InstallMethod( PrintAll, "for FSR",    true,    [ IsFSR ],    0,  function( x )
	PrintAll(x, false);
end );




#############################################################################
##
#
#F WriteAllLFSR( <output>, <lfsr> , <b>) . . .. . . view a GF2 vector
##
##																				fixed for FILFUN

InstallGlobalFunction( WriteAllFSR, function(output, x, b)
local uf, tap, i, B;
		SetPrintFormattingStatus(output, false);
	 	if IsFSR(x) then
 			uf := UnderlyingField(x);
			if x!.numsteps=-1 then 		AppendTo(output,"empty ");
			fi;
			if IsLFSR(x) then
				AppendTo(output,"LFSR over ",uf);
				AppendTo(output," given by FeedbackPoly = ", FeedbackPoly(x));
			elif IsNLFSR(x) then
			 	AppendTo(output,"NLFSR of length ",Length(x)," over ",uf);
				AppendTo(output,",\n  given by MultivarPoly = ", MultivarPoly(x));
			else
				AppendTo(output,"FILFUN of length ",Length(x)," over ",uf);
				AppendTo(output,",\n given by MultivarPoly = ", MultivarPoly(x));
			fi;

			B := x!.basis;
			AppendTo(output,"\nwith basis =", BasisVectors(B));

			if IsLFSR(x) then
				AppendTo(output,"\nwith feedback coeff =");
				if b and not x!.sym then
				 			AppendTo(output,VecToString(B, FeedbackVec(x))); # NOT reversed !!!
				else 	AppendTo(output,(FeedbackVec(x))); # NOT reversed !!!!
				fi;
			fi;
			if not IsFILFUN(x) then
				AppendTo(output,"\nwith initial state  =");
				if b and not x!.sym then
							AppendTo(output,(VecToString(B, x!.init))); # NOT reversed !!!!
				else 	AppendTo(output,((x!.init))); # NOT reversed !!!!
				fi;
			fi;
			AppendTo(output,"\nwith current state  =");
			if b and not x!.sym then
						AppendTo(output,(VecToString(B, x!.state)));# NOT reversed !!!
			else	AppendTo(output,((x!.state)));# NOT reversed !!!!
			fi;
			if not IsFILFUN(x)  then
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
				else	AppendTo(output,"with output from stages S_",tap,"\n");
				fi;
			else
					AppendTo(output,"\n");
			fi;
		else	Error("IsFSR false !!!!\n");
		fi;

	return;
end);

#############################################################################
##
#
#F WriteTEXAllLFSR( <output>, <lfsr> , <b>) . . .. . . view a GF2 vector
##
##																				fixed for FILFUN

InstallGlobalFunction( WriteTEXAllFSR, function(output, x, b, strGen, gen)
local uf, tap, i, B;
	SetPrintFormattingStatus(output, false);
	if x!.sym then
		Print("symbolic state TEX functions not supported!\n"); return;
	fi;

	 if IsFSR(x) then
	 	 	uf := UnderlyingField(x);
			if x!.numsteps=-1 then 	AppendTo(output,"empty ");
			fi;
			if IsLFSR(x) then
						AppendTo(output,"LFSR over ");
						WriteTEXFF(output,uf);
						AppendTo(output," given by FeedbackPoly = ");
			WriteTEXLFSRPolyByGenerator(output,  uf, FeedbackPoly(x), strGen, gen);
			elif IsNLFSR(x) then
					 	AppendTo(output,"NLFSR of length ",Length(x)," over ");
						WriteTEXFF(output,uf);
						AppendTo(output,",\\\\\n  given by MultivarPoly = ");
  WriteTEXMultivarFFPolyByGenerator(output,  uf,  MultivarPoly(x),    strGen, gen);
			else
 					 	AppendTo(output,"FILFUN of length ",Length(x)," over ");
						WriteTEXFF(output,uf);
						AppendTo(output,",\\\\\n  given by MultivarPoly = ");
  WriteTEXMultivarFFPolyByGenerator(output,  uf,  MultivarPoly(x),    strGen, gen);
			fi;
			B := x!.basis;

			if not IsPrimeField(uf) then
				AppendTo(output,"\\\\\nwith basis =");
			  WriteTEXBasisByGenerator(output, uf, B, strGen, gen);
			fi;
			if IsLFSR(x) then
				AppendTo(output,"\\\\\nwith feedback coeff =");
				if b and not x!.sym then
							WriteTEXFFEVec(output, B, FeedbackVec(x));
				else 	WriteTEXFFEVecByGenerator(output, uf, FeedbackVec(x), strGen, gen);
				fi;
			fi;
			if not IsFILFUN(x) then
				AppendTo(output,"\\\\\nwith initial state  =");
				if b and not x!.sym then
							WriteTEXFFEVec(output, B,  x!.init);
				else 	WriteTEXFFEVecByGenerator(output, uf,  x!.init , strGen, gen);
				fi;
			fi;
			AppendTo(output,"\\\\\nwith current state  =");
			if b and not x!.sym then
						WriteTEXFFEVec(output, B,  x!.state);
			else 	WriteTEXFFEVecByGenerator(output, uf, x!.state , strGen, gen);
			fi;
		if not IsFILFUN(x) then
			AppendTo(output,"\\\\\nafter ");
			if x!.numsteps>0 then
						AppendTo(output,x!.numsteps," steps\\\\\n");
			elif x!.numsteps=0 then
						AppendTo(output,"loading\\\\\n");
			else 	AppendTo(output,"initialization \\\\\n");
			fi;

			tap := OutputTap(x);
			if Length(tap)=1 then
				AppendTo(output,"with output from stage $S_{",tap[1],"}$\n");
			else
				AppendTo(output,"with output from stages $S_{",tap,"}$\n");
			fi;
		#else AppendTo(output,"\\\\\n");
		fi;
AppendTo(output,"\\\\\n");
		else 	Error("IsFSR false !!!!\n");
		fi;
	return;
end);



#############################################################################
##
#F  WriteSequenceFSR 	( <output>, <lfsr>, <sequence> ) . . . . write elm to file
##
##																				fixed for FILFUN
##																				fixed for sym

InstallGlobalFunction( WriteSequenceFSR, function(output, x, sequence)
local  i,j, tmp, B, m;

SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then
		 	B := x!.basis;
			if Length(OutputTap(x))=1 or IsFILFUN(x) then
				AppendTo(output,"\nThe whole sequence:\n");
				for i in [1.. Length(sequence)-1] do
					if  x!.sym then AppendTo(output,(sequence[i]), ",\t");
					else AppendTo(output,(VecToString(B, sequence[i])), ",\t");
					fi;
				od;
				if  x!.sym then AppendTo(output,( sequence[Length(sequence)]), "\n");
				else AppendTo(output,(VecToString(B, sequence[Length(sequence)])), "\n");
				fi;
			else
				AppendTo(output,"\nThe whole sequences:\n");
				# must separate them for each tap position
				for j in [1..Length(OutputTap(x))] do
					AppendTo(output,"seq from S_",OutputTap(x)[j],": ");
					for i in [1.. Length(sequence)-1] do
						tmp := sequence[i]; # outputs on step i
						if  x!.sym then AppendTo(output,  tmp[j] , ", ");
						else AppendTo(output, VecToString(B, tmp[j]) , ", ");
						fi;
					od;
					tmp := sequence[Length(sequence)]; # last step
					if  x!.sym then AppendTo(output,  tmp[j] , "\n");
					else AppendTo(output, VecToString(B, tmp[j]) , "\n");
					fi;
				od;
			fi;
		else Error("IsFSR false  !!!!\n");
		fi;
	return;
end);

#############################################################################
##
#F  WriteTBSequenceFSR ( <output>, <lfsr>, <sequence> ) . . .. write elm to file
##
##																				fixed for FILFUN
##																				fixed for sym

InstallGlobalFunction( WriteTBSequenceFSR, function(output, x, sequence)
local  i,j, tmp, B, m;

SetPrintFormattingStatus(output, false);
	if IsFSR(x) and (not x!.sym) then
		B := x!.basis;
	# now append the whole sequence(s)
		if Length(OutputTap(x))=1  or IsFILFUN(x) then
			for i in [1.. Length(sequence)] do
				tmp := sequence[i]; # outputs on step i
				if not x!.sym then
					 		AppendTo(output,VecToString(IntFFExt(B,tmp)) , "\n");
				else  AppendTo(output,tmp , "\n");
				 fi;
			od;
		else
		# must separate them for each tap position
		for i in [1.. Length(sequence)] do
				tmp := sequence[i]; # outputs on step i
				for j in [1..Length(OutputTap(x))] do
					if not x!.sym then
					 			AppendTo(output, VecToString(B,tmp[j]) , "\t ");
					else 	AppendTo(output, tmp[j], "\t ");
					fi;
				od;
				AppendTo(output, "\n");
		od;
		fi;
	else Error("IsFSR false or symbolic!!!!\n");
	fi;
	return;
end);


#############################################################################
##
#F  WriteTEXSequenceFSR( <output>, <lfsr>, <sequence> ) . write to file
##
##																				fixed for FILFUN

InstallGlobalFunction(WriteTEXSequenceFSR,
function(output, x, sequence)
local  i, j, tmp, B, ffe;
SetPrintFormattingStatus(output, false);

	 if IsFSR(x) and not x!. sym then
	 		B := x!.basis;
				 if Length(OutputTap(x))=1  or IsFILFUN(x) then
						AppendTo(output,"\nThe whole sequence:\n");
						for j in [1.. Length(sequence)] do
								ffe := sequence[j];
								AppendTo(output,  "$",VecToString(B,ffe),"$");
							if j < Length(sequence) then
								AppendTo(output,  ",\\,");
							fi;
						od;
						AppendTo(output, "\n");
					else
						for j in [1..Length(OutputTap(x))] do
							AppendTo(output,"seq from $S_{",OutputTap(x)[j],"}$: ");
							for i in [1.. Length(sequence)-1] do
								tmp := sequence[i]; # outputs on step i
								WriteTEXFFE(output,  B, tmp[j]);
							 	AppendTo(output,  ",\t ");
							od;
							tmp := sequence[Length(sequence)]; # last step
							WriteTEXFFE(output, B, tmp[j]);
							AppendTo(output, "\\\\\n");
						od;
					fi;

		else	Error("IsFSR false  or symbolic !!!!\n");
		fi;

	return;
end);



#############################################################################
##
#F  WriteTEXSequenceFSRByGenerator( <output>, <lfsr>, <sequence> ) . write to file
##
##																				fixed for FILFUN

InstallGlobalFunction(WriteTEXSequenceFSRByGenerator,
function(output, x, sequence, strGen, gen)
local  i,j, tmp, ffe, exp, m, F, mv;
F := UnderlyingField(x);
SetPrintFormattingStatus(output, false);
if IsString(strGen)  then
	if Order(gen)=Size(F)-1 then
	 if IsFSR(x) then
		 if not x!.sym then
			 	if Length(OutputTap(x))=1  or IsFILFUN(x) then
		 			AppendTo(output,"\nThe whole sequence: \n");
					for j in [1.. Length(sequence)] do
						ffe := sequence[j];
						WriteTEXFFEByGenerator(output, ffe, strGen, gen);
						if j < Length(sequence) then
							AppendTo(output,  ",\\,");
						fi;
					od;
					AppendTo(output, "\n");
				else
						for j in [1..Length(OutputTap(x))] do
							AppendTo(output,"seq from $S_{",OutputTap(x)[j],"}$: ");
							for i in [1.. Length(sequence)-1] do
								tmp := sequence[i]; # outputs on step i
								WriteTEXFFEByGenerator(output,  tmp[j], strGen, gen);
							 	AppendTo(output,  ",\t ");
							od;
							tmp := sequence[Length(sequence)]; # last step
							WriteTEXFFEByGenerator(output,  tmp[j], strGen, gen);
							AppendTo(output, "\\\\\n");
						od;
				fi;
		 	else # symbolic
				if Length(OutputTap(x))=1  or IsFILFUN(x) then
					AppendTo(output,"\nThe whole sequence: \n");
					for j in [1.. Length(sequence)] do
						mv := sequence[j];
						AppendTo(output,  "\\;\t");
						WriteTEXMultivarFFPolyByGenerator(output, F, mv, strGen, gen);
						if j < Length(sequence) then
							AppendTo(output,  "\n,");
						fi;
					od;
					AppendTo(output, "\\\\\n");
				else
						for j in [1..Length(OutputTap(x))] do
							AppendTo(output,"seq from $S_{",OutputTap(x)[j],"}$: ");
							for i in [1.. Length(sequence)-1] do
								mv := sequence[j];
								AppendTo(output,  "\\;\t");
								WriteTEXMultivarFFPolyByGenerator(output, F, mv[i], strGen, gen);
								AppendTo(output,  ",\\;\t ");
							od;
							mv := sequence[Length(sequence)]; # last step
							WriteTEXMultivarFFPolyByGenerator(output, F, mv[j], strGen, gen);
							AppendTo(output, "\\\\\n");
						od;
				fi;
			fi;
		else 	Error("IsFSR false\n");
		fi;
	else 	Error(gen," is not a generator of ",F,"!!!!\n");
	fi;
else	Error(strGen," is not a string !!!!\n");
fi;
return;
end);


#############################################################################
##
#F  WriteRunFSR( <output>, <fsr>, <ist>, <numsteps> )  . . . write to file
##
##																				fixed for FILFUN

InstallGlobalFunction( WriteRunFSR, function(output, x, ist, num)
local  i,j, sequence,  seq, tmp, treshold, B, m, F;
F := UnderlyingField(x);
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) and (not IsFILFUN(x)) then
	# check num
			treshold := Threshold(x);
			if num > treshold then
				Print("over the treshold, will only output the first ",
				treshold," elements of the sequence\n");
				num := treshold;
			fi;

			if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
			else m:= 1;
			fi;

			B := x!.basis;

			seq := LoadFSR(x,ist); # the seq_0 element
			WriteAllFSR(output,  x, true);
			AppendTo(output,"   \n");

			AppendTo(output, "[ ",Length(x)-1);
			for i in [1..m] do			AppendTo(output,"   "); od;
			AppendTo(output, " ,");
			for i in [2.. (Length(x)-1)*m] do AppendTo(output,"..."); 	od;
	 		AppendTo(output,", 0 ");
	 		for i in [1..m-1] do			AppendTo(output,"   "); od;
	 		AppendTo(output, "]");
			AppendTo(output, "  with taps  ",OutputTap(x),"\n");
			if not x!.sym then
				AppendTo(output, (IntVecFFExt(B,x!.state)));
			else
				AppendTo(output, x!.state);  		# NOT reversed !!!!
			fi;

			if Length(OutputTap(x))=1 then
				if not x!.sym then	AppendTo(output,"\t\t",  IntFFExt(B,seq) , "\n");
				else 								AppendTo(output,"\t\t",  seq , "\n");
				fi;
			else
				if not x!.sym then	AppendTo(output,"\t\t",  IntVecFFExt(B,seq)  , "\n");
				else 								AppendTo(output,"\t\t",  seq , "\n");
				fi;
			fi;

			sequence := [];
			Add(sequence, seq); #always append at the end so that seq0 will be first

			# RUNNING (ie all other steps)
			for i in [1.. num] do

				seq := StepFSR(x);
				Add(sequence, seq);
				 #append at the end of the list: seq_0,seq_1,seq_2, ...
				 if not x!.sym then
	 				AppendTo(output, (IntVecFFExt(B,x!.state)));
	 			else
	 				AppendTo(output, x!.state);  		# NOT reversed !!!!
	 			fi;
				if Length(OutputTap(x))=1 then
					if not x!.sym then	AppendTo(output,"\t\t",  IntFFExt(B,seq) , "\n");
					else 								AppendTo(output,"\t\t",  seq , "\n");
					fi;
				else
					if not x!.sym then	AppendTo(output,"\t\t",  IntVecFFExt(B,seq)  , "\n");
					else 								AppendTo(output,"\t\t",  seq , "\n");
					fi;
				fi;
			od;
		# now append the whole sequence(s)
		WriteSequenceFSR(output, x, sequence);
	else 	Error("IsFSR false or  IsFILFUN true  !!!!\n");
	fi;

	return sequence;
end);


#############################################################################
##
#F  WriteExternalRunFSR( <output>, <lfsr>, <ist>, <elmvec> ) . .  write to file
##

InstallGlobalFunction( WriteExternalRunFSR, function(output, x, ist, elmvec)
local  i,j, sequence,  seq, tmp, treshold, B, m, num;

SetPrintFormattingStatus(output, false);
	 if IsFSR(x) and (not IsFILFUN(x)) then
	 		num := Length(elmvec);
	# check num
			treshold := Threshold(x);
			if num > treshold then
				Print("over the treshold, will only output the first ",
				treshold," elements of the sequence\n");
				num := treshold;
			fi;

			if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
			else m:= 1;
			fi;

				B := x!.basis;
	# print header, init state and seq_0
			# LOADING  (ie first step)
			seq := LoadFSR(x,ist); # the seq_0 element
			WriteAllFSR(output,  x, true);

			AppendTo(output,"elm");
			for i in [1..m] do			AppendTo(output,"   "); od;
			AppendTo(output, "\t\t[ ",Length(x)-1);
			for i in [1..m] do			AppendTo(output,"   "); od;
			AppendTo(output, " ,");
			for i in [2.. (Length(x)-1)*m] do AppendTo(output,"..."); 	od;
	 		AppendTo(output,", 0 ");
	 		for i in [1..m-1] do			AppendTo(output,"   "); od;
	 		AppendTo(output, "]");
			AppendTo(output, "  with taps  ",OutputTap(x),"\n");


			AppendTo(output,"   ");
			for i in [1..m] do			AppendTo(output,"   "); od;
			if not x!.sym then
				AppendTo(output, (IntVecFFExt(B,x!.state)));
			else
				AppendTo(output, x!.state);  		# NOT reversed !!!!
			fi;
			if Length(OutputTap(x))=1 then
				if not x!.sym then	AppendTo(output,"\t\t",  IntFFExt(B,seq) , "\n");
				else 								AppendTo(output,"\t\t",  seq , "\n");
				fi;
			else
				if not x!.sym then	AppendTo(output,"\t\t",  IntVecFFExt(B,seq)  , "\n");
				else 								AppendTo(output,"\t\t",  seq , "\n");
				fi;
			fi;
			sequence := [];
			Add(sequence, seq); #always append at the end so that seq0 will be first
			# RUNNING (ie all other steps)
			for i in [1.. num] do
				seq := StepFSR(x, elmvec[i]);
				Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
				if not x!.sym then
				AppendTo(output,IntFFExt(B,elmvec[i]),"\t\t",(IntVecFFExt(B,x!.state)));
				else
				AppendTo(output,elmvec[i],"\t\t",x!.state);
				fi;
				if Length(OutputTap(x))=1 then
					if not x!.sym then	AppendTo(output,"\t\t",  IntFFExt(B,seq) , "\n");
					else 								AppendTo(output,"\t\t",  seq , "\n");
					fi;
				else
					if not x!.sym then	AppendTo(output,"\t\t",  IntVecFFExt(B,seq)  , "\n");
					else 								AppendTo(output,"\t\t",  seq , "\n");
					fi;
				fi;

			od;
		# now append the whole sequence(s)
		WriteSequenceFSR(output, x, sequence);
	  else 	Error("IsFSR false or  IsFILFUN true  !!!!\n");
		fi;
	return sequence;
end);


InstallGlobalFunction( WriteTEXRunFSR, function(output, x,ist, num, strGen, gen)
local  i,j, sequence,  seq,  tmp, state, outtap, treshold, B;

SetPrintFormattingStatus(output, false);
	 if IsFSR(x) and not x!.sym and (not IsFILFUN(x)) then
	# check num
			treshold := Threshold(x);
			if num > treshold then
				Print("over the treshold, will only output the first ",
				treshold," elements of the sequence\n");
				num := treshold;
			fi;

			B := x!.basis;
	# starte table
		AppendTo(output,  "{\\footnotesize\n \\begin{table}[h]\n	\\begin{center}");
		AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
		AppendTo(output,  "\\begin{tabular}{|c|");
		for i in [1.. Length(x)] do
			AppendTo(output,  "c");
		od;
		AppendTo(output,  "|c");
		for i in [2.. Length(OutputTap(x))] do
			AppendTo(output,  "c");
		od;
		AppendTo(output, "|} \n\\hline\n");
		AppendTo(output, "step&\\multicolumn{",Length(x),"}{c|}{state }");
		AppendTo(output, "&\\multicolumn{",Length(OutputTap(x)),"}{c|}{sequence}");
		AppendTo(output, "\\\\\n\\cline{2-",Length(OutputTap(x))+Length(x)+1,"}\n");
		AppendTo(output,  "num");
		for i in [1.. Length(x)] do
			AppendTo(output,  "&\\,$\\mathcal{S}_{",Length(x)-i,"}$\\,");
		od;
		for i in [1.. Length(OutputTap(x))] do
			AppendTo(output,  "&\\,$\\mathcal{S}_{",OutputTap(x)[i],"}$\\,");
		od;
		AppendTo(output,  " \\\\\n");
		AppendTo(output,  "\\hline\\hline\n");
	# LOADING  (ie first step)
		seq := LoadFSR(x,ist); # the seq_0 element
		state :=  x!.state ;
		sequence := [];
		Add(sequence, seq);
		AppendTo(output, "0");
		for i in [1.. Length(x)] do
			AppendTo(output,  "&",VecToString(B, state[i]));
		od;

		if Length(OutputTap(x))=1 then
			outtap:=VecToString(B, seq);
			AppendTo(output,  "&",outtap);
		else
			for i in [1.. Length(OutputTap(x))] do
					AppendTo(output,  "&",VecToString(B, seq[i]));
			od;
		fi;
		AppendTo(output,  " \\\\\n");

	# RUNNING (ie all other steps)
		for j in [1.. num-1] do #NOTE: inconsistent!!! should change num-1 --> num 
			seq := StepFSR(x);
			Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
			state :=  x!.state ;
			AppendTo(output, j);
			for i in [1.. Length(x)] do
				AppendTo(output,  "&",VecToString(B, state[i]));
			od;
			if Length(OutputTap(x))=1 then
				outtap:=VecToString(B,seq);
				AppendTo(output,  "&",outtap);
			else
				for i in [1.. Length(OutputTap(x))] do
					AppendTo(output,  "&",VecToString(B, seq[i]));
				od;
			fi;
			AppendTo(output,  " \\\\\n");
		od;
		# end table
		AppendTo(output,  "\\hline\n");
		AppendTo(output,  "\\end{tabular}}\n");

		if IsLFSR(x) then
				AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback ");
	  		WriteTEXLFSRPolyByGenerator(output,  UnderlyingField(x),
																									FeedbackPoly(x), strGen, gen);
				AppendTo(output,  " over ");
				WriteTEXFF(output, UnderlyingField(x));
		elif IsNLFSR(x) then
				AppendTo(output,  "\\caption{{\\footnotesize NLFSR with feedback ");
				WriteTEXMultivarFFPolyByGenerator(output, UnderlyingField(x),
				 													FeedbackVec(x), MonomialList(x), strGen, gen);
		 		AppendTo(output, " over ");
		 		WriteTEXFF(output, UnderlyingField(x));
	 	fi;
		if not IsPrimeField(UnderlyingField(x)) then
	  	AppendTo(output,  " with basis ");
	  	WriteTEXBasisByGenerator(output,  UnderlyingField(x), B, strGen, gen);
WriteTEXGeneratorWRTDefiningPolynomial(output, UnderlyingField(x), strGen, gen);
		fi;
	  AppendTo(output,  ".}}\\label{LABEL}");
	 	AppendTo(output,  "\\end{center}\n\\end{table}\n}");
		AppendTo(output,  "\n\n\\noindent ");
		WriteTEXSequenceFSR(output, x, sequence);
		else 	Error("IsFSR false  or ISFILFUN true or symbolic !!!!\n");
		fi;
	return sequence;
end);


InstallGlobalFunction( WriteTEXtableElmByGenerator,
 function(output, elm, strGen, gen)
local exp;
			if IsZero(elm) then		AppendTo(output,  "&\\, 0\\,");
			elif IsOne(elm) then	AppendTo(output,  "&\\, 1\\,");
			else
				 exp := LogFFE(elm,gen);
				 if exp = 1 then
						 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
				 else
						AppendTo(output,  "&\\, $\\",strGen,"^{",exp,"}$\\,");
				 fi;
			fi;
	return;
end);

InstallGlobalFunction( WriteTEXRunFSRByGenerator,
 function(output, x,ist, num, strGen, gen)

local  i,j, sequence, seq, tmp, state, outtap, treshold, B, exp, elm, genvec;
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) and not IsFILFUN(x) and not x!.sym then
						# check num
			treshold := Threshold(x);
			if num > treshold then
				Print("over the treshold, will only output the first ");
				Print(treshold," elements of the sequence\n");
				num := treshold;
			fi;

			B := x!.basis;
						# starte table
			AppendTo(output,  "{\\footnotesize\n \\begin{table}[h!]\n	");
			AppendTo(output,  "\\begin{center}");
			AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
			AppendTo(output,  "\\begin{tabular}{|c|");
			for i in [1.. Length(x)] do AppendTo(output,  "c"); od;
			AppendTo(output,  "|c");
			for i in [2.. Length(OutputTap(x))] do AppendTo(output,  "c");  od;
					AppendTo(output, "|} \n\\hline\n");
					AppendTo(output, "step&\\multicolumn{",Length(x),"}{c|}{state }");
					AppendTo(output, "&\\multicolumn{",Length(OutputTap(x)));
					AppendTo(output, "}{c|}{sequence}\\\\\n");
					AppendTo(output, "\\cline{2-",Length(OutputTap(x))+Length(x)+1,"}\n");
					AppendTo(output,  "num");
					for i in [1.. Length(x)] do
						AppendTo(output,  "&\\,$\\mathcal{S}_{",Length(x)-i,"}$\\,");
					od;
					for i in [1.. Length(OutputTap(x))] do
						AppendTo(output,  "&\\,$\\mathcal{S}_{",OutputTap(x)[i],"}$\\,");
					od;
					AppendTo(output,  " \\\\\n\\hline\\hline\n");
						# LOADING  (ie first step)
					seq := LoadFSR(x,ist); # the seq_0 element
					state :=  x!.state ;
					sequence := [];
					Add(sequence, seq);
					AppendTo(output, "0");
					for i in [1.. Length(x)] do
						elm := state[i];
						WriteTEXtableElmByGenerator(output, elm, strGen, gen);
					od;

					if Length(OutputTap(x))=1 then
							elm := seq;
						  WriteTEXtableElmByGenerator(output, elm, strGen, gen);
					else
						for i in [1.. Length(OutputTap(x))] do
								elm := seq[i];
								WriteTEXtableElmByGenerator(output, elm, strGen, gen);
						od;
					fi;
					AppendTo(output,  " \\\\\n");
						# RUNNING (ie all other steps)
					for j in [1.. num-1] do
							seq := StepFSR(x);
							Add(sequence, seq);
							#append at the end of the list: seq_0,seq_1,seq_2, ...

							state :=  x!.state ;
							AppendTo(output, j);
							for i in [1.. Length(x)] do
								elm := state[i];
								WriteTEXtableElmByGenerator(output, elm, strGen, gen);
							od;

							if Length(OutputTap(x))=1 then
									elm := seq;
									WriteTEXtableElmByGenerator(output, elm, strGen, gen);
							else
									for i in [1.. Length(OutputTap(x))] do
											elm := seq[i];
											WriteTEXtableElmByGenerator(output, elm, strGen, gen);
									od;
							fi;
							AppendTo(output,  " \\\\\n");
						od;
							# end table
							AppendTo(output,  "\\hline\n");
							AppendTo(output,  "\\end{tabular}}\n");
			if IsLFSR(x) then
					AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback ");
		  		WriteTEXLFSRPolyByGenerator(output,  UnderlyingField(x),
																					FeedbackPoly(x), strGen, gen);
					AppendTo(output,  " over ");
					WriteTEXFF(output, UnderlyingField(x));
			elif IsNLFSR(x) then
			 		AppendTo(output,  "\\caption{{\\footnotesize NLFSR with feedback ");
					WriteTEXMultivarFFPolyByGenerator(output, UnderlyingField(x),
															MultivarPoly(x), strGen, gen);
			 		AppendTo(output, " over ");
			 		WriteTEXFF(output, UnderlyingField(x));
		 	fi;
			if not IsPrimeField(UnderlyingField(x)) then
				AppendTo(output,  " where generator ");
				WriteTEXGeneratorWRTDefiningPolynomial(output,  UnderlyingField(x),
									strGen, gen);
			fi;
		  AppendTo(output,  ".}}\\label{LABEL}");
		 	AppendTo(output,  "\\end{center}\n\\end{table}\n}");
			AppendTo(output,  "\n\n\\noindent ");
			WriteTEXSequenceFSRByGenerator(output, x, sequence, strGen, gen);
			else 	Error("IsFSR false  or ISFILFUN true or symbolic !!!!\n");
			fi;
	return sequence;
end);


##  <C>WriteTEXExternalRunFSR</C> and <C>WriteTEXExternalRunFSRByGenerator</C> TO DO


Print("outfsr.gi OK,\t");
