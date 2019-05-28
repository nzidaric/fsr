
#############################################################################
##
##
#W  drawlfsr.gi          FSR Package                  Nusa
##
##  Implementation file for the FSR drawing functions - using tikz
##
InstallGlobalFunction( ComplexCheck, function(x)
local  fbv, i, extconst;
	extconst := false;
	if IsFSR(x) then
		fbv := FeedbackVec(x); #nonzerotaps
		for i in fbv do
				if i <> Zero(UnderlyingField(x)) and i <> One(UnderlyingField(x)) then
					extconst := true; break;
				fi;
		od;
	else
		Error("not a FSR  !!!!\n");
	fi;
	return extconst;
end);


InstallGlobalFunction( TikzCaption_LFSR,
function(output, x, strGen, gen, extconst, ext)
	# extconst = extension field coefficients
	# ext = external step/run intended
local  n, fbv, i;
SetPrintFormattingStatus(output, false);
			AppendTo(output,  "\\caption{{\\footnotesize ");
			if ext then
				AppendTo(output,  "External step/run ");
			fi;
			AppendTo(output,  " LFSR with feedback ");
			WriteTEXLFSRPolyByGenerator(output,  UnderlyingField(x), FeedbackPoly(x), strGen, gen);
			AppendTo(output,  " over ");
			WriteTEXFF(output, UnderlyingField(x));
			if not IsPrimeField(UnderlyingField(x)) then
				AppendTo(output,  " where generator ");
				WriteTEXGeneratorWRTDefiningPolynomial(output,  UnderlyingField(x),	strGen, gen);
			fi;
			fbv := FeedbackVec(x); #nonzerotaps
			if extconst then
				AppendTo(output, " and constant(s) ");
				for i in [1.. Length(fbv)] do
					if fbv[i] <> Zero(UnderlyingField(x)) and fbv[i] <> One(UnderlyingField(x)) then
							AppendTo(output, "$\\omega_{",Length(fbv)-i,"}=$\\,");
							WriteTEXFFEByGenerator(output, fbv[i], strGen, gen);
							if i < Length(fbv) then
							AppendTo(output, "\\; ");
							fi;
					fi;
				od;
			fi;
			AppendTo(output,  ".}}\\label{LABEL}\n");
			AppendTo(output, "\\end{figure}\n \\end{center}\n");
	return;
end);

InstallGlobalFunction( 	TikzSimpleFeedback_LFSR,
function(output, n, nzt, len, wn, ext)
local  i;
SetPrintFormattingStatus(output, false);

	AppendTo(output,  "%the taps  with coefficient = 1\n");
	AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");
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
	AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick]");
	AppendTo(output, "(\\x+1.5,",wn,")--(\\x+1.5,3.4); %arrow up\n");
	AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node {$+$};\n");
	AppendTo(output, "\\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
	fi;
	AppendTo(output, "% last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n ");
	if IsInt(wn) then
	AppendTo(output, "\\draw[-,thick](\\x+1.5,",wn,")--++(0,1.7)--++(-0.3,0); ");
	else
	AppendTo(output, "\\draw[-,thick](\\x+1.5,",wn,")--++(0,2.2)--++(-0.3,0); ");
  fi;
	AppendTo(output, "%arrow up\n");
	AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");

	for i in [1..n-1] do # last tap doesnt count here
		if (not \in(i, nzt)) then  AppendTo(output,  i, ","); fi;
	od;
	if (not \in(i, nzt)) then  AppendTo(output,  n-1, "}{\n");
	else AppendTo(output,  "}{\n");
	fi;

	AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n ");
	AppendTo(output, "\\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
	AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) ");
	if ext then
		AppendTo(output, "-- ++(-1.2,0) -- ++(0,-2.4);\n");

		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n");
		AppendTo(output, "\\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  ");
		AppendTo(output, "\\draw (-1.2,1) node {$e$};)\n");

	else
		AppendTo(output, "-- ++(-1,0) -- ++(0,-2.7) -- ++(0.8,0);\n");
	fi;
	return;
end);

