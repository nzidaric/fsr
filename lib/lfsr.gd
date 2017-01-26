#############################################################################
##
#W  lfsr.gd                   GAP Package                   nusa zidaric
##
##

## storing initial state , current state and number of steps already performed 
DeclareRepresentation( "IsLFSRRep", IsComponentObjectRep and IsAttributeStoringRep and IsFSR, ["init", "state", "numsteps"] );


#############################################################################
##
#F  LFSR( <K>, <charpol> )  . . . . . . . . . .  create an LFSR object 	
#F  LFSR( <K>, <fieldpol>, <charpol>)					
#F  LFSR( <F>, <charpol>)						
#F  LFSR( <p>, <m>, <n>  )						
#F  LFSR( <K>, <charpol>, <tap> ) 					
#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)				
#F  LFSR( <F>, <charpol>, <tap>)					
#F  LFSR( <p>, <m>, <n>, <tap>  )					
##  <#GAPDoc Label="LFSR">
##  <ManSection>
##  <Func Name="LFSR" Arg="F, charpol [, tap]"/>
##  <Func Name="LFSR" Arg="K, fieldpol, charpol [, tap]"/>
##  <Func Name="LFSR" Arg="F, charpol [, tap]"/>
##  <Func Name="LFSR" Arg="p, m, n [, tap]"/>
##  <Returns>
##    an empty LFSR with components <C>init</C>, <C>state</C> and <C>numsteps</C>
##  </Returns>	
##  <Description>
##  Different ways to create an LFSR oblject, main difference is in creation of the underlying finite field.
##  <P/>
##  Inputs:
##  <List>
##  <Item> <C>F</C> - the underlying finite field (either an extension field or a prime field)</Item>
##  <Item> <C>charpol</C> - LFSR dfining polynomial </Item>
##  <Item> <C>fieldpol</C> - defifning polynomial of the extension field (must be irreducible)</Item>
##  <Item> <C>p</C> - characteeristic </Item>
##  <Item> <C>m</C> - degree of extension (degree of <C>fieldpol</C>) </Item>
##  <Item> <C>n</C> - length of  LFSR (degree of <C>charpoly</C>)</Item>
##  <Item> <C>tap</C> - OPTIONAL parameter: the output tap (must be a positive integer or a list of positive integers)
##  and will be changed to the default S_0 if the specified integer is out of LFSR range.</Item>
##  </List>
##  Compoents:
##  <List>
##  <Item> <C>init</C> - FFE vector of length n=deg(charpol), storing the initial state of the LFSR, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>state</C> - FFE vector of length n=deg(charpol), storing the current state of the LFSR, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>numsteps</C> - the number of steps performed thus far (initialized to -1 when created, set to 0 when loaded using <Ref Func="LoadFSR" /> and incremented by 1 with each step (using <Ref Func="StepFSR" />)) </Item>
##  </List>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingFied" />, <C>CharPoly</C>, <Ref Attr="FeedbackVec" />, <Ref Attr="Length" /> and <Ref Attr="OutputTap" />  and the property <C>IsLinearFeedback</C> are set during the 
##  construction of an LFSR. 
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an extension field using a reducible poynomial), an error message appears and the function returns <C>fail</C>.
##  <List>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
#F  LFSR( <m>, <n> )# remove this option coz its hard to tell the difference 
# between LFSR( <p>, <m>, <n>  ) and  LFSR( <m>, <n> , <tap>)
#F  LFSR( <m>, <n> , <tap>) #remove


DeclareGlobalFunction( "LFSR" );


#############################################################################
##
#P  IsLinearFeedback( <lfsr> )
##
##  <#GAPDoc Label="IsLinearFeedback">
##  <ManSection>
##  <Prop Name="IsLinearFeedback" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  If we were to represent the LFSR with a multivariate polynomial, 
##  DegreeOfPolynomial would return 1 - the feedback polynomial is linear
##  (ie. only linear terms are present: monomials with only one variable )
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLinearFeedback", IsFSR );
DeclareSynonym( "IsLFSR", IsFSR and IsLinearFeedback);

#############################################################################
##
#A  CharPoly( <lfsr> )
#A  FeedbackVec, FieldPoly, OutputTap  # moved to fsr.gd!!!
##
##  <#GAPDoc Label="CharPoly">
##  <ManSection>
##  <Attr Name="CharPoly" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  Attribute holding the characteristic polynomial (the feedback polynomial).
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CharPoly", IsLFSR );







#############################################################################
##
#P  IsPeriodic( <lfsr> )
#P  IsUltPeriodic( <lfsr> )
#P  IsMaxSeqLFSR( <lfsr> )
#A  Period( <lfsr> )
#M  PeriodIrreducible( <lfsr> )
#M  PeriodReducible( <lfsr> )
##
##  <#GAPDoc Label="IsPeriodic">
##  <ManSection>
##  <Prop Name="IsPeriodic" Arg='lfsr' Label="for an LFSR"/>
##  <Prop Name="IsUltPeriodic" Arg='lfsr' Label="for an LFSR"/>
##  <Prop Name="IsMaxSeqLFSR" Arg='lfsr' Label="for an LFSR"/>
##  <Attr Name="IsMaxSeqLFSR" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  Properties, attributes and methods concerning the periodicity of the output sequence(s), generated by the LFSR. <P\>
##  Properties:
##  <List>
##  <Item> <C>IsPeriodic</C>: true if constant term of CharPoly <> 0 (8.11 lidl, niederreiter)	</Item>
##  <Item> <C>IsUltPeriodic</C>: true if LFSR (8.7 lidl, niederreiter)	</Item>
##  <Item> <C>IsMaxSeqLFSR</C>: true if CharPoly is primitive (ref???)	</Item>
##  </List>
##  Attributes:
##  <List>
##  <Item> <C>Period</C>: holds the period of the LFSR </Item>
##  </List>
##  Methods to compute the period:
##  <List>
##  <Item> <C>PeriodIrreducible</C>:  </Item>
##  <Item> <C>PeriodReducible</C>:  </Item>
##  </List>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPeriodic", IsLFSR ); # if  constant term of CharPoly <> 0 (8.11 lidl, niederreiter)	
DeclareSynonym( "IsUltPeriodic", IsLFSR ); # if LSFR then always ult.per.   (8.7 lidl, niederreiter)	
DeclareProperty("IsMaxSeqLFSR",  IsLFSR); # if CharPoly primitive (find ref)
DeclareOperation("PeriodIrreducible",  [IsField, IsUnivariatePolynomial, IsPosInt]);
DeclareOperation("PeriodReducible",  [IsField, IsUnivariatePolynomial, IsPosInt]);
DeclareAttribute( "Period", IsLFSR );


#############################################################################
##
#M  ViewObj( <lfsr> )
#M  PrintObj( <lfsr> )
#M  Display( <lfsr> )
#M  PrintAll( <lfsr> )
##
##  <#GAPDoc Label="PrintLFSR">
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