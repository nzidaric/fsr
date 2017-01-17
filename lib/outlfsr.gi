
# PRIMARY METHOD FOR ALL PRACTICAL PURPOSES: because otherwise u need to handle the seq_0 elm urself 
# load with <ist> then call   RunLFSR( <lfsr>, num-1 )
#InstallMethod(RunLFSR, "run LFSR", [IsLFSR, IsPosInt, IsBool], function(x, num, pr)

#############################################################################
##
#
#F WriteAllLFSR( <output>, <lfsr> ) . . . . . . . . . . . . . . . . . . view a GF2 vector
##
InstallGlobalFunction( WriteAllLFSR, function(output, B, x)
local uf, tap, i;
	if (IsOutputStream( output )) then
		if IsBasis(B) then 
			if FieldPoly(x) = 1 then 
				uf := Concatenation("GF(",String(Characteristic(x)),")");
			else 
				uf := Concatenation("GF(",String(Characteristic(x)),"^",String(Degree(FieldPoly(x))),") defined by FieldPoly=",String(FieldPoly(x)));
			fi;

			if x!.numsteps=-1 then 
				AppendTo(output,"Empty LFSR over ",uf," given by CharPoly = ", CharPoly(x), "\n");
			else 	
				AppendTo(output,"LFSR over ",uf,"  given by CharPoly = ", CharPoly(x), "\n");
			fi;
			AppendTo(output,"with FFEs represented in basis =");
			AppendTo(output,B); # NOT reversed !!!!
			AppendTo(output,"with feedback coeff =");
			AppendTo(output,(VecToString(B, FeedbackVec(x)))); # NOT reversed !!!!
			AppendTo(output,"\nwith initial state  =");
			AppendTo(output,(VecToString(B, x!.init))); # NOT reversed !!!!
			AppendTo(output,"\nwith current state  =");
			AppendTo(output,(VecToString(B, x!.state)));# NOT reversed !!!!
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
	    Error("B is not a basis !!!! \n");
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

InstallGlobalFunction( WriteRunLFSR, function(output,B, x,ist, num)
local  i,j, sequence,  seq, tmp, treshold; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 

# check num
	treshold := Period(x) + Length(x); 
	if num > treshold then 
		Print("over the treshold, will only output the first ",treshold," elements of the sequence\n");
		num := treshold;
	fi;
		
if (IsOutputStream( output )) then
	if IsBasis(B) then 	
		if x!.numsteps=-1 then 
			AppendTo(output,"Empty LFSR given by CharPoly = ", CharPoly(x), "\n");
		else 	
		AppendTo(output,"LFSR given by CharPoly = ", CharPoly(x),"\n"); 
		AppendTo(output,"with FFEs represented in basis =");
		AppendTo(output,B); # NOT reversed !!!!
		AppendTo(output,"\n with initial state =",IntVecFFExt(B,x!.init),"\nwith current state =",IntVecFFExt(B,x!.state) ,"\n after  ",x!.numsteps," steps\n");
		fi;

		# HEADER 
			AppendTo(output,  "[ ",Length(x)-1,",");
			for i in [2.. Length(x)-1] do
				AppendTo(output, "...");
			od;
			AppendTo(output, ",0 ]");
			AppendTo(output,  "  with taps  ",OutputTap(x),"\n");	

		# LOADING  (ie first step)
		seq := LoadLFSR(x,ist); # the seq_0 element 	
		AppendTo(output, (IntVecFFExt(B,x!.state)) ); 
			if Length(OutputTap(x))=1 then AppendTo(output, "\t\t", IntFFExt(B,seq) , "\n");
			else  AppendTo(output, "\t\t",  IntVecFFExt(B,seq) , "\n");
			fi;			
		sequence := [];
		Add(sequence, seq); #always append at the end so that seq0 will be first

		# RUNNING (ie all other steps)
		for i in [1.. num-1] do 
	# for debugging 	
	# AppendTo(output,(IntVecFFExt(B,x!.state)) ,"\t\t * \t\t",(IntVecFFExt(B,FeedbackVec(x))), "\t\t = \t\t"); 	

			seq := StepLFSR(x);
			Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...

			AppendTo(output,(IntVecFFExt(B,x!.state))); 
			if Length(OutputTap(x))=1 then AppendTo(output,"\t\t", IntFFExt(B,seq) , "\n");
			else  AppendTo(output,"\t\t",  IntVecFFExt(B,seq) , "\n");
			fi;	
		od; 


	# now append the whole sequence(s)
		if Length(OutputTap(x))=1 then 
			AppendTo(output,"\nThe whole sequence:\n");	

			for i in [1.. Length(sequence)-1] do 
				tmp := sequence[i]; # outputs on step i
				 AppendTo(output, IntFFExt(B,tmp) , ", ");
			od;	
			tmp := sequence[Length(sequence)]; # last step
			AppendTo(output, IntFFExt(B,tmp) , "\n");

		else 

			AppendTo(output,"\nThe whole sequences:\n");	
			# must separate them for each tap position
			for j in [1..Length(OutputTap(x))] do 
				AppendTo(output,"seq from S_",OutputTap(x)[j],": ");
				for i in [1.. Length(sequence)-1] do 
					tmp := sequence[i]; # outputs on step i
					 AppendTo(output, IntFFExt(B, tmp[j]) , ", ");
				od;	
				tmp := sequence[Length(sequence)]; # last step
				AppendTo(output, IntFFExt(B, tmp[j]) , "\n");
			od;
		fi;
	  else 
	    Error("B is not a basis !!!! \n");
	  fi;
	
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);


InstallGlobalFunction( WriteRunLFSRTEX, function(output, B, x,ist, num)
local  i,j, sequence,  seq,  tmp, state, outtap, treshold; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 
#check num
	treshold := Period(x) + Length(x); 
	if num > treshold then 
		Print("over the treshold, will only output the first ",treshold," elements of the sequence\n");
		num := treshold;
	fi;
	
if (IsOutputStream( output )) then
	# starte table
		AppendTo(output,  "{\\footnotesize\n \\begin{table}[h]\n	\\begin{center}");
		AppendTo(output,  "{\\setlength{\\extrarowheight}{0.35em}\n");
		AppendTo(output,  "\\begin{tabular}{|c|");
		for i in [1.. Length(x)] do
			AppendTo(output,  "@{}c@{}");
		od; 
		AppendTo(output,  "|c");
		for i in [2.. Length(OutputTap(x))] do
			AppendTo(output,  "@{}c@{}");
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
		seq := LoadLFSR(x,ist); # the seq_0 element 	
		state := (IntVecFFExt(B, x!.state)) ;
		sequence := [];
		Add(sequence, seq);
		
		
		AppendTo(output, "0"); 
		for i in [1.. Length(x)] do
			AppendTo(output,  "&",state[i]);
		od;
		
		
		if Length(OutputTap(x))=1 then 
			outtap:=IntFFExt(B, seq);
			AppendTo(output,  "&",outtap);
		else  
			outtap := IntVecFFExt(B, seq);
			for i in [1.. Length(OutputTap(x))] do		
				AppendTo(output,  "&",outtap[i]);			
			od;	
		fi;
		AppendTo(output,  " \\\\\n");	
			
	# RUNNING (ie all other steps)
		for j in [1.. num-1] do 
			seq := StepLFSR(x);
			Add(sequence, seq); #append at the end of the list: seq_0,seq_1,seq_2, ...
	
			state := (IntVecFFExt(B, x!.state)) ;
			AppendTo(output, j); 
			for i in [1.. Length(x)] do
				AppendTo(output,  "&",state[i]);
			od;


			if Length(OutputTap(x))=1 then 
				outtap:=IntFFExt(B,seq);
				AppendTo(output,  "&",outtap);
			else  
				outtap := IntVecFFExt(B,seq);
				for i in [1.. Length(OutputTap(x))] do		
					AppendTo(output,  "&",outtap[i]);			
				od;	
			fi;
			AppendTo(output,  " \\\\\n");	
		od; 
				

	
	# end table 
	AppendTo(output,  "\\hline\n");	
	AppendTo(output,  "\\end{tabular}}\n");
	if Degree(FieldPoly(x))=1 then  AppendTo(output,  "\\captionof{table}{{\\footnotesize LFSR with feedback $",CharPoly(x),"$ over GF(",Characteristic(x),") !!!}}\\label{LABEL}");
	else AppendTo(output,  "\\captionof{table}{{\\footnotesize LFSR with feedback $",CharPoly(x),"$ over GF($",Characteristic(x),"^",Degree(FieldPoly(x)),"$) !!!}}\\label{LABEL}");
	fi;
	AppendTo(output,  "\\end{center}\n\\end{table}\n}");


	if Length(OutputTap(x))=1 then 
		AppendTo(output,"\nThe whole sequence:\\\\\n");	

		for i in [1.. Length(sequence)] do 
			tmp := sequence[i]; # outputs on step i
			 AppendTo(output, IntFFExt(B,tmp) );
		od;	
		AppendTo(output, "\\\\\n");
	
	else 



		AppendTo(output,"\nThe whole sequence(s):\\\\\n");	
		# must separate them for each tap position
		for j in [1..Length(OutputTap(x))] do 
			AppendTo(output,"seq from $\\mathcal{S}_{",OutputTap(x)[j],"}$: ");
			for i in [1.. Length(sequence)] do 
				tmp := sequence[i]; # outputs on step i
				 AppendTo(output, IntFFExt(B,tmp[j]) );
			od;	
			AppendTo(output,  " \\\\\n");	
		od;
	
	fi;

	
	else 
	Error("outputstream not valid !!!!\n");
	fi;
	
	return;
end);

# this is not working :( 
#InstallGlobalFunction( WriteRunLFSRTEX, function(output, x,ist)
#	WriteRunLFSRTEX(output, x,ist, infinity );
#	return;
#end);


Print("outlfsr.gi OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here