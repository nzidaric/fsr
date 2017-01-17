#############################################################################
##
#W  test.gd                   GAP Library                   nusa zidaric
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
#A  CharPoly( <lfsr> )
#A  FeedbackVec(<lfsr>)
#A  FieldPoly(<lfsr>)
#A  OutputTap(<lfsr>)
##
##  <#GAPDoc Label="CharPoly">
##  <ManSection>
##  <Attr Name="CharPoly" Arg='lfsr' Label="for an LFSR"/>
##  <Attr Name="FeedbackVec" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  holds the characteristic polynomial (the feedback polynomial)
##  and the same in form of a vector but with the leading coefficient removed and with MSB first
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CharPoly", IsFSR );
DeclareAttribute( "FeedbackVec", IsFSR ); # should be IsLFSR , the equivalent for IsNLFSR will be CoeffVec ... maybe can have the same name coz theyre both coefficients  
DeclareAttribute( "FieldPoly", IsFSR );
DeclareAttribute( "OutputTap", IsFSR );



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



#############################################################################
##
#O  StepLFSR( <lfsr>)
#O  StepLFSR( <lfsr>, <elm>)
##
##  <#GAPDoc Label="StepLFSR">
##  <ManSection>
##  <Attr Name="StepLFSR" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("StepLFSR", [IsLFSR]);
DeclareOperation("StepLFSR", [IsLFSR, IsFFE]);



Print("lfsr.gd OK,\t");