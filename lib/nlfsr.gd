#############################################################################
##
#W  nlfsr.gd                   GAP Package                   nusa zidaric
##
##



###to do mpoly constructors

#############################################################################
##
#F  NLFSR( <K>, <clist>, <mlist> , <len> )  
##. . . .  create an LFSR object 	# len 4
#F  NLFSR( <K>, <fieldpol>,  <clist>, <mlist> , <len> ) 
## . . . .  create an LFSR object 	# len 5
#F  NLFSR( <K>, <clist>, <mlist> , <len> , <tap>) 
## . . . .  create an LFSR object 	# len 5
#F  NLFSR( <K>, <fieldpol>, <clist>, <mlist> , <len>, <tap> )  
##. . . .  create an LFSR object 	# len 6
##
##  <#GAPDoc Label="NLFSR">
##  <ManSection>
##  <Func Name="NLFSR" Arg='K, mpoly, len[, tap]' />
##  <Func Name="NLFSR" Arg='K, fieldpoly, mpoly, len[, tap]' 
##  Label="with field defining polynomial "/>
##  <Func Name="NLFSR" Arg='K, clist , mlist, len[, tap]' 
##  Label="with clist and mlist"/>
##  <Func Name="NLFSR" Arg='K, fieldpoly, clist , mlist, len[, tap]' 
##  Label="with field defining polynomial"/>
##  <Returns>
##  An empty <C>NLFSR</C>  with components <C>init</C>, <C>state</C>,
##   <C>numsteps</C> and <C>basis</C>.
##  </Returns>	
##  <Description>
##  Function NLFSR provides different ways to create an <C>NLFSR</C> object;   
##  the main differences are in multivariate polynomial specification and in 
##  construction of the underlying finite field. The <C>NLFSR</C> is uniquely 
##  described with a a multivariate polynomial, which is either given directly
##  as <A>mpoly</A> or by two lists: 
##  a list of monomials <A>mlist</A>, and a list of their corresponding 
##  coefficients <A>clist</A>, i.e. <M>mpoly = clist \cdot mlist</M>.
##  Both of lists must always be provided and be of same length. The 
##  creation of a random NLFSR is currently not implemented. <P/>    
##  <!-- NOTE: before creating the <C>NLFSR</C>, we must always create the
##  indeterminates to be used for the feedback using <Ref Func="ChooseField" /> 
##  function call! Please see the example below.-->
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field
##   or a prime field).</Item>
##  <Item> <A>fieldpoly</A> - the defifning polynomial of the extension field 
##  (must be irreducible). </Item>
##  <Item> <A>mpoly</A> - the feedback polynomial. </Item>
##  <Item> <A>clist</A> - the list of coefficients for the monomials in 
##  <A>mlist</A>. </Item>
##  <Item> <A>mlist</A> - the list of monomials.  </Item>
##  <Item> <A>len</A> - the length of <C>NLFSR</C>. The <E>range</E> of the 
##  <C>NLFSR</C> is <M>[0, len -1]</M>.</Item>
##  <Item> <A>tap</A> - an optional parameter: the output tap (a positive
##   integer or a list of positive integers), which will be changed to the  
##  default S_0 if the specified integer(s) fall out of <C>NLFSR</C> range.
##  </Item>
##  </List>
##  NOTE: the lists <A>clist</A> and <A>mlist</A> must be of same length, and 
##  all elements 
##  in <A>clist</A> must belong to the underlying field. Monomials in 
##  <A>mlist</A> must not include any indeterminates that are out of range 
##  specified by <A>len</A>: stages of <C>NLFSR</C> are represented by 
##  indeterminants and the feedback is not allowed to use a stage that doesnt 
##  exist. Currently, 200 variables are available, which puts the maximum length 
##  of the NLFSR too 200 stages. A second constraint on <A>mlist</A> requires 
##  that it must contain at
##  least one monomial of degree <M>>1</M>, otherwise we must create an 
##  <C>LFSR</C>. <P/> 
##  Compoents:
##  <List>
##  <Item> <C>init</C> - <A>FFE</A> vector of length 
##  <M>n=</M>Degree(<A>feedbackpoly</A>), 
##  storing the initial state of the <C>NLFSR</C>, with indices from 
##  <M>n-1, \dots, 0</M>. </Item>
##  <Item> <C>state</C> - <A>FFE</A> vector of length 
##  <M>n=</M>Degree(<A>feedbackpoly</A>), 
##  storing the current state of the <C>NLFSR</C>, with indices from 
##  <M>n-1, \dots, 0</M>. </Item> 
##  <Item> <C>numsteps</C> - the number of steps performed thus far 
##  (initialized to -1 when created, set to 0 when loaded using 
##  <Ref Meth="LoadFSR" /> and incremented by 1 with each step 
##  (using <Ref Meth="StepFSR" />)) </Item>
##  <Item> <C>basis</C> - basis of F over its prime subfield. The component 
##  <C>basis</C> is set to the canonical basis of <A>F</A> over its prime 
##  subfield. None of the <C>NLFSR</C> calls contain the basis as argument: the 
##  basis is set to canonical basis and must be later changed by 
##  <Ref Meth="ChangeBasis"  />.  </Item>
##  </List>
##  <P/> 
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingField" />, 
##  <Ref Attr="MultivarPoly" />, <Ref Attr="FeedbackVec" />, 
##  <Ref Attr="IndetList" />, <Ref Attr="Length" /> and 
##  <Ref Attr="OutputTap" />  and the property 
##  <Ref Prop="IsNonLinearFeedback" /> 
##  are set during the construction of an <C>NLFSR</C>. 
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an
##   extension field using a reducible poynomial), an error message appears and 
##  the function returns <C>fail</C>.
##  <Example>
##  <![CDATA[
##  gap>  F := GF(2);;  clist := [One(F), One(F)];; mlist := [x_0, x_1*x_2];;                                        
##  gap> test := NLFSR(F, clist, mlist, 3);
##  < empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_1*x_2+x_0> 
##  ]]>
##  </Example> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



