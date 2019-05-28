#############################################################################
##
##
#W  drawlfsr.gd          FSR Package                  Nusa
##
##  Declaration file for the FSR drawing functions - using tikz
##


###############################################################################
##
##  <#GAPDoc Label="dummy1"">
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.9]{dummy}\end{figure}</Alt>
##  <#/GAPDoc>

###############################################################################
##
##  <#GAPDoc Label="drawing1">
##  <Index>drawing</Index>
##  The drawing functions are implemented for the (N)LFSRs, but not for FILFUNs.
##  While the LFSR feedbacks are drawn precisely, the NLFSR feedbacks are a
##  simple box with the multivariate polynomial. For both LFSRs and NLFSRs, two
##  options exist for the state: wide state and narrow state (users preference,
##  and two different functions exist for each: regular FSR and external FSR
##  (the latter with the keyword <E>ext</E> in the function name). The wide and
##  narrow state are also distinguished with keywords <E>W</E> and <E>N</E> in
##  the function name. <P/>
##  Additional tex package <E>tikz</E> must be used.
## <P/>
##  <#/GAPDoc>

DeclareGlobalFunction( "ComplexCheck" );
DeclareGlobalFunction( "TikzCaption_LFSR" );
DeclareGlobalFunction( "TikzSimpleFeedback_LFSR" );
DeclareGlobalFunction( "TikzComplexFeedback_LFSR" );
DeclareGlobalFunction( "TikzNStages" );
DeclareGlobalFunction( "TikzWStages" );
DeclareGlobalFunction( "TikzWSimple_LFSR" );
DeclareGlobalFunction( "TikzNSimple_LFSR" );
DeclareGlobalFunction( "TikzWSimple_extLFSR" );
DeclareGlobalFunction( "TikzNSimple_extLFSR" );
#DeclareGlobalFunction( "TikzWSimpleDots_LFSR" );
#DeclareGlobalFunction( "TikzWSimpleDots_nLFSR" );
DeclareGlobalFunction( "TikzWComplex_LFSR" );
DeclareGlobalFunction( "TikzNComplex_LFSR" );
DeclareGlobalFunction( "TikzWComplex_extLFSR" );;
DeclareGlobalFunction( "TikzNComplex_extLFSR" );
#DeclareGlobalFunction( "TikzWComplexDots_LFSR" );
#DeclareGlobalFunction( "TikzWComplexDots_nLFSR" );


#############################################################################
##
#F  TikzW_LFSR( <output>, <F> ) . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="TikzW_LFSR"">
##  <ManSection>
##  <Func Name="TikzW_LFSR" Arg="output, lfsr , strGen, gen"/>
##  <Func Name="TikzN_LFSR" Arg="output, lfsr , strGen, gen"/>
##  <Func Name="TikzW_extLFSR" Arg="output, lfsr , strGen, gen"/>
##  <Func Name="TikzN_extLFSR" Arg="output, lfsr , strGen, gen"/>


##
##  <Description>
##  <C>TikzW_LFSR</C>  and  <C>TikzN_LFRS</C> draw the  <A>lfsr</A> with
##  wide or narrow state, i.e. the stage boxes are wider when <E>W</E> function
##  call is used. The wider stage boxes are actually just taller and are useful
##  to indicate that the <Ref Meth="UnderlyingField" /> of the <A>lfsr</A> is an
##  extension field.
##  The feedback is drawn with XOR gates and multiplications by
##  coefficients that are different from 1. All the output taps specified
##  by <Ref Meth="OutputTap" /> are also shown.<P/>
##  <C>TikzW_extLFSR</C>  and  <C>TikzN_extLFSR</C> draw the extra external
##  element <M>e</M>  added to the feedback before updating the vacant stage.
##

##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "TikzW_LFSR" );
DeclareGlobalFunction( "TikzW_extLFSR" );
DeclareGlobalFunction( "TikzN_LFSR" );
DeclareGlobalFunction( "TikzN_extLFSR" );



###############################################################################
##
##  <#GAPDoc Label="drawing1EG">
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.9]{DrawLFSR1}
##  \caption{Sample output of TikzN\_LFSR function}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="DrawLFSR1.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.8]{DrawLFSR2}
##  \caption{Sample output of TikzN\_extLFSR function}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="DrawLFSR2.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <#/GAPDoc>


Print("drawlfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
