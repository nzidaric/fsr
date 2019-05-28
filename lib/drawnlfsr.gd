#############################################################################
##
##
#W  drawnlfsr.gd          FSR Package                  Nusa
##
##  Declaration file for the FSR drawing functions - using tikz
##



DeclareGlobalFunction( "TikzCaption_NLFSR" );
DeclareGlobalFunction( "TikzSimpleFeedback_NLFSR" );


DeclareGlobalFunction( "TikzWSimple_NLFSR" );
DeclareGlobalFunction( "TikzNSimple_NLFSR" );
DeclareGlobalFunction( "TikzWSimple_extNLFSR" );
DeclareGlobalFunction( "TikzNSimple_extNLFSR" );


#############################################################################
##
#F  TikzW_LFSR( <output>, <F> ) . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="TikzW_NLFSR"">
##  <ManSection>
##  <Func Name="TikzW_NLFSR" Arg="output, lfsr , strGen, gen"/>
##  <Func Name="TikzN_NLFSR" Arg="output, lfsr , strGen, gen"/>
##  <Func Name="TikzW_extNLFSR" Arg="output, lfsr , strGen, gen"/>
##  <Func Name="TikzN_extNLFSR" Arg="output, lfsr , strGen, gen"/>


##
##  <Description>
##  <C>TikzW_NLFSR</C>  and  <C>TikzN_NLFRS</C> draw the  <A>nlfsr</A> with
##  wide or narrow state, i.e. the stage boxes are wider when <E>W</E> function
##  call is used.
##  The feedback is drawn as a simple box with <Ref Meth="MultivarPoly"/>.
##  All the output taps specified
##  by <Ref Meth="OutputTap" /> are also shown.<P/>
##  <C>TikzW_extLFSR</C>  and  <C>TikzN_extLFSR</C> draw the extra external
##  element <M>e</M>  added to the feedback before updating the vacant stage.
##

##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "TikzW_NLFSR" );
DeclareGlobalFunction( "TikzW_extNLFSR" );
DeclareGlobalFunction( "TikzN_NLFSR" );
DeclareGlobalFunction( "TikzN_extNLFSR" );


###############################################################################
##
##  <#GAPDoc Label="drawing2EG">
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.9]{DrawNLFSR1}
##  \caption{Sample output of TikzN\_NLFSR function}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="DrawNLFSR1.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <#/GAPDoc>



Print("drawnlfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