DeclareGlobalFunction( "NLFSR" );






#############################################################################
##
#P  IsNonLinearFeedback( <nlfsr> )
#F  IsNLFSR( <nlfsr> )
##
##  <#GAPDoc Label="IsNonLinearFeedback">
##  <ManSection>
##  <Prop Name="IsNonLinearFeedback" Arg='nlfsr'/>
##  <Filt Name="IsNLFSR" Arg='nlfsr' />
##
##  <Description>
##  For the multivariate polynomial given by <A>clist</A>  and <A>mlist</A>, 
##  <Ref Meth="DegreeOfPolynomial" /> greter than 1 sets 
##  <C>IsNonLinearFeedback</C> to 
##  <E>true</E>. This property is set during the creation of the <C>NLFSR</C> 
##  using <Ref Func="NLFSR" />, which will print an error message instructing 
##  to use the <Ref Func="LFSR" /> constructor instead. 
##  <P/>
##  The filter <C>IsNLFSR</C> is defined as and-filter of <C>IsFSR</C>  and 
##  <C>IsNonLinearFeedback</C>. 
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
#DeclareProperty( "IsNonLinearFeedback", IsFSR );
#DeclareSynonym( "IsNLFSR", IsFSR and IsNonLinearFeedback);

#############################################################################
##
#A  MultivarPoly( <nlfsr> )
#A  MonomialList(<nlfsr>)
#A  IndetList( <nlfsr> )
##
##  <#GAPDoc Label="MultivarPoly">
##  <ManSection>
##  <Attr Name="MultivarPoly" Arg='nlfsr' />
##  <Attr Name="MonomialList" Arg='nlfsr' />
##  <Attr Name="IndetList" Arg='nlfsr' />
##  <Description>
##  <C>MultivarPoly</C> holds the multivariate function defining 
##  the feedback of the <C>NLFSR</C>. <P/>
##  <C>MonomialList</C> holds a copy of the initial monomial list
##   <C>mlist</C> used to create the <C>NLFSR</C>.<P/> 
##  <C>IndetList</C> holds all 
##  the indeterminates that are present in <C>MultivarPoly</C> and 
##  <C>MonomialList</C>. This list is needed for the computation of the feedback 
##  element, which is computed from <C>MultivarPoly</C>, 
##  <C>IndetList</C> and <C>state</C>, and not from <C>FeedbackVec</C>. 
##  <C>FeedbackVec</C> now holds only the 
##  nonzero coefficients for the monomials instead of stages, i.e., it holds a 
##  copy of the initial coefficients list <C>clist</C>, (as opposed to the 
##  <C>LFSR</C>, where this field holds coefficients for all stages of the 
##  <C>FSR</C>). <P/>
##  Example below shows the values of attributes  <C>MultivarPoly</C>, 
##  <C>MonomialList</C> and <C>IndetList</C>.<P/>
##  <Example>
##  <![CDATA[
##  gap> MultivarPoly(test); MonomialList(test); IndetList(test);
##  x_1*x_2+x_0
##  [ x_0, x_1*x_2 ]
##  [ 0, 1, 2 ]
##  ]]>
##  </Example> 

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MultivarPoly", IsNLFSR );
DeclareAttribute( "MonomialList", IsNLFSR );
DeclareAttribute( "IndetList", IsNLFSR );





#############################################################################
##
#M  ConstTermOfNLFSR( <nlfsr> )
##
##  <#GAPDoc Label="ConstTermOfNLFSR">
##  <ManSection>
##  <Meth Name="ConstTermOfNLFSR" Arg='nlfsr' />
##
##  <Description>
##  Returns the constant term of the multivariate polynomial defining the 
##  feedback function.
##  Example below shows the constant term for two different NLFSR, first the 
##  <A>test</A> example used in previous example, and then the <A>test1</A>
##  example with a different feedback. 
##  <Example>
##  <![CDATA[
##  gap> ConstTermOfNLFSR(test);           
##  0*Z(2)
##  gap> mlist1 := [One(F), x_0, x_1*x_2];; clist1 := [One(F), One(F), One(F)];;
##  gap> test1 := NLFSR(F, clist1, mlist1, 3);                                  
##  < empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_1*x_2+x_0+Z(2)^0> 
##  gap> ConstTermOfNLFSR(test1);                                               
##  Z(2)^0
##  ]]>
##  </Example> 
  
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation( "ConstTermOfNLFSR",  [IsNLFSR]);

Print("nlfsr.gd OK,\t");