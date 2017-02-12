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
##  An empty &LFSR; with components <C>init</C>, <C>state</C> and <C>numsteps</C>
##  </Returns>	
##  <Description>
##  Different ways to create an &LFSR; oblject, main difference is in creation of the underlying finite field.
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field or a prime field)</Item>
##  <Item> <A>charpol</A> - &LFSR; dfining polynomial </Item>
##  <Item> <A>fieldpol</A> - defifning polynomial of the extension field (must be irreducible)</Item>
##  <Item> <A>p</A> - characteeristic </Item>
##  <Item> <A>m</A> - degree of extension (degree of <A>fieldpol</A>) </Item>
##  <Item> <A>n</A> - length of  &LFSR; (degree of <A>charpoly</A>)</Item>
##  <Item> <A>tap</A> - optional parameter: the output tap (must be a positive integer or a list of positive integers)
##  and will be changed to the default S_0 if the specified integer is out of LFSR range.</Item>
##  </List>
##  Compoents:
##  <List>
##  <Item> <C>init</C> - &FFE; vector of length n=deg(charpol), storing the initial state of the &LFSR;, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>state</C> - &FFE; vector of length n=deg(charpol), storing the current state of the &LFSR;, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>numsteps</C> - the number of steps performed thus far (initialized to -1 when created, set to 0 when loaded using <Ref Meth="LoadFSR" /> and incremented by 1 with each step (using <Ref Meth="StepFSR" />)) </Item>
##  </List>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingFied" />, <C>CharPoly</C>, <Ref Attr="FeedbackVec" />, <Ref Attr="Length" /> and <Ref Attr="OutputTap" />  and the property <C>IsLinearFeedback</C> are set during the 
##  construction of an &LFSR;. 
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an extension field using a reducible poynomial), an error message appears and the function returns <C>fail</C>.
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
#F  IsLFSR( <lfsr> )
##
##  <#GAPDoc Label="IsLinearFeedback">
##  <ManSection>
##  <Prop Name="IsLinearFeedback" Arg='lfsr' Label="for an LFSR"/>
##  <Filt Name="IsLFSR" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  If we were to represent the &LFSR; with a multivariate polynomial, 
##  DegreeOfPolynomial would return 1 - the feedback polynomial is linear and
##  <C>IsLinearFeedback</C> is set to <E>true</E>. 
##  (ie. only linear terms are present: monomials with only one variable )<P/>
##  Filter <C>IsLFSR</C> is defined as and-filter of <C>IsFSR</C>  and <C>IsLinearFeedback</C>. 
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
##  <Meth Name="PeriodIrreducible" Arg='lfsr' Label="for an LFSR"/>
##  <Meth Name="PeriodReducible" Arg='lfsr' Label="for an LFSR"/>
##
##  <Description>
##  Properties, attributes and methods concerning the periodicity of the output sequence(s), generated by the &LFSR;. <P/>
##  Properties:
##  <List>
##  <Item> <C>IsPeriodic</C>: true if constant term of <C>CharPoly</C> != 0 (8.11 lidl, niederreiter)	</Item>
##  <Item> <C>IsUltPeriodic</C>: true if &LFSR; (8.7 lidl, niederreiter)	</Item>
##  <Item> <C>IsMaxSeqLFSR</C>: true if <C>CharPoly</C> is primitive (ref???)	</Item>
##  </List>
##  Attributes:
##  <List>
##  <Item> <C>Period</C>: holds the period of the &LFSR; </Item>
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
##  <#GAPDoc Label="ViewObj">
##  <ManSection>
##  <Meth Name="ViewObj" Arg='[B,] lfsr' Label="for an LFSR"/>
##  <Meth Name="PrintObj" Arg='[B,] lfsr' Label="for an LFSR"/>
##  <Meth Name="PrintAll" Arg='[B,] lfsr' Label="for an LFSR"/>
##
##  <Description>
##  Different detail on the &LFSR; created by <Ref Func="LFSR" />:
##  <List>
##  <Item> <C>Display/View</C>:  show the <C>CharPoly</C> and wheter or not the &LFSR; is empty</Item>
##  <Item> <C>Print</C>: same as <C>Display/View</C> if &LFSR; is empty, otherwise it also shows the values of the three components <C>init</C>, <C>state</C> and <C>numsteps</C></Item>
##  <Item> <C>PrintAll</C>: same as <C>Print</C> if &LFSR; is empty, otherwise it also shows the values of the three components <C>init</C>, <C>state</C> and <C>numsteps</C> 
##  with additional information about the underlying field and the tap positions</Item>
##  </List> 
##  Can be used with optional parameter basis <A>B</A> for desiered output format. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("PrintObj", [IsLFSR]);
DeclareOperation("PrintObj", [IsBasis, IsLFSR]);
DeclareOperation("PrintAll", [IsLFSR]);
DeclareOperation("PrintAll", [IsBasis, IsLFSR]);



Print("lfsr.gd OK,\t");