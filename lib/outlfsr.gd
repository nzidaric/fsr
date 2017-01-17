#############################################################################
##
##
#W  outlfsr.gd          LFSR Package                  Nusa
##
##  Declaration file for the LFSR specific output formatting functions
##


#############################################################################
##
#F  WriteAllLFSR( <output>, <lfsr> ) . . . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="WriteAllLFSR">
##  <ManSection>
##  <Func Name="WriteAllLFSR" Arg="output, lfsr"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteAllLFSR" );
#DeclareGlobalFunction( "WriteAllLFSRTEX" );

#############################################################################
##
#F  WriteRunLFSR( <output>, <lfsr>, <ist>, <numsteps> ) . . . . . . . . write elm to file
##
##  <#GAPDoc Label="WriteRunLFSR">
##  <ManSection>
##  <Func Name="WriteRunLFSR" Arg="output, lfsr, ist, numsteps"/>
##  <Func Name="WriteRunLFSRTEX" Arg="output, lfsr, ist, numsteps"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteRunLFSR" );
DeclareGlobalFunction( "WriteRunLFSRTEX" );


Print("outlfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
