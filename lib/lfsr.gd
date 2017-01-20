#############################################################################
##
#W  lfsr.gd                   GAP Package                   nusa zidaric
##
##

## storing initial state , current state and number of steps already performed 
DeclareRepresentation( "IsLFSRRep", IsComponentObjectRep and IsAttributeStoringRep and IsFSR, ["init", "state", "numsteps"] );


#############################################################################
##
#F  LFSR( <K>, <charpol> )  . . . . . . . . . .  create an LFSR object 	# len 2
#F  LFSR( <K>, <fieldpol>, <charpol>)					# len 3
#F  LFSR( <F>, <charpol>)						# len 2
#F  LFSR( <m>, <n> )# remove this option coz its hard to tell the difference 
# between LFSR( <p>, <m>, <n>  ) and  LFSR( <m>, <n> , <tap>)
#F  LFSR( <p>, <m>, <n>  )						# len 3
#F  LFSR( <K>, <charpol>, <tap> ) 					# len 3
#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)				# len 4
#F  LFSR( <F>, <charpol>, <tap>)					# len 3
#F  LFSR( <m>, <n> , <tap>) #remove
#F  LFSR( <p>, <m>, <n>, <tap>  )					# len 4
DeclareGlobalFunction( "LFSR" );


#############################################################################
##
#P  IsLinearFeedback( <lfsr> )
##
##  <#GAPDoc Label="IsLinearFeedback">
##  <ManSection>
##  <Attr Name="IsLinearFeedback" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLinearFeedback", IsFSR );
DeclareSynonym( "IsLFSR", IsFSR and IsLinearFeedback);

#############################################################################
##
#A  CharPoly( <lfsr> )
#A  FeedbackVec(<lfsr>) # declared in fsr.gd!!!
#A  FieldPoly(<lfsr>) # declared in fsr.gd!!!
#A  OutputTap(<lfsr>) # declared in fsr.gd!!!
##
##  <#GAPDoc Label="CharPoly">
##  <ManSection>
##  <Attr Name="CharPoly" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  holds the characteristic polynomial (the feedback polynomial)
##  and the same in form of a vector but with the leading coefficient removed and with MSB first,
## called the FeedbackVec, to compute the new elm 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CharPoly", IsLFSR );







#############################################################################
##
#P  IsPeriodic( <lfsr> )
##
##  <#GAPDoc Label="IsPeriodic">
##  <ManSection>
##  <Attr Name="IsPeriodic" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPeriodic", IsLFSR );
DeclareSynonym( "IsUltPeriodic", IsLFSR ); # if LSFR always ult.per.   (8.7 lidl, niederreiter)	
DeclareOperation("PeriodIrr",  [IsField, IsUnivariatePolynomial, IsPosInt]);
DeclareAttribute( "Period", IsLFSR );
DeclareProperty("IsMaxSeqLFSR",  IsLFSR);

#############################################################################
##
#M  ViewObj( <lfsr> )
#M  PrintObj( <lfsr> )
#M  Display( <lfsr> )
#M  PrintAll( <lfsr> )
##
##  <#GAPDoc Label="PrintObj">
##  <ManSection>
##  <Attr Name="PrintObj" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("PrintObj", [IsLFSR]);
DeclareOperation("PrintObj", [IsBasis, IsLFSR]);
DeclareOperation("PrintAll", [IsLFSR]);
DeclareOperation("PrintAll", [IsBasis, IsLFSR]);







Print("lfsr.gd OK,\t");