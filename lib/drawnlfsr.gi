
#############################################################################
##
##
#W  drawnlfsr.gi          FSR Package                  Nusa
##
##  Declaration file for the FSR drawing functions - using tikz
##








InstallGlobalFunction( TikzNComplex_NLFSR, function(output, x)
local  n, nzt, i, len, simple, complex, idx; 

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt] 
#only check the output stream here, others will be checked by individual function calls !!! 

if (IsOutputStream( output )) then
	if (IsLFSR(x)) then 
		n := Length(x);	
		#nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
		nzt := IdxNonzeroCoeffs(FeedbackVec(x)); #nonzerotaps
		simple := []; complex := [];
		len := Length(nzt);
		for i in [1..len-1] do # last tap doesnt count here
			idx := nzt[i];
			if FeedbackVec(x)[idx] = Z(2)^0 then Add(simple, idx);
			else Add(complex, idx);
			fi;
		od;
			
			
	#	Print(nzt);

			AppendTo(output,  "\\begin{center}\n\\begin{figure}[t]\n\\begin{tikzpicture}\n");
			AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");
			AppendTo(output,  "%the taps  with coefficient = 1\n");

		if Length(simple) > 1 then 
			AppendTo(output,  "\\foreach \\t in { ");
			for i in [1..Length(simple)-1] do # last tap doesnt count here
					 AppendTo(output,  simple[i], ","); 
			od;
				AppendTo(output,  simple[Length(simple)], "}{\n");	
		elif Length(simple) = 1 then
				AppendTo(output,  "\\foreach \\t in { ");
				AppendTo(output,  simple[1], "}{\n");		
		
		fi;
		
		if Length(simple) >= 1 then 		
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,2)--(\\x+1.5,3.4); %arrow up\n");
			AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$};\n \\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
		fi;
		
		if Length(complex) > 1 then 	
			AppendTo(output, "%the taps  with coefficient <> 1 \n \\foreach \\t in { ");
				for i in [1..Length(complex)-1] do # last tap doesnt count here
					 AppendTo(output,  complex[i], ","); 
				od;
				AppendTo(output, complex[Length(complex)], "}{\n");	
		elif Length(complex) = 1 then		
			AppendTo(output,  "%HERE 1\n\\foreach \\t in { ");
			AppendTo(output,  complex[1], "}{");		
		fi;		
		if Length(complex) >= 1 then	
			AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\t-1}; \n \\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$}; \n \\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n");
			AppendTo(output, " \\draw[->,thick](\\x+1.5,3.1)--(\\x+1.5,3.4);}\n");
		fi;
		
		if Length(complex) > 1 then 
			AppendTo(output, "%HERE 2\n\\foreach \\t in { ");
				for i in [1..Length(complex)-1] do # last tap doesnt count here
					 AppendTo(output,  complex[i], ","); 
				od;
				idx := nzt[len];
				if FeedbackVec(x)[idx] = Z(2)^0 then AppendTo(output, complex[Length(complex)], "}{\n");			
				else AppendTo(output, complex[Length(complex)], ", ",idx,"}{\n");	
				fi;
		elif Length(complex) = 1 then		
			AppendTo(output,  "%HERE 3\n\\foreach \\t in { ");
			
				idx := nzt[len];
				if FeedbackVec(x)[idx] = Z(2)^0 then AppendTo(output, complex[1], "}{\n");			
				else AppendTo(output, complex[1], ", ",idx,"}{\n");	
				fi;			
			
		fi;		
		
		if Length(complex) >= 1 then		
			AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\t-1}; \n \\pgfmathtruncatemacro{\\y}{\\n-\\t}; \n \\draw[->,thick](\\x+1.5,2)--(\\x+1.5,2.3); %arrow up\n");
			AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n }%HERE 4\n");		
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n ");
			idx := nzt[len];
			if FeedbackVec(x)[idx] = Z(2)^0 then 
				AppendTo(output, "\\draw[-,thick](\\x+1.5,0)--++(0,3.7)--++(-0.3,0); %arrow up\n");
			else 
				AppendTo(output, "\\draw[-,thick](\\x+1.5,3.1)--++(0,0.6)--++(-0.3,0); %arrow up \n");	
				AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\n-1}; \n \\pgfmathtruncatemacro{\\y}{0}; \n \\draw[->,thick](\\x+1.5,2)--(\\x+1.5,2.3); %arrow up\n");
				AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n %HERE 5\n");					
			fi;		
				
		
	if (Length(simple) + Length(complex) < Length(x) ) then 	
		AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");		
		
		for i in [1..n-1] do # last tap doesnt count here
			if not (\in(i, simple) or \in(i, complex)) then  AppendTo(output,  i, ","); fi;
		od;
			if  not (\in(i, simple) or \in(i, complex)) then  AppendTo(output,  n-1, "}{\n"); 
			else AppendTo(output,  "}{\n"); 
			fi;			
		
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
	fi;	
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1,0) -- ++(0,-2.5) -- ++(0.8,0);\n");
		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,0) rectangle (1,2);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ","); 
		od;		
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n"); 
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n \\caption{LFSR with feedback polynomial $f(x)=", FeedbackPoly(x),"$}\\label{LABEL}\n \\end{figure}\n \\end{center}\n");

	else 
	Error("not a COMPLEX  LFSR  !!!!\n");
	fi;
else 
Error("outputstream not valid !!!!\n");
fi;
	
	return;
end);


Print("drawnlfsr.gi OK,\t");
#E  outlfsr.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here