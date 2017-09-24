



















#############################################################################
##
#M  ViewObj( <nlfsr> ) . . . . . . . . . . . . . . . 
##
InstallMethod( ViewObj,    "for FSR",    true,    [ IsFSR ],    0,  function( x )
local uf; 
	uf := UnderlyingField(x);	
	if x!.numsteps=-1 then 
			if IsLFSR(x) then 	Print("< empty LFSR over ",uf," given by FeedbackPoly = ", FeedbackPoly(x), " >");
			else 	Print("< empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x), "> ");
			fi;
	else 	
			if IsLFSR(x) then  Print("< LFSR over ",uf,"  given by FeedbackPoly = ", FeedbackPoly(x), " >");
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
			if IsLFSR(x) then 	Print("empty LFSR over ",uf," given by FeedbackPoly = ", FeedbackPoly(x));
			else 	Print("empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x));
			fi;
	else 	

			B := x!.basis;	
			if IsLFSR(x) then  Print("LFSR over ",uf,"  given by FeedbackPoly = ", FeedbackPoly(x));
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
			if IsLFSR(x) then 	Print("empty LFSR over ",uf," given by FeedbackPoly = ", FeedbackPoly(x));
			else 	Print("empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x));
			fi;
	else 	
			if IsLFSR(x) then  Print("LFSR over ",uf,"  given by FeedbackPoly = ", FeedbackPoly(x));
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
InstallGlobalFunction( WriteAllFSR, function(output,  x, b)
local uf, tap, i, B;
	if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);	
	 if IsFSR(x) then 		
 			
 			uf := UnderlyingField(x);	


			if x!.numsteps=-1 then 
					if IsLFSR(x) then 	AppendTo(output,"empty LFSR over ",uf," given by FeedbackPoly = ", FeedbackPoly(x));
					else 	AppendTo(output,"empty NLFSR of length ",Length(x)," over ",uf,",\n  given by MultivarPoly = ", MultivarPoly(x));
					fi;
			else 	
					if IsLFSR(x) then AppendTo(output,"LFSR over ",uf,"  given by FeedbackPoly = ", FeedbackPoly(x));
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
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);


#############################################################################
##
#F  WriteSequenceFSR ( <output>, <lfsr>, <sequence> ) . . . . . . . . write elm to file
##
InstallGlobalFunction( WriteSequenceFSR, function(output, x, sequence)

local  i,j, tmp, B, m; 
		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 
		B := x!.basis;
		# now append the whole sequence(s)
			if Length(OutputTap(x))=1 then 
				AppendTo(output,"\nThe whole sequence:\n");	
	
				for i in [1.. Length(sequence)-1] do 
					tmp := sequence[i]; # outputs on step i
					 AppendTo(output, VecToString(B,tmp) , ", ");
				od;	
				tmp := sequence[Length(sequence)]; # last step
				AppendTo(output, VecToString(B,tmp) , "\n");
	
			else 
	
				AppendTo(output,"\nThe whole sequences:\n");	
				# must separate them for each tap position
				for j in [1..Length(OutputTap(x))] do 
					AppendTo(output,"seq from S_",OutputTap(x)[j],": ");
					for i in [1.. Length(sequence)-1] do 
						tmp := sequence[i]; # outputs on step i
						 AppendTo(output, VecToString(B, tmp[j]) , ", ");
					od;	
					tmp := sequence[Length(sequence)]; # last step
					AppendTo(output, VecToString(B, tmp[j]) , "\n");
				od;
			fi;
	
		else 
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);

#############################################################################
##
#F  WriteTBSequenceFSR ( <output>, <lfsr>, <sequence> ) . . . . . . . . write elm to file
##
InstallGlobalFunction( WriteTBSequenceFSR, function(output, x, sequence)

local  i,j, tmp, B, m; 
		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 
		B := x!.basis;
		# now append the whole sequence(s)
#			if Length(OutputTap(x))=1 then 
#
#				for i in [1.. Length(sequence)] do 
#					tmp := sequence[i]; # outputs on step i
#					 AppendTo(output, VecToString(B,tmp) , "\n");
#				od;	
	
#			else 
	

				# must separate them for each tap position

				
				for i in [1.. Length(sequence)] do 
						tmp := sequence[i]; # outputs on step i
						for j in [1..Length(OutputTap(x))] do 
							 AppendTo(output, VecToString(B, tmp[j]) , "\t ");
						od;	
						AppendTo(output, "\n");
				od;
#			fi;
	
		else 
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);

#############################################################################
##
#F  WriteTEXSequenceByGenerator( <output>, <lfsr>, <sequence> ) . . . . . . . . write elm to file
##
InstallGlobalFunction(WriteTEXSequenceByGenerator, function(output, x, sequence, strGen, gen)

local  i,j, tmp, elm, exp, m; 
		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 
	 	if IsString(strGen) then 
			if Order(gen)=Size(UnderlyingField(x))-1 then
						
				# now append the whole sequence(s)
					if Length(OutputTap(x))=1 then 
						AppendTo(output,"\nThe whole sequence:\n");	
			
						for i in [1.. Length(sequence)-1] do 
							 elm := sequence[i]; # outputs on step i

							if IsZero(elm) then 
								AppendTo(output,  "\\, 0\\,");
							elif IsOne(elm) then 
								AppendTo(output,  "\\, 1\\,");
							else 
								 exp := LogFFE(elm,gen);
								 if exp = 1 then 			 AppendTo(output,  "\\, $\\",strGen,"$\\,");
								 else 		AppendTo(output,  "\\, $\\",strGen,"^",exp,"$\\,");
								 fi;
							fi;										
							
						od;	
						elm := sequence[Length(sequence)]; # last step
							if IsZero(elm) then 
								AppendTo(output,  "\\, 0\\,");
							elif IsOne(elm) then 
								AppendTo(output,  "\\, 1\\,");
							else 
								 exp := LogFFE(elm,gen);
								 if exp = 1 then 			 AppendTo(output,  "\\, $\\",strGen,"$\\,");
								 else 		AppendTo(output,  "\\, $\\",strGen,"^",exp,"$\\,");
								 fi;
							fi;	
						AppendTo(output, "\n");
					else 
			
						AppendTo(output,"\nThe whole sequences:\n");	
						# must separate them for each tap position
						for j in [1..Length(OutputTap(x))] do 
							AppendTo(output,"seq from S_",OutputTap(x)[j],": ");
							for i in [1.. Length(sequence)-1] do 
								tmp := sequence[i]; # outputs on step i
								elm := tmp[j]; # outputs on step i
	
								if IsZero(elm) then 
									AppendTo(output,  "\\, 0\\,");
								elif IsOne(elm) then 
									AppendTo(output,  "\\, 1\\,");
								else 
									 exp := LogFFE(elm,gen);
									 if exp = 1 then 			 AppendTo(output,  "\\, $\\",strGen,"$\\,");
									 else 		AppendTo(output,  "\\, $\\",strGen,"^",exp,"$\\,");
									 fi;
								fi;						

			
							od;	
							tmp := sequence[Length(sequence)]; # last step
							elm := tmp[j]; # outputs on step i
								if IsZero(elm) then 
									AppendTo(output,  "\\, 0\\,");
								elif IsOne(elm) then 
									AppendTo(output,  "\\, 1\\,");
								else 
									 exp := LogFFE(elm,gen);
									 if exp = 1 then 			 AppendTo(output,  "\\, $\\",strGen,"$\\,");
									 else 		AppendTo(output,  "\\, $\\",strGen,"^",exp,"$\\,");
									 fi;
								fi;
						AppendTo(output, "\n");						
						od;

					fi;

				else 
				Error(gen," is not a generator of ",UnderlyingField(x),"!!!!\n");
				fi;
					


			else 
			Error(strGen," is not a string !!!!\n");
			fi;
					
		else 
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);


#############################################################################
##
#F  WriteRunLFSR( <output>, <lfsr>, <ist>, <numsteps> ) . . . . . . . . write elm to file
##

InstallGlobalFunction( WriteRunFSR, function(output, x, ist, num)
local  i,j, sequence,  seq, tmp, treshold, B, m; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 


		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 
 
	 
	 
	 
	# check num
			treshold := Threshold(x); 
			if num > treshold then 
				Print("over the treshold, will only output the first ",treshold," elements of the sequence\n");
				num := treshold;
			fi;
		
			if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
			else m:= 1;
			fi;		
			
				B := x!.basis;
	# load FSR 
			
	# print header, init state and seq_0
			# LOADING  (ie first step)
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
	
			AppendTo(output, (IntVecFFExt(B,x!.state)));  				# NOT reversed !!!! 
			if Length(OutputTap(x))=1 then 			AppendTo(output,"\t\t", IntFFExt(B,seq) , "\n");
			else  			AppendTo(output,"\t\t",  IntVecFFExt(B,seq) , "\n");
			fi;			
			
			
				
			sequence := [];
			
			Add(sequence, seq); #always append at the end so that seq0 will be first
	
			# RUNNING (ie all other steps)
			for i in [1.. num] do 
	
				seq := StepFSR(x);
				Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
	
				AppendTo(output,(IntVecFFExt(B,x!.state))); 
				if Length(OutputTap(x))=1 then AppendTo(output,"\t\t", IntFFExt(B,seq) , "\n");
				else  AppendTo(output,"\t\t",  IntVecFFExt(B,seq) , "\n");
				fi;	
			od; 
	
	
		# now append the whole sequence(s)
		WriteSequenceFSR(output, x, sequence);
	
		else 
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return sequence;
end);


#############################################################################
##
#F  WriteNonlinRunFSR( <output>, <lfsr>, <ist>, <elmvec> ) . . . . . . . . write elm to file
##

InstallGlobalFunction( WriteNonlinRunFSR, function(output, x, ist, elmvec)
local  i,j, sequence,  seq, tmp, treshold, B, m, num; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 


		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 
 
	 		num := Length(elmvec);	 
	 
	# check num
			treshold := Threshold(x); 
			if num > treshold then 
				Print("over the treshold, will only output the first ",treshold," elements of the sequence\n");
				num := treshold;
			fi;
		
			if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
			else m:= 1;
			fi;		
			
				B := x!.basis;
	# load FSR 
			
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
			AppendTo(output,"\t\t",(IntVecFFExt(B,x!.state))); 
	##		AppendTo(output,"\t\t", (IntVecFFExt(B,x!.state)));  				# NOT reversed !!!! 
			if Length(OutputTap(x))=1 then 			AppendTo(output,"\t\t", IntFFExt(B,seq) , "\n");
			else  			AppendTo(output,"\t\t",  IntVecFFExt(B,seq) , "\n");
			fi;			
			
			
				
			sequence := [];
			
			Add(sequence, seq); #always append at the end so that seq0 will be first
	
			# RUNNING (ie all other steps)
			for i in [1.. num] do 
	
				seq := StepFSR(x, elmvec[i]);
				Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
	
				AppendTo(output,IntFFExt(B,elmvec[i]),"\t\t",(IntVecFFExt(B,x!.state))); 
				if Length(OutputTap(x))=1 then AppendTo(output,"\t\t", IntFFExt(B,seq) , "\n");
				else  AppendTo(output,"\t\t",  IntVecFFExt(B,seq) , "\n");
				fi;	
			od; 
	
	
		# now append the whole sequence(s)
		WriteSequenceFSR(output, x, sequence);
	
		else 
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return sequence;
end);




InstallGlobalFunction( WriteTEXRunFSR, function(output, x,ist, num)
local  i,j, sequence,  seq,  tmp, state, outtap, treshold, m, B; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 
		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 

	# check num
			treshold := Threshold(x); 
			if num > treshold then 
				Print("over the treshold, will only output the first ",treshold," elements of the sequence\n");
				num := treshold;
			fi;
		
			if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
			else m:= 1;
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
		AppendTo(output,  "|} \n\\hline\n");
		AppendTo(output,  "step&\\multicolumn{",Length(x),"}{c|}{state }&\\multicolumn{",Length(OutputTap(x)),"}{c|}{sequence}\\\\\n");
		AppendTo(output,  "\\cline{2-",Length(OutputTap(x))+Length(x)+1,"}\n");		
		
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
		for j in [1.. num-1] do 
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
		if m=1 then  AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",FeedbackPoly(x),"$ over GF(",Characteristic(x),") !!!}}\\label{LABEL}");
		else AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",FeedbackPoly(x),"$ over GF($",Characteristic(x),"^",m,"$) !!!}}\\label{LABEL}");
		fi;
	elif IsNLFSR(x) then
		if m=1 then  AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",MultivarPoly(x),"$ over GF(",Characteristic(x),") !!!}}\\label{LABEL}");
		else AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",MultivarPoly(x),"$ over GF($",Characteristic(x),"^",m,"$) !!!}}\\label{LABEL}");
		fi;	
	fi;
	
	AppendTo(output,  "\\end{center}\n\\end{table}\n}");


	WriteSequenceFSR(output, x, sequence);

	
		else 
		Error("IsFSR(",x,")=false !!!!\n");
		fi;
	
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return sequence;
end);



