#############################################################################
##
#W  fsrfil.gd                   GAP Package                   nusa zidaric
##
##





#############################################################################
##
#F  NLFSR( <K>, <clist>, <mlist> , <len> )  
##. . . .  create an LFSR object 	# len 4
#F  NLFSR( <K>, <fieldpol>,  <clist>, <mlist> , <len> ) 
## . . . .  create an LFSR object 	# len 5
##
##  <#GAPDoc Label="FSRFIL">
##  <ManSection>
##  <Func Name="FSRFIL" Arg='F, clist , mlist, len' />
##  <Func Name="FSRFIL" Arg='F, fieldpoly, clist , mlist, len' 
##  Label="with field defining polynomial"/>
##  <Returns>
##  An empty <C>FSRFIL</C>  with components <C>init</C>, <C>state</C>,
##   <C>numsteps</C> and <C>basis</C>. 
##  </Returns>	
##  <Description>
##  Function FSRFIL provides two ways to create an <C>FSRFIL</C> object;    
##  they differ in the way the underlying finite field is constructed.
##  The <C>FSRFIL</C> is uniquely 
##  described with a a multivariate polynomial, which is given by two lists: 
##  a list of monomials <A>mlist</A>, and a list of their corresponding 
##  coefficients <A>clist</A>, just as is requiered by the 
##  <Ref Func="NLFSR" /> function. <P/>    
##  NOTE: before creating the <C>FSRFIL</C>, we must always create the
##  indeterminates to be used for the feedback using <Ref Func="ChooseField" /> 
##  function call!
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field
##   or a prime field).</Item>
##  <Item> <A>fieldpoly</A> - the defifning polynomial of the extension field 
##  (must be irreducible). </Item>
##  <Item> <A>clist</A> - the list of coefficients for the monomials in 
##  <A>mlist</A>. </Item>
##  <Item> <A>mlist</A> - the list of monomials.  </Item>
##  </Item>
##  </List>
##  NOTE: the lists <A>clist</A> and <A>mlist</A> must be of same length, and 
##  all elements 
##  in <A>clist</A> must belong to the underlying field. Indetermincates in  
##  <A>mlist</A> define the length of components <C>init</C> and <C>state</C>. 
##  <P/> 
##  Compoents: because of similarities between with the <C>NLFSR</C>, it is 
##  convenient to be able to reuse the allready existing functions. Hence, the  
##  <C>FSRFIL</C> is a member of the FSRFamily
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
##  Error, Variable: 'x_0' must have a value
##  not in any function at line 2 of *stdin*
##  gap> test := NLFSR(F, clist, mlist, 3);
##  Error, Variable: 'mlist' must have a value
##  not in any function at line 3 of *stdin*
##  brk> quit;
##  gap> ChooseField(F);
##  You can now create an NLFSR with up to 200 stages
##  with up to  200 nonzero terms
##  gap> mlist := [x_0, x_1*x_2];;                                          
##  gap> test := NLFSR(F, clist, mlist, 3);
##  < empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_1*x_2+x_0> 
##  ]]>
##  </Example> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



DeclareGlobalFunction( "FSRFIL" );






#############################################################################
##
#P  IsFSRFilter( <fsrfil> )
#F  IsFSRFIL( <fsrfil> )
##
##  <#GAPDoc Label="IsFSRFilter">
##  <ManSection>
##  <Prop Name="IsFSRFilter" Arg='fsrfil'/>
##  <Filt Name="IsFSRFIL" Arg='fsrfil' />
##
##  <Description>
##  <C>IsFSRFilter</C> is set to <E>true</E> at the creation time of the 
##  <C>FSRFIL</C>, and at the same time, properties <C>IsLinearFeedback</C> and 
##  <C>IsNonLinearFeedback</C> are set to <E>false</E> to differentiate the 
##  FSRFIL from LFSR and NLFSR. The filter <C>IsFSRFIL</C> is defined as 
##  and-filter of <C>IsFSR</C> and <C>IsFSRFilter</C>.
##  <P/>
##  For the multivariate polynomial given by <A>clist</A>  and <A>mlist</A>, 
##  the <Ref Meth="DegreeOfPolynomial" /> sets the values for  
##  <C>IsNonLinearFSRFilter</C> and <C>IsLinearFSRFilter</C>   
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
 



DeclareProperty( "IsLinearFSRFilter", IsFSRFIL);
DeclareProperty( "IsNonLinearFSRFilter", IsFSRFIL );

#############################################################################
##
#A  MultivarPoly( <fsrfil> )
#A  MonomialList(<fsrfil>)
#A  IndetList( <fsrfil> )
##
##  <#GAPDoc Label="MultivarPoly">
##  <ManSection>
##  <Attr Name="MultivarPoly" Arg='fsrfil' />
##  <Attr Name="MonomialList" Arg='fsrfil' />
##  <Attr Name="IndetList" Arg='fsrfil' />
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
DeclareAttribute( "MultivarPoly", IsFSRFIL );
DeclareAttribute( "MonomialList", IsFSRFIL );
DeclareAttribute( "IndetList", IsFSRFIL );





#############################################################################
##
#M  ConstTermOfNLFSR( <fsrfil> )
##
##  <#GAPDoc Label="ConstTermOfNLFSR">
##  <ManSection>
##  <Meth Name="ConstTermOfNLFSR" Arg='fsrfil' />
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

DeclareOperation( "ConstTermOfFSRFIL",  [IsFSRFIL]);

Print("fsrfil.gd OK,\t");