InstallGlobalFunction( 	TikzComplexFeedback_LFSR,
function(output, x, wn, ext)
local  i, n, nzt, len, simple, complex, idx, fbv;
	SetPrintFormattingStatus(output, false);
	simple := []; complex := [];
	n := Length(x);
	nzt := IdxNonzeroCoeffs(FeedbackVec(x)); #nonzerotaps
	len := Length(nzt);
	fbv := FeedbackVec(x);
	for i in [1..len-1] do # last tap doesnt count here
		idx := nzt[i];
		if IsOne(fbv[idx]) then Add(simple, idx);
		else Add(complex, idx);
		fi;
	od;

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
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n");
		AppendTo(output, "\\draw[->,thick](\\x+1.5,",wn,")--(\\x+1.5,3.4); %arrow up\n");
		AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$};\n");
		AppendTo(output, "\\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n }\n");
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
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1}; \n");
		AppendTo(output, "\\draw [thick] (\\x+1.5,3.7) circle (0.3) node  {$+$}; \n");
		AppendTo(output, "\\draw [->,thick] (\\x+2.2,3.7)--(\\x+1.8,3.7) ;\n");
		AppendTo(output, "\\draw[->,thick](\\x+1.5,3.1)--(\\x+1.5,3.4);}\n");
	fi;

	if Length(complex) > 1 then
		AppendTo(output, "%HERE 2\n\\foreach \\t in { ");
		for i in [1..Length(complex)-1] do # last tap doesnt count here
			 AppendTo(output,  complex[i], ",");
		od;
		idx := nzt[len];
		if FeedbackVec(x)[idx] = Z(2)^0 then
					AppendTo(output, complex[Length(complex)], "}{\n");
		else 	AppendTo(output, complex[Length(complex)], ", ",idx,"}{\n");
		fi;
	elif Length(complex) = 1 then
	AppendTo(output,  "%HERE 3\n\\foreach \\t in { ");
		idx := nzt[len];
		if FeedbackVec(x)[idx] = Z(2)^0 then
					AppendTo(output, complex[1], "}{\n");
		else 	AppendTo(output, complex[1], ", ",idx,"}{\n");
		fi;
	fi;

	if Length(complex) >= 1 then
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1}; \n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\y}{\\n-\\t}; \n");
		AppendTo(output, "\\draw[->,thick](\\x+1.5,",wn,")--(\\x+1.5,2.3); %arrow up\n");
		AppendTo(output, "\\draw [thick] (\\x+1.5,2.7) circle (0.4) node  ");
		AppendTo(output, "{{\\footnotesize $\\times\\omega_{\\y}$}};\n }%HERE 4\n");
	fi;
	AppendTo(output, "%last arrow \n \\pgfmathtruncatemacro{\\x}{\\n-1};\n ");
	idx := nzt[len];
	if FeedbackVec(x)[idx] = Z(2)^0 then
		if IsInt(wn) then
		AppendTo(output, "\\draw[-,thick](\\x+1.5,",wn,")--++(0,1.7)--++(-0.3,0); ");
		else
		AppendTo(output, "\\draw[-,thick](\\x+1.5,",wn,")--++(0,2.2)--++(-0.3,0); ");
	  fi;
		AppendTo(output, "%arrow up\n");
	else
		AppendTo(output, "\\draw[-,thick](\\x+1.5,3.1)--++(0,0.6)--++(-0.3,0); ");
		AppendTo(output, "%arrow up \n");
		if Length(complex) = 0 then
			AppendTo(output, "\\draw[->,thick](\\x+1.5,",wn,")--(\\x+1.5,2.3); %arrow up\n");
			AppendTo(output, "\\draw [thick] (\\x+1.5,2.7) circle (0.4) node ");
			AppendTo(output, "{{\\footnotesize $\\times\\omega_{0}$}};\n %HERE 5\n");
		fi;
	fi;

	if (Length(simple) + Length(complex) < Length(x) ) then
		AppendTo(output, "%the non-taps  \n \\foreach \\t  in {");

		for i in [1..n-1] do # last tap doesnt count here
			if not (\in(i, simple) or \in(i, complex)) then
				AppendTo(output,  i, ",");
			fi;
		od;
		if  not (\in(i, simple) or \in(i, complex)) then
					AppendTo(output,  n-1, "}{\n");
		else 	AppendTo(output,  "}{\n");
		fi;
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n");
		AppendTo(output, "\\draw[-,thick](\\x+1.2,3.7)--(\\x+2.2,3.7);\n}\n");
	fi;


	if ext then # FIX IF
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1,0) ");
		AppendTo(output, "-- ++(-0.2,0) -- ++(0,-2.4);\n");

		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n");
		AppendTo(output, "\\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  ");
		AppendTo(output, "\\draw (-1.2,1) node {$e$};)\n");

	else
		AppendTo(output, "%feedback \n \\draw[->,thick] (1.2,3.7) -- ++(-1,0) ");
		AppendTo(output, " -- ++(0,-2.5) -- ++(0.8,0);\n");
	fi;
	return;
