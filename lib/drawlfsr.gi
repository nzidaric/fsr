
#############################################################################
##
##
#W  drawlfsr.gi          FSR Package                  Nusa
##
##  Declaration file for the FSR drawing functions - using tikz
##




InstallGlobalFunction( TikzWSimple_LFSR, function(output, x, strGen, gen)
local  n, nzt, i, len;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!


SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
	#	Print(nzt);

			AppendTo(output,  "\\begin{center}\n\\begin{figure}[t]\n\\begin{tikzpicture}\n");
			AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");
			AppendTo(output,  "%the taps  with coefficient = 1\n");

		if len > 2 then
			AppendTo(output,  "\\foreach \\t in { ");
			for i in [1..len-2] do # last tap doesnt count here
				AppendTo(output,  nzt[i], ",");
			od;
				AppendTo(output,  nzt[Length(nzt)-1], "}{\n");
		elif len = 2 then # last tap doesnt count here
				AppendTo(output,  "\\foreach \\t in { ");
				AppendTo(output,  nzt[1], "}{\n");

		fi;

		if len >= 2 then
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,2)--(\\x+1.5,3.4); %arrow up\n");
			AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$};\n \\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n \\draw[-,thick](\\x+1.5,2)--++(0,1.7)--++(-0.3,0); %arrow up\n");
		AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");

		for i in [1..n-1] do # last tap doesnt count here
			if (not \in(i, nzt)) then  AppendTo(output,  i, ","); fi;
		od;
			if (not \in(i, nzt)) then  AppendTo(output,  n-1, "}{\n");
			else AppendTo(output,  "}{\n");
			fi;

		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1,0) -- ++(0,-2.5) -- ++(0.8,0);\n");
		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,0) rectangle (1,2);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n ");

		AppendTo(output,  "\\caption{{\\footnotesize ");
		AppendTo(output,  " LFSR with feedback ");
		WriteTEXLFSRPolyByGenerator(output,  UnderlyingField(x), FeedbackPoly(x), strGen, gen);
		AppendTo(output,  " over ");
		WriteTEXFF(output, UnderlyingField(x));
		AppendTo(output,  " with generator ");
		WriteTEXGeneratorWRTDefiningPolynomial(output,  UnderlyingField(x),	strGen, gen);
	  AppendTo(output,  ".}}\\label{LABEL}\n");
	  AppendTo(output, "\\end{figure}\n \\end{center}\n");

	else
	Error("not a SIMPLE  LFSR  !!!!\n");
	fi;


	return;
end);





