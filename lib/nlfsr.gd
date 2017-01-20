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
#A  FeedbackVec(<nlfsr>) # declared in fsr.gd!!!
#A  FieldPoly(<nlfsr>) # declared in fsr.gd!!!
#A  OutputTap(<nlfsr>) # declared in fsr.gd!!!
##
##  <#GAPDoc Label="MultivarPoly">
##  <ManSection>
##  <Attr Name="CharPoly" Arg='lfsr' Label="for an LFSR"/>
##  <Attr Name="FeedbackVec" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  holds the multivariate function defining the feedback
##  the FeedbackVec now holds only the nonzero coefficients 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MultivarPoly", IsNLFSR );
DeclareAttribute( "IndetList", IsNLFSR );


Print("nlfsr.gd OK,\t");