end);

InstallGlobalFunction( 	TikzNStages, function(output, x, n)
local   i;
SetPrintFormattingStatus(output, false);

	AppendTo(output, "%stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n ");
	AppendTo(output, "\\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] ");
	AppendTo(output, "(\\x,1.5) rectangle (2,0.5);\n }\n");
	AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n");
	AppendTo(output, "\\pgfmathtruncatemacro{\\y}{\\n-\\x};\n  ");
	AppendTo(output, "\\draw (\\x+0.5,1)node {$\\mathcal{S}_{\\y}$};\n }\n");
	AppendTo(output, "%output(s)\n \\foreach \\t [count=\\s] in { ");

	for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
	   AppendTo(output,  OutputTap(x)[i], ",");
	od;
	AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
	AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n");
	AppendTo(output, "\\draw [->,thick] (\\x+1.5,0.5)-- ++(0,-\\s) ");
	AppendTo(output, "--++(1+\\t,0)  node [right] {$s_{\\t}$};\n }\n");

	return;
end);

InstallGlobalFunction( 	TikzWStages, function(output, x, n)
local   i;
SetPrintFormattingStatus(output, false);

	AppendTo(output, "%stages\n \\pgfmathtruncatemacro{\\nn}{\\n+1};\n ");
	AppendTo(output, "\\foreach \\x  in {1,...,\\nn}\n {\n \\draw [thick] ");
	AppendTo(output, "(\\x,0) rectangle (1,2);\n }\n");
	AppendTo(output, "\\foreach \\x  in {1,...,\\n}\n { \n");
	AppendTo(output, "\\pgfmathtruncatemacro{\\y}{\\n-\\x};\n ");
	AppendTo(output, "\\draw (\\x+0.5,1) node {$\\mathcal{S}_{\\y}$};\n }\n");
	AppendTo(output, "%output(s)\n \\foreach \\t [count=\\s] in { ");

	for i in [1..Length(OutputTap(x))-1] do # last tap doesnt count here
	   AppendTo(output,  OutputTap(x)[i], ",");
	od;
	AppendTo(output,  OutputTap(x)[Length(OutputTap(x))], "}{\n");
	AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\n-\\t-1};\n");
	AppendTo(output, "\\draw [->,thick] (\\x+1.5,0)-- ++(0,-\\s) --++(1+\\t,0)");
	AppendTo(output, "  node [right] {$s_{\\t}$};\n }\n");

	return;
end);

InstallGlobalFunction( TikzWSimple_LFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;
SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if extconst then 		Error("not a SIMPLE  LFSR  !!!!\n"); fi;

		n := Length(x);
		nzt := IdxNonzeroCoeffs(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
	#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_LFSR(output, n, nzt, len, 2, false);
		TikzWStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, false);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);

InstallGlobalFunction( TikzNSimple_LFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if extconst then 		Error("not a SIMPLE  LFSR  !!!!\n"); fi;

		n := Length(x);
		nzt := IdxNonzeroCoeffs(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);

		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_LFSR(output, n, nzt, len, 1.5, false);
		TikzNStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, false);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);


