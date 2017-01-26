#############################################################################
##
#W  nlfsr.gd                   GAP Package                   nusa zidaric
##
##

## storing initial state , current state , current multinomial state and number of steps already performed 
DeclareRepresentation( "IsNLFSRRep", IsComponentObjectRep and IsAttributeStoringRep and IsFSR, ["init", "state", "polystate", "numsteps"] );


#############################################################################
##
#F  NLFSR( <K>, <clist>, <mlist> , <len> )  . . . .  create an LFSR object 	# len 4
#F  NLFSR( <K>, <fieldpol>,  <clist>, <mlist> , <len> )  . . . .  create an LFSR object 	# len 5
#F  NLFSR( <K>, <clist>, <mlist> , <len> , <tap>)  . . . .  create an LFSR object 	# len 5
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len>, <tap> )  . . . .  create an LFSR object 	# len 6
DeclareGlobalFunction( "NLFSR" );






#############################################################################
##
#P  IsNonLinearFeedback( <nlfsr> )
##
##  <#GAPDoc Label="IsNonLinearFeedback">
##  <ManSection>
##  <Attr Name="IsNonLinearFeedback" Arg='nlfsr' Label="for an NLFSR"/>
##
##  <Description>
##  sets true if DegreeOfPolynomial > 1
##  otherwise it prints out a warning that you need to use the LFSR constructor instead
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsNonLinearFeedback", IsFSR );
DeclareSynonym( "IsNLFSR", IsFSR and IsNonLinearFeedback);

#############################################################################
##
#A  MultivarPoly( <nlfsr> )
#A  IndetList( <nlfsr> )
##
##  <#GAPDoc Label="MultivarPoly">
##  <ManSection>
##  <Attr Name="MultivarPoly" Arg='nlfsr' Label="for an NLFSR"/>
##  <Attr Name="IndetList" Arg='nlfsr' Label="for an NLFSR"/>
##  <Description>
##  <C>MultivarPoly</C> holds the multivariate function defining the feedback of the NLFSR. 
##  <C>IndetList</C> holds all the indeterminates that are present in MultivarPoly
##  and <C>FeedbackVec</C> now holds only the nonzero coefficients. The feedback element is computed from 
##  <C>MultivarPoly</C>, <C>IndetList</C> and <C>state</C>, and not from <C>FeedbackVec</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MultivarPoly", IsNLFSR );
DeclareAttribute( "IndetList", IsNLFSR );

#############################################################################
##
#M  ViewObj( <nlfsr> )
#M  PrintObj( <nlfsr> )
#M  Display( <nlfsr> )
#M  PrintAll( <nlfsr> )
##
##  <#GAPDoc Label="PrintNLFSR">
##  <ManSection>
##  <Attr Name="PrintObj" Arg='nlfsr' Label="for an nlfsr"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("PrintObj", [IsNLFSR]);
DeclareOperation("PrintObj", [IsBasis, IsNLFSR]);
DeclareOperation("PrintAll", [IsNLFSR]);
DeclareOperation("PrintAll", [IsBasis, IsNLFSR]);



Print("nlfsr.gd OK,\t");