InstallGlobalFunction( WriteTEXRunFSRByGenerator, function(output, x,ist, num, strGen, gen)
local  i,j, sequence,  seq,  tmp, state, outtap, treshold, m, B,  exp, elm; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 
		
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsFSR(x) then 
		if IsString(strGen) then
				
				if Order(gen)=Size(UnderlyingField(x))-1 then		
				#		gen := GeneratorOfUnderlyingField(UnderlyingField(x));
						# check num
								treshold := Threshold(x); 
								if num > treshold then 
									Print("over the treshold, will only output the first ",treshold," elements of the sequence\n");
									num := treshold;
								fi;
							
								if IsPolynomial(FieldPoly(x)) then m:= Degree(FieldPoly(x));
								else m:= 1;
								fi;		
								
									B := x!.basis;
					
						# starte table
							AppendTo(output,  "{\\footnotesize\n \\begin{table}[h!]\n	\\begin{center}");
							AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
							AppendTo(output,  "\\begin{tabular}{|c|");
							for i in [1.. Length(x)] do
								AppendTo(output,  "c");
							od; 
							AppendTo(output,  "|c");
							for i in [2.. Length(OutputTap(x))] do
								AppendTo(output,  "c");
							od; 	
							AppendTo(output,  "|} \n\\hline\n");
							AppendTo(output,  "step&\\multicolumn{",Length(x),"}{c|}{state }&\\multicolumn{",Length(OutputTap(x)),"}{c|}{sequence}\\\\\n");
							AppendTo(output,  "\\cline{2-",Length(OutputTap(x))+Length(x)+1,"}\n");		
							
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
								elm := state[i];
								if IsZero(elm) then 
									AppendTo(output,  "&\\, 0\\,");
								elif IsOne(elm) then 
									AppendTo(output,  "&\\, 1\\,");
								else 
									 exp := LogFFE(elm,gen);
									 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
									 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
									 fi;
								fi;
							od;
							
							
							if Length(OutputTap(x))=1 then 
									elm := seq;
									if IsZero(elm) then 
										AppendTo(output,  "&\\, 0\\,");
									elif IsOne(elm) then 
										AppendTo(output,  "&\\, 1\\,");
									else 
										 exp := LogFFE(elm,gen);
										 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
										 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
										 fi;
									fi;							
							else  
								for i in [1.. Length(OutputTap(x))] do	
										elm := seq[i];
										if IsZero(elm) then 
											AppendTo(output,  "&\\, 0\\,");
										elif IsOne(elm) then 
											AppendTo(output,  "&\\, 1\\,");
										else 
											 exp := LogFFE(elm,gen);
											 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
											 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
											 fi;
										fi;						
								od;	
							fi;
							AppendTo(output,  " \\\\\n");	
								
						# RUNNING (ie all other steps)
							for j in [1.. num-1] do 
								seq := StepFSR(x);
								Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
						
								state :=  x!.state ;
								AppendTo(output, j); 
								for i in [1.. Length(x)] do
									elm := state[i];
	
									if IsZero(elm) then 
										AppendTo(output,  "&\\, 0\\,");
									elif IsOne(elm) then 
										AppendTo(output,  "&\\, 1\\,");
									else 
										 exp := LogFFE(elm,gen);
										 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
										 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
										 fi;
									fi;
								od;
					
								if Length(OutputTap(x))=1 then 
										elm := seq;
										if IsZero(elm) then 
											AppendTo(output,  "&\\, 0\\,");
										elif IsOne(elm) then 
											AppendTo(output,  "&\\, 1\\,");
										else 
											 exp := LogFFE(elm,gen);
											 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
											 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
											 fi;
										fi;					
								else  
									for i in [1.. Length(OutputTap(x))] do	
											elm := seq[i];
											if IsZero(elm) then 
												AppendTo(output,  "&\\, 0\\,");
											elif IsOne(elm) then 
												AppendTo(output,  "&\\, 1\\,");
											else 
												 exp := LogFFE(elm,gen);
												 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
												 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
												 fi;
											fi;							
									od;	
								fi;
								AppendTo(output,  " \\\\\n");
							od; 
									
		
			
							# end table 
							AppendTo(output,  "\\hline\n");	
							AppendTo(output,  "\\end{tabular}}\n");
							if IsLFSR(x) then 
								if m=1 then  AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",FeedbackPoly(x),"$ over GF(",Characteristic(x),") using generator $\\",strGen,"$ !!!}}\\label{LABEL}");
								else AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",FeedbackPoly(x),"$ over GF($",Characteristic(x),"^",m,"$) using generator $\\",strGen,"$ !!!}}\\label{LABEL}");
								fi;
							elif IsNLFSR(x) then
								if m=1 then  AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",MultivarPoly(x),"$ over GF(",Characteristic(x),") using generator $\\",strGen,"$ !!!}}\\label{LABEL}");
								else AppendTo(output,  "\\caption{{\\footnotesize LFSR with feedback $",MultivarPoly(x),"$ over GF($",Characteristic(x),"^",m,"$) using generator $\\",strGen,"$ !!!}}\\label{LABEL}");
								fi;	
							fi;
							
							AppendTo(output,  "\\end{center}\n\\end{table}\n}");
						
						
							WriteTEXSequenceByGenerator(output, x, sequence, strGen, gen);
					else 
					Error(gen," is not a generator of ",UnderlyingField(x),"!!!!\n");
					fi;
											
						
						
				else 
				Error(strGen," is not a string !!!!\n");
				fi;
				
		
			else 
			Error("IsFSR(",x,")=false !!!!\n");
			fi;
		
		else 
		Error("outputstream not valid !!!!\n");
		fi;
	
	return sequence;
