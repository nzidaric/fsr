#############################################################################
##
##
#W  drawnlfsr.gd          FSR Package                  Nusa
##
##  Declaration file for the FSR drawing functions - using tikz
##


#############################################################################
##
#F  TikzSimple_LFSR( <output>, <lfsr> ) . . . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="TikzSimple_LFSR">
##  <ManSection>
##  <Func Name="TikzSimple_LFSR" Arg="output, lfsr"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "TikzNComplex_NLFSR" );
#DeclareGlobalFunction( "TikzWComplex_LFSR" );
#DeclareGlobalFunction( "TikzWComplex_nLFSR" );
#DeclareGlobalFunction( "TikzNComplex_nLFSR" );
#DeclareGlobalFunction( "TikzWComplexDots_LFSR" );
#DeclareGlobalFunction( "TikzWComplexDots_nLFSR" );
#DeclareGlobalFunction( "TikzW_LFSR" );
#DeclareGlobalFunction( "TikzW_nLFSR" );


#move to WG library ? 
#DeclareGlobalFunction( "TikzWG_LFSR" );
#DeclareGlobalFunction( "TikzWGDots_LFSR" );



Print("drawnlfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here