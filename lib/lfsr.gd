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
##  <Func Name="LFSR" Arg="F, charpol [, B, tap]"/>
##  <Func Name="LFSR" Arg="K, fieldpol, charpol [, B, tap]"/>
##  <Func Name="LFSR" Arg="F, charpol [, B, tap]"/>
##  <Func Name="LFSR" Arg="p, m, n [, tap]"/>
##  <Returns>
##  An empty <C>LFSR</C> with components <C>init</C>, <C>state</C> , <C>numsteps</C> and <C>basis</C>
##  </Returns>	
##  <Description>
##  Different ways to create an <C>LFSR</C>  oblject, main difference is in creation of the underlying 
##  finite field.
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field or a prime field)</Item>
##  <Item> <A>B</A> - basis of F over its prime subfield</Item>
##  <Item> <A>charpol</A> - <C>LFSR</C> dfining polynomial </Item>
##  <Item> <A>fieldpol</A> - defifning polynomial of the extension field (must be irreducible)</Item>
##  <Item> <A>p</A> - characteeristic </Item>
##  <Item> <A>m</A> - degree of extension (degree of <A>fieldpol</A>) </Item>
##  <Item> <A>n</A> - length of  <C>LFSR</C> (degree of <A>charpoly</A>)</Item>
##  <Item> <A>tap</A> - optional parameter: the output tap (must be a positive integer or a list of 
##  positive integers) and will be changed to the default S_0 if the specified integer is out of 
##  <C>LFSR</C> range.</Item>
##  </List>
##  Compoents:
##  <List>
##  <Item> <C>init</C> - <A>FFE</A> vector of length n=deg(charpol), storing the initial state of the 
##						<C>LFSR</C>, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>state</C> - <A>FFE</A> vector of length n=deg(charpol), storing the current state of the 
##						<C>LFSR</C>, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>numsteps</C> - the number of steps performed thus far (initialized to -1 when created, 
##					set to 0 when loaded using <Ref Meth="LoadFSR" /> and incremented by 1 with each step
##					 (using <Ref Meth="StepFSR" />)) </Item>
##  <Item> <C>basis</C> - basis of F over its prime subfield (if no basis is given this field is set
##				 to canonical basis of F over its prime subfield) </Item>
##  </List>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingFied" />, <C>CharPoly</C>, 
##  <Ref Attr="FeedbackVec" />, <Ref Attr="Length" /> and <Ref Attr="OutputTap" />  and the property 
##  <C>IsLinearFeedback</C> are set during the construction of an<C>LFSR</C>. 
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an extension field using 
##  a reducible poynomial), an error message appears and the function returns <C>fail</C>.<P/>
##  Example below shows how to create an empty <C>LFSR</C> over <M>F_{2^4}</M> created as extension of
##  <M>F_2</M>, called <E>test</E>, firstly without a specified basis, and then with basis <A>B</A>:
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");;
##  gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; 
##  gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
##  gap> test := LFSR(K, f, l);
##  < empty LFSR given by CharPoly = y^4+y+Z(2^4)>
##  gap> WhichBasis(test);
##  CanonicalBasis( GF(2^4) )
##  gap> B := Basis(F, Conjugates(Z(2^4)^3));;  
##  gap> test := LFSR(K, f, l, B);
##  < empty LFSR given by CharPoly = y^4+y+Z(2^4)>
##  gap> WhichBasis(test);        
##  Basis( GF(2^4), [ Z(2^4)^3, Z(2^4)^6, Z(2^4)^12, Z(2^4)^9 ] )
##  ]]>
##  </Example> 

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
##  <Prop Name="IsLinearFeedback" Arg='lfsr' />
##  <Filt Name="IsLFSR" Arg='lfsr'/>
##
##  <Description>
##  If we were to represent the <A>lsfr</A> with a multivariate polynomial, 
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
##  <Attr Name="CharPoly" Arg='lfsr'/>
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
##  <Prop Name="IsPeriodic" Arg='lfsr' />
##  <Prop Name="IsUltPeriodic" Arg='lfsr' />
##  <Prop Name="IsMaxSeqLFSR" Arg='lfsr'/>
##  <Attr Name="Period" Arg='lfsr' />
##  <Meth Name="PeriodIrreducible" Arg='lfsr' />
##  <Meth Name="PeriodReducible" Arg='lfsr' />
##
##  <Description>
##  Properties, attributes and methods concerning the periodicity of the output sequence(s), generated 
##  by the <A>lsfr</A>. <P/>
##  Properties:
##  <List>
##  <Item> <C>IsPeriodic</C>: true if constant term of <C>CharPoly</C> != 0 (8.11 lidl, niederreiter)	
## 				</Item>
##  <Item> <C>IsUltPeriodic</C>: true if <C>IsLFSR</C> is true (8.7 lidl, niederreiter)	</Item>
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
DeclareOperation("PeriodIrreducible",  [IsField, IsUnivariatePolynomial]);
DeclareOperation("PeriodReducible",  [IsField, IsUnivariatePolynomial]);
DeclareAttribute( "Period", IsLFSR );






Print("lfsr.gd OK,\t");