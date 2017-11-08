#############################################################################
##
##
#W  drawlfsr.gd          FSR Package                  Nusa
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
DeclareGlobalFunction( "TikzWSimple_LFSR" );
DeclareGlobalFunction( "TikzNSimple_LFSR" );
DeclareGlobalFunction( "TikzWSimple_nLFSR" );
DeclareGlobalFunction( "TikzNSimple_nLFSR" );
#DeclareGlobalFunction( "TikzWSimpleDots_LFSR" );
#DeclareGlobalFunction( "TikzWSimpleDots_nLFSR" );
DeclareGlobalFunction( "TikzWComplex_LFSR" );
DeclareGlobalFunction( "TikzNComplex_LFSR" );
DeclareGlobalFunction( "TikzWComplex_nLFSR" );
DeclareGlobalFunction( "TikzNComplex_nLFSR" );
#DeclareGlobalFunction( "TikzWComplexDots_LFSR" );
#DeclareGlobalFunction( "TikzWComplexDots_nLFSR" );
DeclareGlobalFunction( "TikzW_LFSR" );
DeclareGlobalFunction( "TikzW_nLFSR" );
DeclareGlobalFunction( "TikzN_LFSR" );
DeclareGlobalFunction( "TikzN_nLFSR" );




Print("drawlfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here