#############################################################################
##
##
#W  drawlfsr.gd          LFSR Package                  Nusa
##
##  Declaration file for the LFSR drawing functions - using tikz
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
DeclareGlobalFunction( "TikzSimple_LFSR" );
DeclareGlobalFunction( "TikzSimple_nLFSR" );
#DeclareGlobalFunction( "TikzSimpleDots_LFSR" );
#DeclareGlobalFunction( "TikzSimpleDots_nLFSR" );
DeclareGlobalFunction( "TikzComplex_LFSR" );
DeclareGlobalFunction( "TikzComplex_nLFSR" );
#DeclareGlobalFunction( "TikzComplexDots_LFSR" );
#DeclareGlobalFunction( "TikzComplexDots_nLFSR" );
DeclareGlobalFunction( "Tikz_LFSR" );
DeclareGlobalFunction( "Tikz_nLFSR" );


#move to WG library ? 
#DeclareGlobalFunction( "TikzWG_LFSR" );
#DeclareGlobalFunction( "TikzWGDots_LFSR" );



Print("drawlfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here