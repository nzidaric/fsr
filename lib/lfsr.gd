#############################################################################
##
#W  lfsr.gd                   GAP Package                   nusa zidaric
##
##




#############################################################################
##
#F  LFSR( <K>, <feedbackpoly> )  . . . . . . . . . .  create an LFSR object
#F  LFSR( <K>, <fieldpoly>, <feedbackpoly>)
#F  LFSR( <F>, <feedbackpoly>)
#F  LFSR( <p>, <m>, <n>  )
#F  LFSR( <K>, <feedbackpoly>, <tap> )
#F  LFSR( <K>, <fieldpoly>, <feedbackpoly>, <tap>)
#F  LFSR( <F>, <feedbackpoly>, <tap>)
#F  LFSR( <p>, <m>, <n>, <tap>  )
##  <#GAPDoc Label="LFSR">
##  <ManSection>
##  <Func Name="LFSR" Arg='F, feedbackpoly [, B, tap]' />
##  <Func Name="LFSR" Arg='K, fieldpoly, feedbackpoly [, B, tap]'
##  Label="with field defining polynomial"/>
##  <Func Name="LFSR" Arg='p, m, n [, tap]' Label="as ext. field with LFSR of
##  length n"/>
##  <Returns>
##  An empty <C>LFSR</C> with components <C>init</C>, <C>state</C> ,
##	 <C>numsteps</C> and <C>basis</C>.
##  </Returns>
##  <Description>
##  Function LFSR provides different ways to create an <C>LFSR</C>  object; the  
##  main difference is in the
##  construction of the underlying finite field. The <C>LFSR</C> is uniquely 
##  described with a feedback polynomial <A>feedbackpoly</A>. The call 
##  <C>LFSR(p, m, n)</C> will randomly choose a polynomial of degree <A>n</A>, 
##  which is primitive over the field <M>F_{p^m}</M>, and use it as feedback.    
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field or
##  a prime field).</Item>
##  <Item> <A>B</A> - the basis of <A>F</A> over its prime subfield.</Item>
##  <Item> <A>feedbackpoly</A> - the <C>LFSR</C> defining polynomial. </Item>
##  <Item> <A>fieldpoly</A> - the defining polynomial of the extension field
##  (must be irreducible).</Item>
##  <Item> <A>p</A> - the characteristic.</Item>
##  <Item> <A>m</A> - the degree of extension 
##  (degree of <A>fieldpoly</A>).</Item>
##  <Item> <A>n</A> - the length of the <C>LFSR</C> 
##  (degree of <A>feedbackpoly</A>).</Item>
##  <Item> <A>tap</A> - optional parameter: the output tap (must be a positive
##  integer or a list of
##  positive integers) and will be changed to the default S_0 if the specified
##  integer is out of
##  <C>LFSR</C> range.</Item>
##  </List>
##  Components:
##  <List>
##  <Item> <C>init</C> - <A>FFE</A> vector of length 
##  <M>n=</M>Degree(<A>feedbackpoly</A>),
##  storing the <E>initial</E> state 
##  of the <C>LFSR</C>, with indices from <M>n-1, \dots, 0</M>.</Item>
##  <Item> <C>state</C> - <A>FFE</A> vector of length 
##  <M>n=</M>Degree(<A>feedbackpoly</A>),
##  storing the <E>current</E> state of the <C>LFSR</C>, 
##  with indices from <M>n-1, \dots, 0</M>. </Item>
##  <Item> <C>numsteps</C> - the number of steps performed thus far
##  (initialized to -1 when created, set to 0 when loaded using
##  <Ref Meth="LoadFSR" /> and incremented by 1 with each step (using
##  <Ref Meth="StepFSR" />)). </Item>
##  <Item> <C>basis</C> - basis of F over its prime subfield (if no basis is
##  given this component is set to canonical basis of F over its prime subfield)
##  .</Item>
##  </List>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingField" />,
##  <Ref Attr="FeedbackPoly" />, <Ref Attr="FeedbackVec" />, 
##  <Ref Attr="Length" /> and
##  <Ref Attr="OutputTap" />  and the property <Ref Prop="IsLinearFeedback" /> 
##  are set during the construction of an <C>LFSR</C>.
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create
##  an extension field using a reducible poynomial), an error message appears
##  and the function returns <C>fail</C>.
##  <P/>
##  Example below shows how to create an empty <C>LFSR</C> over <M>F_{2^4}</M>
##  created as extension of <M>F_2</M>, called <E>test</E>, firstly without a
##  specified basis (in which case the canonical basis is used), 
##  and then with basis <A>B</A>:
##  <Example>
##  <![CDATA[
##  gap> test := LFSR(K, f, l);
##  < empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y^3+y+Z(2^4) >
##  gap> WhichBasis(test);
##  CanonicalBasis( GF(2^4) )
##  gap> B := Basis(F, Conjugates(Z(2^4)^3));; test := LFSR(K, f, l, B);
##  < empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y^3+y+Z(2^4) >
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
##  (i.e., only linear terms are present: monomials with only one variable )<P/>
##  Filter <C>IsLFSR</C> is defined as and-filter of <C>IsFSR</C>  and
##  <C>IsLinearFeedback</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
#DeclareProperty( "IsLinearFeedback", IsFSR );
#DeclareSynonym( "IsLFSR", IsFSR and IsLinearFeedback);