InstallGlobalFunction( TikzWSimple_extLFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if extconst then 		Error("not a SIMPLE  LFSR  !!!!\n"); fi;

		n := Length(x);
		nzt := IdxNonzeroCoeffs(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
	#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_LFSR(output, n, nzt, len, 2, true);
		TikzWStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, true);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);

InstallGlobalFunction( TikzNSimple_extLFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if extconst then 		Error("not a SIMPLE  LFSR  !!!!\n"); fi;

		n := Length(x);
		nzt := IdxNonzeroCoeffs(FeedbackVec(x)); #nonzerotaps
		len := Length(nzt);
		#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_LFSR(output, n, nzt, len, 1.5, true);
		TikzNStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, true);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);

InstallGlobalFunction( TikzWComplex_LFSR, function(output, x, strGen, gen)
local  fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if not extconst then 		Error("not a COMPLEX  LFSR  !!!!\n"); fi;

		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzComplexFeedback_LFSR(output, x, 2, false);
		TikzWStages(output, x, Length(x));
		AppendTo(output, "\\end{tikzpicture}\n");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, false);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);


InstallGlobalFunction( TikzWComplex_extLFSR, function(output, x, strGen, gen)
local  fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if not extconst then 		Error("not a COMPLEX  LFSR  !!!!\n"); fi;

		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzComplexFeedback_LFSR(output, x, 2, true);
		TikzWStages(output, x, Length(x));
		AppendTo(output, "\\end{tikzpicture}\n");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, true);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);


InstallGlobalFunction( TikzNComplex_LFSR, function(output, x, strGen, gen)
local  fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if not extconst then 		Error("not a COMPLEX  LFSR  !!!!\n"); fi;

		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzComplexFeedback_LFSR(output, x, 1.5, false);
		TikzNStages(output, x, Length(x));
		AppendTo(output, "\\end{tikzpicture}\n");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, false);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);


InstallGlobalFunction( TikzNComplex_extLFSR, function(output, x, strGen, gen)
local  fbv, extconst;

SetPrintFormattingStatus(output, false);
	if (IsLFSR(x)) then
		fbv := FeedbackVec(x); #nonzerotaps
		extconst := ComplexCheck(x);
		if not extconst then 		Error("not a COMPLEX  LFSR  !!!!\n"); fi;

		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzComplexFeedback_LFSR(output, x, 1.5, true);
		TikzNStages(output, x, Length(x));
		AppendTo(output, "\\end{tikzpicture}\n");
		TikzCaption_LFSR(output, x, strGen, gen, extconst, true);
	else
		Error("not an LFSR  !!!!\n");
	fi;
	return;
end);

InstallGlobalFunction( TikzW_LFSR, function(output, x, strGen, gen)
	if ComplexCheck(x) then
				TikzWComplex_LFSR(output, x, strGen, gen);
	else 	TikzWSimple_LFSR(output, x, strGen, gen);
	fi;
	return;
end);

InstallGlobalFunction( TikzW_extLFSR, function(output, x, strGen, gen)
	if ComplexCheck(x)  then
				TikzWComplex_extLFSR(output, x, strGen, gen);
	else 	TikzWSimple_extLFSR(output, x, strGen, gen);
	fi;
	return;
end);



InstallGlobalFunction( TikzN_LFSR, function(output, x, strGen, gen)
	if ComplexCheck(x) then
				TikzNComplex_LFSR(output, x, strGen, gen);
	else 	TikzNSimple_LFSR(output, x, strGen, gen);
	fi;
	return;
end);

InstallGlobalFunction( TikzN_extLFSR, function(output, x, strGen, gen)
	if ComplexCheck(x)  then
				TikzNComplex_extLFSR(output, x, strGen, gen);
	else 	TikzNSimple_extLFSR(output, x, strGen, gen);
	fi;
	return;
end);

# if length(lfsr) > 10 go do the DOTS versions ???

# to do ? maybe someday when ure bored out of ur mind ...
# elif  IsPrimeField(DefaultField(FeedbackVec(x) without coefficient for constant term )) then TikzSimple_LFSR(output, x)
# else 	TikzComplex_LFSR

Print("drawlfsr.gi OK,\t");
#E  outlfsr.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