InstallGlobalFunction( TikzNSimple_LFSR, function(output, x)
local  n, nzt, i, len;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
	#	Print(nzt);

			AppendTo(output,  "\\begin{center}\n\\begin{figure}[t]\n\\begin{tikzpicture}\n");
			AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");
			AppendTo(output,  "%the taps  with coefficient = 1\n");

		if len > 2 then
			AppendTo(output,  "\\foreach \\t in { ");
			for i in [1..len-2] do # last tap doesnt count here
				AppendTo(output,  nzt[i], ",");
			od;
				AppendTo(output,  nzt[Length(nzt)-1], "}{\n");
		elif len = 2 then # last tap doesnt count here
				AppendTo(output,  "\\foreach \\t in { ");
				AppendTo(output,  nzt[1], "}{\n");

		fi;

		if len >= 2 then
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,3.4); %arrow up\n");
			AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$};\n \\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n \\draw[-,thick](\\x+1.5,1.5)--++(0,2.2)--++(-0.3,0); %arrow up\n");
		AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");

		for i in [1..n-1] do # last tap doesnt count here
			if (not \in(i, nzt)) then  AppendTo(output,  i, ","); fi;
		od;
			if (not \in(i, nzt)) then  AppendTo(output,  n-1, "}{\n");
			else AppendTo(output,  "}{\n");
			fi;

		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1,0) -- ++(0,-2.7) -- ++(0.8,0);\n");
		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,1.5) rectangle (2,0.5);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0.5)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n ");

		AppendTo(output,  "\\caption{{\\footnotesize ");
		AppendTo(output,  " LFSR with feedback ");
		WriteTEXLFSRPolyByGenerator(output,  UnderlyingField(x), FeedbackPoly(x), strGen, gen);

	  AppendTo(output,  ".}}\\label{LABEL}\n");
	  AppendTo(output, "\\end{figure}\n \\end{center}\n");



	else
	Error("not a SIMPLE  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);



InstallGlobalFunction( TikzWSimple_nLFSR, function(output, x)
local  n, nzt, i, len;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
	#	Print(nzt);

			AppendTo(output,  "\\begin{center}\n\\begin{figure}[t]\n\\begin{tikzpicture}\n");
			AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");
			AppendTo(output,  "%the taps  with coefficient = 1\n");

		if len > 2 then
			AppendTo(output,  "\\foreach \\t in { ");
			for i in [1..len-2] do # last tap doesnt count here
				AppendTo(output,  nzt[i], ",");
			od;
				AppendTo(output,  nzt[Length(nzt)-1], "}{\n");
		elif len = 2 then # last tap doesnt count here
				AppendTo(output,  "\\foreach \\t in { ");
				AppendTo(output,  nzt[1], "}{\n");

		fi;

		if len >= 2 then
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,2)--(\\x+1.5,3.4); %arrow up\n");
			AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$};\n \\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n \\draw[-,thick](\\x+1.5,2)--++(0,1.7)--++(-0.3,0); %arrow up\n");
		AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");

		for i in [1..n-1] do # last tap doesnt count here
			if (not \in(i, nzt)) then  AppendTo(output,  i, ","); fi;
		od;
			if (not \in(i, nzt)) then  AppendTo(output,  n-1, "}{\n");
			else AppendTo(output,  "}{\n");
			fi;

		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1.2,0) -- ++(0,-2.4);\n");
		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n \\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  \\draw (-1.2,1) node {$e$};)\n");

		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,0) rectangle (1,2);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n \\caption{LFSR with feedback polynomial $", FeedbackPoly(x),"$ and additional ``nonlinear'' input}\\label{LABEL}\n \\end{figure}\n \\end{center}\n");

	else
	Error("not a SIMPLE  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);




InstallGlobalFunction( TikzNSimple_nLFSR, function(output, x)
local  n, nzt, i, len;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
	#	Print(nzt);

			AppendTo(output,  "\\begin{center}\n\\begin{figure}[t]\n\\begin{tikzpicture}\n");
			AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");
			AppendTo(output,  "%the taps  with coefficient = 1\n");

		if len > 2 then
			AppendTo(output,  "\\foreach \\t in { ");
			for i in [1..len-2] do # last tap doesnt count here
				AppendTo(output,  nzt[i], ",");
			od;
				AppendTo(output,  nzt[Length(nzt)-1], "}{\n");
		elif len = 2 then # last tap doesnt count here
				AppendTo(output,  "\\foreach \\t in { ");
				AppendTo(output,  nzt[1], "}{\n");

		fi;

		if len >= 2 then
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,3.4); %arrow up\n");
			AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$};\n \\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n \\draw[-,thick](\\x+1.5,1.5)--++(0,2.2)--++(-0.3,0); %arrow up\n");
		AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");

		for i in [1..n-1] do # last tap doesnt count here
			if (not \in(i, nzt)) then  AppendTo(output,  i, ","); fi;
		od;
			if (not \in(i, nzt)) then  AppendTo(output,  n-1, "}{\n");
			else AppendTo(output,  "}{\n");
			fi;

		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1.2,0) -- ++(0,-2.4);\n");
		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n \\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  \\draw (-1.2,1) node {$e$};)\n");

		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,1.5) rectangle (2,0.5);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0.5)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n \\caption{LFSR with feedback polynomial $", FeedbackPoly(x),"$ and additional ``nonlinear'' input}\\label{LABEL}\n \\end{figure}\n \\end{center}\n");

	else
	Error("not a SIMPLE  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);


InstallGlobalFunction( TikzWComplex_LFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, simple, complex, idx, fbv;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
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



		AppendTo(output, "\\end{tikzpicture}\n");

		AppendTo(output,  "\\caption{{\\footnotesize ");
		AppendTo(output,  " LFSR with feedback ");
		WriteTEXLFSRPolyByGenerator(output,  UnderlyingField(x), FeedbackPoly(x), strGen, gen);
		AppendTo(output,  " over ");
		WriteTEXFF(output, UnderlyingField(x));
		AppendTo(output,  " with generator ");
		WriteTEXGeneratorWRTDefiningPolynomial(output,  UnderlyingField(x),	strGen, gen);


		AppendTo(output, " and constant(s) ");
		fbv := FeedbackVec(x);
		for i in [1.. Length(fbv)] do
			if fbv[i] <> Zero(UnderlyingField(x)) and fbv[i] <> One(UnderlyingField(x)) then
							AppendTo(output, "$\\omega_{",Length(fbv)-i,"}=\\,$");
							WriteTEXFFEByGeneratorNC(output, fbv[i], strGen, gen);
							if i < Length(fbv) then
							AppendTo(output, ", ");
							fi;
			fi;
		od;

		AppendTo(output,  ".}}\\label{LABEL}\n");
	  AppendTo(output, "\\end{figure}\n \\end{center}\n");

	else
	Error("not a COMPLEX  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);



InstallGlobalFunction( TikzNComplex_LFSR, function(output, x)
local  n, nzt, i, len, simple, complex, idx;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
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
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,3.4); %arrow up\n");
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
			AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\t-1}; \n \\pgfmathtruncatemacro{\\y}{\\n-\\t}; \n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,2.3); %arrow up\n");
			AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n }%HERE 4\n");
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n ");
			idx := nzt[len];
			if FeedbackVec(x)[idx] = Z(2)^0 then
				AppendTo(output, "\\draw[-,thick](\\x+1.5,1.5)--++(0,3.7)--++(-0.3,0); %arrow up\n");
			else
				AppendTo(output, "\\draw[-,thick](\\x+1.5,3.1)--++(0,0.6)--++(-0.3,0); %arrow up \n");
				AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\n-1}; \n \\pgfmathtruncatemacro{\\y}{0}; \n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,2.3); %arrow up\n");
		#		AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n %HERE 5\n");
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
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1,0) -- ++(0,-2.7) -- ++(0.8,0);\n");
		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,1.5) rectangle (2,0.5);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0.5)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n \\caption{LFSR with feedback polynomial $", FeedbackPoly(x),"$}\\label{LABEL}\n \\end{figure}\n \\end{center}\n");

	else
	Error("not a COMPLEX  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);



InstallGlobalFunction( TikzWComplex_nLFSR, function(output, x)
local  n, nzt, i, len, simple, complex, idx;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
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
		#		AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n %HERE 5\n");
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

		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1.2,0) -- ++(0,-2.4);\n");
		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n \\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  \\draw (-1.2,1) node {$e$};)\n");


		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,0) rectangle (1,2);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n \\caption{LFSR with feedback polynomial $", FeedbackPoly(x),"$}\\label{LABEL}\n \\end{figure}\n \\end{center}\n");

	else
	Error("not a COMPLEX  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);



InstallGlobalFunction( TikzNComplex_nLFSR, function(output, x)
local  n, nzt, i, len, simple, complex, idx;

# [IsOutputStream,IsLFSR,IsFFECollection, IsPosInt]
#only check the output stream here, others will be checked by individual function calls !!!

if (IsOutputStream( output )) then
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		n := Length(x);
		nzt := IdxNonzeroCoeffs2(FeedbackVec(x)); #nonzerotaps
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
			AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,3.4); %arrow up\n");
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
			AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\t-1}; \n \\pgfmathtruncatemacro{\\y}{\\n-\\t}; \n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,2.3); %arrow up\n");
			AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n }%HERE 4\n");
		fi;
		AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n ");
			idx := nzt[len];
			if FeedbackVec(x)[idx] = Z(2)^0 then
				AppendTo(output, "\\draw[-,thick](\\x+1.5,0)--++(0,3.7)--++(-0.3,0); %arrow up\n");
			else
				AppendTo(output, "\\draw[-,thick](\\x+1.5,3.1)--++(0,0.6)--++(-0.3,0); %arrow up \n");
				AppendTo(output, " \\pgfmathtruncatemacro{\\x}{\\n-1}; \n \\pgfmathtruncatemacro{\\y}{0}; \n \\draw[->,thick](\\x+1.5,1.5)--(\\x+1.5,2.3); %arrow up\n");
		#		AppendTo(output, "  \\draw [thick] (\\x+1.5,2.7) circle (0.4) node  {{\\footnotesize $\\times\\omega_{\\y}$}};\n %HERE 5\n");
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

		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1.2,0) -- ++(0,-2.4);\n");
		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n \\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  \\draw (-1.2,1) node {$e$};)\n");


		AppendTo(output, "% stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n \\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] (\\x,1.5) rectangle (2,0.5);\n }\n");
		AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n \\pgfmathtruncatemacro{\\y}{\\n-\\x};\n \\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
		AppendTo(output, "% output(s)\n \\foreach \\t [count=\\s] in { ");

		for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
			 AppendTo(output,  OutputTap(x)[i], ",");
		od;
		AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n \\draw [->,thick] (\\x+1.5,0.5)-- ++(0,-\\s) --++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");
		AppendTo(output, "\\end{tikzpicture}\n \\caption{LFSR with feedback polynomial $", FeedbackPoly(x),"$}\\label{LABEL}\n \\end{figure}\n \\end{center}\n");

	else
	Error("not a COMPLEX  LFSR  !!!!\n");
	fi;
else
Error("outputstream not valid !!!!\n");
fi;

	return;
end);


InstallGlobalFunction( TikzW_LFSR, function(output, x)

if IsPrimeField(UnderlyingField(x)) then TikzWSimple_LFSR(output, x);
else TikzWComplex_LFSR(output, x);
fi;

return;
end);


InstallGlobalFunction( TikzW_nLFSR, function(output, x)

if IsPrimeField(DefaultField(FeedbackVec(x))) then TikzWSimple_nLFSR(output, x);
else TikzWComplex_nLFSR(output, x);
fi;

return;
end);


# if length(lfsr) > 10 go do the DOTS versions ???

# to do ? maybe someday when ure bored out of ur mind ...
# elif  IsPrimeField(DefaultField(FeedbackVec(x) without coefficient for constant term )) then TikzSimple_LFSR(output, x)
# else 	TikzComplex_LFSR








Print("drawlfsr.gi OK,\t");
#E  outlfsr.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
