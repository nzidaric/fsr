
#############################################################################
##
##
#W  drawnlfsr.gi          FSR Package                  Nusa
##
##  Implementation file for the FSR drawing functions - using tikz
##


InstallGlobalFunction( TikzCaption_NLFSR,
function(output, x, strGen, gen,  ext)
	# extconst = extension field coefficients
	# ext = external step/run intended
local  n, fbv, i;
SetPrintFormattingStatus(output, false);
			AppendTo(output,  "\\caption{{\\footnotesize ");
			if ext then
				AppendTo(output,  "External step/run ");
			fi;
			AppendTo(output,  " NLFSR with feedback ");
		  WriteTEXMultivarFFPolyByGenerator(output,  UnderlyingField(x), MultivarPoly(x), strGen, gen);
			AppendTo(output,  " over ");
			WriteTEXFF(output, UnderlyingField(x));
			if not IsPrimeField(UnderlyingField(x)) then
				AppendTo(output,  " where generator ");
				WriteTEXGeneratorWRTDefiningPolynomial(output,  UnderlyingField(x),	strGen, gen);
			fi;

			AppendTo(output,  ".}}\\label{LABEL}\n");
			AppendTo(output, "\\end{figure}\n \\end{center}\n");
	return;
end);

InstallGlobalFunction( 	TikzSimpleFeedback_NLFSR,
function(output, x, n, nzt, len, wn, ext, strGen, gen)
local  i;
SetPrintFormattingStatus(output, false);

	AppendTo(output,  "%the taps  with coefficient = 1\n");
	AppendTo(output,  "\\pgfmathtruncatemacro{\\n}{",n,"};\n");

		AppendTo(output,  "\\foreach \\t in { ");
		for i in [1..len-1] do # last tap doesnt count here
			AppendTo(output,  nzt[i], ",");
		od;
		AppendTo(output,  nzt[Length(nzt)], "}{\n");
		AppendTo(output, "\\pgfmathtruncatemacro{\\x}{\\t-1};\n \\draw[->,thick]");
		AppendTo(output, "(\\x+1.5,",wn,")--(\\x+1.5,3.4); %arrow up\n");


	AppendTo(output, "%feedback box \n \\pgfmathtruncatemacro{\\nn}{\\n};\n");
	AppendTo(output, "\\foreach \\x  in {1,...,\\nn}\n {\n");
	AppendTo(output, "\\draw [thick] (\\x,4)--(\\x+1,4);\n");
	AppendTo(output, "\\draw [thick] (\\x,3.4)--(\\x+1,3.4);\n}\n");

	AppendTo(output, "\\foreach \\x  in {1,\\nn+1}\n {\n");
	AppendTo(output, "\\draw [thick] (\\x,3.4)--(\\x,4);\n }\n");

	AppendTo(output, "\\foreach \\x  in {1}\n {\n");
	AppendTo(output, "\\draw (\\x+",0.5*n,",3.7) node {");
	WriteTEXMultivarFFPolyByGenerator(output,  UnderlyingField(x), MultivarPoly(x), strGen, gen);
	AppendTo(output, "};\n }\n");


	AppendTo(output, "%feedback \n }\n\\draw[->,thick] (1,3.7) ");
	if ext then
		AppendTo(output, "-- ++(-1,0) -- ++(0,-2.4);\n");

		AppendTo(output, "\\draw [thick] (0,1) circle (0.3) node  {$+$}; \n");
		AppendTo(output, "\\draw[->,thick] (-1,1) -- (-0.3,1);\n");
		AppendTo(output, "\\draw[->,thick] (0.3,1) -- (1,1); \n  ");
		AppendTo(output, "\\draw (-1.2,1) node {$e$};)\n");

	else
		AppendTo(output, "-- ++(-1,0) -- ++(0,-2.7) -- ++(1,0);\n");
	fi;
	return;
end);

InstallGlobalFunction( TikzWSimple_NLFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;
SetPrintFormattingStatus(output, false);
	if (IsNLFSR(x)) then

		n := Length(x);
		nzt := (n-IndetList(x)); #nonzerotaps
	#	Print(nzt,"\n");
		len := Length(nzt);
	#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_NLFSR(output, x, n, nzt, len, 2, false, strGen, gen);
		TikzWStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_NLFSR(output, x, strGen, gen,  false);
	else
		Error("not an NLFSR  !!!!\n");
	fi;
	return;
end);


InstallGlobalFunction( TikzWSimple_extNLFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;
SetPrintFormattingStatus(output, false);
	if (IsNLFSR(x)) then

		n := Length(x);
		nzt := (n-IndetList(x)); #nonzerotaps
	#	Print(nzt,"\n");
		len := Length(nzt);
	#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_NLFSR(output, x, n, nzt, len, 2, true, strGen, gen);
		TikzWStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_NLFSR(output, x, strGen, gen,  true);
	else
		Error("not an NLFSR  !!!!\n");
	fi;
	return;
end);



InstallGlobalFunction( TikzNSimple_NLFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;
SetPrintFormattingStatus(output, false);
	if (IsNLFSR(x)) then

		n := Length(x);
		nzt := (n-IndetList(x)); #nonzerotaps
	#	Print(nzt,"\n");
		len := Length(nzt);
	#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_NLFSR(output, x, n, nzt, len, 1.5, false, strGen, gen);
		TikzNStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_NLFSR(output, x, strGen, gen,  false);
	else
		Error("not an NLFSR  !!!!\n");
	fi;
	return;
end);

InstallGlobalFunction( TikzNSimple_extNLFSR, function(output, x, strGen, gen)
local  n, nzt, i, len, fbv, extconst;
SetPrintFormattingStatus(output, false);
	if (IsNLFSR(x)) then

		n := Length(x);
		nzt := (n-IndetList(x)); #nonzerotaps
	#	Print(nzt,"\n");
		len := Length(nzt);
	#	Print(nzt);
		AppendTo(output,  "\\begin{center}\n\\begin{figure}[h]\n\n");
		AppendTo(output,  "\\begin{tikzpicture}\n");
		TikzSimpleFeedback_NLFSR(output, x, n, nzt, len, 1.5, true, strGen, gen);
		TikzNStages(output, x, n);
		AppendTo(output, "\\end{tikzpicture}\n ");
		TikzCaption_NLFSR(output, x, strGen, gen,  true);
	else
		Error("not an NLFSR  !!!!\n");
	fi;
	return;
end);




InstallGlobalFunction( TikzW_NLFSR, function(output, x, strGen, gen)
	return TikzWSimple_NLFSR(output, x, strGen, gen);
end);

InstallGlobalFunction( TikzW_extNLFSR, function(output, x, strGen, gen)
	return TikzWSimple_extNLFSR(output, x, strGen, gen);
end);


InstallGlobalFunction( TikzN_NLFSR, function(output, x, strGen, gen)
	return TikzNSimple_NLFSR(output, x, strGen, gen);
end);

InstallGlobalFunction( TikzN_extNLFSR, function(output, x, strGen, gen)
	return TikzNSimple_extNLFSR(output, x, strGen, gen);
end);



Print("drawnlfsr.gi OK,\t");
#E  drawnlfsr.gi  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