end);



InstallGlobalFunction(WriteTEXElementTableByGenerator, function(output, F, B, strGen, gen)
local  i,j, elms,  tmp,  m, divs, eb, exp, elm, roots; 

	
if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	 if IsField(F) and IsFinite(F) then 
		 if IsBasis(B) then 
			if IsString(strGen) then			
				if Order(gen)=Size(F)-1 then		

							m:= DegreeOverPrimeField(F);
							divs := DivisorsInt(m);
							if m>1 and (not  m > Length(B)) and \in(Length(B),divs) then # basis ok for field
									
								 
								 elms := Elements(F);
					
									
										# starte table
											AppendTo(output,  "{\\footnotesize\n \\begin{table}[h!]\n	\\begin{center}");
											AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
											AppendTo(output,  "\\begin{tabular}{|c|");
											for i in [1.. Length(B)] do
												AppendTo(output,  "c");
											od; 
											AppendTo(output,  "|c");
	
											AppendTo(output,  "|} \n\\hline\n");
											AppendTo(output,  "elm&\\multicolumn{",Length(B),"}{c|}{given basis B}& \\\\\n");
											AppendTo(output,  "\\cline{2-",+Length(B)+1,"}\n");		
											
											AppendTo(output,  "order");
											for i in [1.. Length(B)] do
												AppendTo(output,  "&\\,$\\beta_{",i-1,"}$\\,");
											od;

											AppendTo(output,  "&\\,$\\",strGen,"^i$\\,");

											AppendTo(output,  " \\\\\n");	
											AppendTo(output,  "\\hline\\hline\n");			
											
									

											for i in [1.. Length(elms)] do 
											
												elm := elms[i];
												if IsZero(elm) then 
													AppendTo(output, "-"); 
												else 
													AppendTo(output, Order(elm)); 
												fi;											
											
												eb := IntFFExt(B,elm);
												for j in [1.. Length(B)] do
														AppendTo(output,  "&\\, ",VecToString(eb[j]),"\\,");												
												od;	
												
												
												
												
												if IsZero(elm) then 
													AppendTo(output,  "&\\, 0\\,");
												elif IsOne(elm) then 
													AppendTo(output,  "&\\, 1\\,");
												else 
													 exp := LogFFE(elm,gen);
													 if exp = 1 then 			 AppendTo(output,  "&\\, $\\",strGen,"$\\,");
													 else 		AppendTo(output,  "&\\, $\\",strGen,"^",exp,"$\\,");
													 fi;
												fi;
											

												AppendTo(output,  " \\\\\n");	
												
											od;	
						
							
											# end table 
											AppendTo(output,  "\\hline\n");	
											AppendTo(output,  "\\end{tabular}}\n");
												
											 AppendTo(output,  "\\caption{{\\footnotesize Element table for GF($",Characteristic(F),"^",m,"$) with defining polynomial $",DefiningPolynomial(F), "$, basis B and generator $\\",strGen,"$ !!!}}\\label{LABEL}");
											
				
											
											AppendTo(output,  "\\end{center}\n\\end{table}\n}");
										
										   AppendTo(output,  "\n\n \n\nBasis B = [$\\beta_i$] = $",BasisVectors(B),"$ = [");

												for j in [1.. Length(B)] do
												   elm := BasisVectors(B)[j];
													if IsZero(elm) then 
														AppendTo(output,  "\\, 0\\,");
													elif IsOne(elm) then 
														AppendTo(output,  "\\, 1\\,");
													else 
														 exp := LogFFE(elm,gen);
														 if exp = 1 then 			 AppendTo(output,  "\\, $\\",strGen,"$\\,");
														 else 		AppendTo(output,  "\\, $\\",strGen,"^",exp,"$\\,");
														 fi;
													fi;													
													
										
												od;									   
										   
										   AppendTo(output,  " ]\n");	
										   
										   AppendTo(output,  "\n\n \n\nIs generator ",strGen," a root of defining polynomial $",DefiningPolynomial(F),"$:\t ");
										   roots := RootsOfPolynomial(F,DefiningPolynomial(F)); j := 0;
										   for i in [1.. Length(roots)] do 
										   	if gen=roots[i] then 
										   			AppendTo(output,  "YES, its the root number ",i);
										   			j := j + 1;										   			
								   		   fi;
								   		od;
								   		if IsZero(j) then  AppendTo(output,  "NO, the roots are :$",roots,"$");  
								   		fi;
										   AppendTo(output,  "\\\\ \n");	
										   
											
							else 
							Error("basis does not match the field!\n" );
							fi;

						else 
						Error(gen," is not a generator of ",F,"!!!!\n");
						fi;
													
					else 
					Error(strGen," is not a string !!!!\n");
					fi;
				else 
				Error(B,"is not a basis !!!!\n");
				fi;			
				
			else 
			Error(F,"is not a finite field !!!!\n");
			fi;
		
		else 
		Error("outputstream not valid !!!!\n");
		fi;
	
	return ;
end);




Print("outfsr.gi OK,\t");