#############################################################################
##
#A  FeedbackPoly( <lfsr> )
#A  FeedbackVec, FieldPoly, OutputTap  # moved to fsr.gd!!!
##
##  <#GAPDoc Label="FeedbackPoly">
##  <ManSection>
##  <Attr Name="FeedbackPoly" Arg='lfsr' />
##
##  <Description>
##  Attribute holding the the LFSR feedback polynomial.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "FeedbackPoly", IsLFSR );







#############################################################################
##
#P  IsPeriodic( <lfsr> )
#P  IsUltPeriodic( <lfsr> )
#P  IsMaxSeqLFSR( <lfsr> )
#A  Period( <lfsr> )
#M  PeriodPrimitive( <lfsr> )
#M  PeriodIrreducible( <lfsr> )
#M  PeriodReducible( <lfsr> )
##
##  <#GAPDoc Label="IsPeriodic">
##  <ManSection>
##  <Prop Name="IsPeriodic" Arg='lfsr' />
##  <Prop Name="IsUltPeriodic" Arg='lfsr' />
##  <Prop Name="IsMaxSeqLFSR" Arg='lfsr'/>
##  <Attr Name="Period" Arg='lfsr' />
##  <Meth Name="PeriodPrimitive" Arg='lfsr' />
##  <Meth Name="PeriodIrreducible" Arg='lfsr' />
##  <Meth Name="PeriodReducible" Arg='lfsr' />
##
##  <Description>
##  Properties, attributes and methods concerning the periodicity of the output
##  sequence(s), generated by the <A>lsfr</A>. <P/>
##  Properties:
##  <List>
##  <Item> <C>IsPeriodic</C>: true if constant term of <C>FeedbackPoly</C> != 0
##  (8.11 lidl, niederreiter).	</Item>
##  <Item> <C>IsUltPeriodic</C>: true if <C>IsLFSR</C> is true
##  (8.7 lidl, niederreiter)	</Item>
##  <Item> <C>IsMaxSeqLFSR</C>: true if <C>FeedbackPoly</C> is primitive
##  (10.2.36 mullen,panario).	</Item>
##  </List>
##  Attributes:
##  <List>
##  <Item> <C>Period</C>: holds the period of the LFSR. </Item>
##  </List>
##  Methods to compute the period:
##  <List>
##  <Item> <C>PeriodPrimitive</C>: computed as <M>q^n-1</M>, where <M>F_q</M> is
##  the underlying finite field and 
##  <M>n=Degree(</M>FeedbackPoly<M>(</M><A>lfsr</A><M>))</M>. </Item>
##  <Item> <C>PeriodIrreducible</C>: <M>Order(\omega)</M> where <M>\omega</M> 
##  is a root of FeedbackPoly(<A>lfsr</A>) (2.1.53 mullen,panario).
##	 </Item>
##  <Item> <C>PeriodReducible</C>: for FeedbackPoly(<A>lfsr</A>) =
##	 <M>a\prod {f_i}^{bi}</M>, the order is given by <M>ep^t</M>,
##  where <M>p</M> is the characteristic of the underlying finite field,
##  <M>e = Lcm(ord(f_i))</M> and <M>t</M> is the smallest integer such that
##  <M>p^t\geq max(b_i)</M> (2.1.55 mullen,panario).</Item>
##  </List>
##  Although the last method should compute the period correctly for all
##  three cases, it is computationally more demanding, hence the first two 
##  methods are used when applicable. <P/>
##  Elxample below shows a LFSR called <C>test</C> using a reducible feedback 
##  polynomial <M>\ell = y^4 + y + \alpha=(y^2+y+\alpha^7)(y^2+y+\alpha^9)</M>,
##  where <M>\alpha = Z(2^4)</M>, with period <M>(2^4)^2 - 1 = 255</M>.
##  Next, the period of an LFSR <C>test1</C> with a primitive feedback 
##  polynomial <M>\ell=y^4+y^3+y+\alpha</M>, where <M>\alpha = Z(2^4)</M>, with 
##  maximum period <M>(2^4)^4-1=65535</M>; the LFSR <C>test1</C> will produce 
##  an <M>m</M>-sequence.
##  <Example>
##  <![CDATA[
##  gap> l := y^4 + y + Z(2^4);; test := LFSR(K, f, l);
##  < empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
##  gap> Period(test); IsMaxSeqLFSR(test);
##  255
##  false
##  gap> l := y^4 + y^3 + y + Z(2^4);; test1 := LFSR(K, f, l, B);
##  < empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y^3+y+Z(2^4) >
##  gap> Period(test1); IsMaxSeqLFSR(test1);
##  65535
##  true
##  ]]>
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPeriodic", IsLFSR );
 # if  constant term of FeedbackPoly <> 0 (8.11 lidl, niederreiter)
DeclareSynonym( "IsUltPeriodic", IsLFSR );
# if LSFR then always ult.per.   (8.7 lidl, niederreiter)
DeclareProperty("IsMaxSeqLFSR",  IsLFSR);
# if FeedbackPoly primitive (find ref)
#DeclareOperation("PeriodIrreducible",
#[IsField, IsUnivariatePolynomial, IsPosInt]);

DeclareOperation("PeriodPrimitive",  [IsField, IsUnivariatePolynomial]);
DeclareOperation("PeriodIrreducible",  [IsField, IsUnivariatePolynomial]);
DeclareOperation("PeriodReducible",  [IsField, IsUnivariatePolynomial]);
DeclareAttribute("Period", IsLFSR );






Print("lfsr.gd OK,\t");
