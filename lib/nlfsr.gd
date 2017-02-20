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
##
##  <#GAPDoc Label="NLFSR">
##  <ManSection>
##  <Func Name="NLFSR" Arg="K, clist , mlist, len[, tap]"/>
##  <Func Name="NLFSR" Arg="K, fieldpol, clist , mlist, len[, tap]"/>
##  <Returns>
##  An empty <C>NLFSR</C>  with components <C>init</C>, <C>state</C> and <C>numsteps</C>
##  </Returns>	
##  <Description>
##  Different ways to create an <C>NLFSR</C> oblject, main difference is in creation of the underlying finite field. <P/>
##  NOTE: before creating the <C>NLFSR</C>, we must always create the indeterminates to be used for the feedback using <C>ChooseField</C> function call!!! please see example below <P/>
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field or a prime field)</Item>
##  <Item> <A>fieldpol</A> - defifning polynomial of the extension field (must be irreducible) TO DO </Item>
##  <Item> <A>clist</A> - list of coefficients for the monomials in <A>mlist</A> </Item>
##  <Item> <A>mlist</A> - list of monomials  </Item>
##  <Item> <A>len</A> - length of  <C>NLFSR</C> </Item>
##  <Item> <A>tap</A> - optional parameter: the output tap (must be a positive integer or a list of positive integers)
##  and will be changed to the default S_0 if the specified integer is out of <C>NLFSR</C>range.</Item>
##  </List>
##  NOTE: <A>clist</A>  and <A>mlist</A> must be of same length, all elements in <A>clist</A> must belong to the underlying field. Monomials in <A>mlist</A> 
##  must not include any indeterminates that are out of range specified by <A>len</A>: stages of <C>NLFSR</C>  are represented by indeterminants and the feedback is not allowed to use 
##  a stage that doesnt exist. A second constraint on <A>mlist</A> requires that it must contain at least one monomial of degree <M>></M> 1, otherwise we must create an <C>LFSR</C>. <P/> 
##  Compoents:
##  <List>
##  <Item> <C>init</C> - <A>FFE</A> vector of length n=deg(charpol), storing the initial state of the <C>NLFSR</C>, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>state</C> - <A>FFE</A> vector of length n=deg(charpol), storing the current state of the <C>NLFSR</C>, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>numsteps</C> - the number of steps performed thus far (initialized to -1 when created, set to 0 when loaded using <Ref Meth="LoadFSR" /> and incremented by 1 with each step (using <Ref Meth="StepFSR" />)) </Item>
##  </List>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingFied" />, <C>MultivarPoly</C>, <Ref Attr="FeedbackVec" />, <Ref Attr="IndetList" />, <Ref Attr="Length" /> and <Ref Attr="OutputTap" />  and the property <C>IsNonLinearFeedback</C> are set during the 
##  construction of an <C>NLFSR</C>. 
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an extension field using a reducible poynomial), an error message appears and the function returns <C>fail</C>.
##  <Example>
##  <![CDATA[
##  gap>  F := GF(2);;  clist := [One(F), One(F)];; mlist := [x_0*x_1, x_2];;
##  Error, Variable: 'x_0' must have a value
##  not in any function at line 2 of *stdin*
##  gap>  test := NLFSR(F, clist, mlist, 3);
##  Error, Variable: 'mlist' must have a value
##  not in any function at line 3 of *stdin*
##  gap> ChooseField(F);
##  You can now create an NLFSR with up to 100 stages
##  with up to  100 nonzero terms
##  gap> mlist := [x_0*x_1, x_2];;                                           
##  gap>  test := NLFSR(F, clist, mlist, 3);
##  < empty NLFSR of length 3,
##   given by MultivarPoly = x_0*x_1+x_2> 
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
##  DegreeOfPolynomial greter than 1 sets <C>IsNonLinearFeedback</C> to <E>true</E>.
##  otherwise it prints out a warning that you need to use the <C>LFSR</C> constructor instead. <P/>
##  Filter <C>IsNLFSR</C> is defined as and-filter of <C>IsFSR</C>  and <C>IsNonLinearFeedback</C>. <P/>
##  NOTE: at the same time <C>IsLinearFeedback</C> is set to <E>false</E> (for coding purposes).
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
##  <Attr Name="MultivarPoly" Arg='nlfsr' />
##  <Attr Name="IndetList" Arg='nlfsr' />
##  <Description>
##  <C>MultivarPoly</C> holds the multivariate function defining the feedback of the <C>NLFSR</C>. 
##  <C>IndetList</C> holds all the indeterminates that are present in <C>MultivarPoly</C>
##  and <C>FeedbackVec</C> holds only the nonzero coefficients (as opposed to the <C>LFSR</C>, where 
##  this field holds coefficients for all stages of the <C>FSR</C>). The feedback element is computed from 
##  <C>MultivarPoly</C>, <C>IndetList</C> and <C>state</C>, and not from <C>FeedbackVec</C>.
##  <Example>
##  <![CDATA[
##  gap> MultivarPoly(test); IndetList(test);
##  x_0*x_1+x_2
##  [ 0, 1, 2 ]
##  ]]>
##  </Example> 

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
##  <#GAPDoc Label="ViewObjNLFSR">
##  <ManSection>
##  <Meth Name="ViewObj" Arg='nlfsr  ' />
##  <Meth Name="PrintObj" Arg='nlfsr [,B] ' />
##  <Meth Name="PrintAll" Arg='nlfsr [,B] ' />
##
##  <Description>
##  Different detail on <A>nlfsr</A> created by <Ref Func="NLFSR" />:
##  <List>
##  <Item> <C>Display/View</C>:  show the <C>MultivarPoly</C> and wheter or not the <A>nlfsr</A> is empty</Item>
##  <Item> <C>Print</C>: same as <C>Display/View</C> if <A>nlfsr</A> is empty, otherwise it also shows the values of the three components <C>init</C>, <C>state</C> and <C>numsteps</C></Item>
##  <Item> <C>PrintAll</C>: same as <C>Print</C> if <A>nlfsr</A> is empty, otherwise it also shows the values of the three components <C>init</C>, <C>state</C> and <C>numsteps</C> 
##  with additional information about the underlying field and the tap positions</Item>
##  </List> 
##  Both <C>Print</C> and <C>PrintAll</C> can be used with optional parameter basis <A>B</A> for desiered output format.
##  <Example>
##  <![CDATA[
##  gap> Display(test);                                      
##  < empty NLFSR of length 3,
##   given by MultivarPoly = x_0*x_1+x_2> 
##  gap> PrintAll(test, Basis(UnderlyingField(test)));
##  < empty NLFSR of length 3,
##   given by MultivarPoly = x_0*x_1+x_2>
##  with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
##  with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
##  after initialization 
##  with output from stage S_0
##  ]]>
##  </Example> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation("PrintObj", [IsNLFSR]);
DeclareOperation("PrintObj", [IsNLFSR, IsBasis]);
DeclareOperation("PrintAll", [IsNLFSR]);
DeclareOperation("PrintAll", [IsNLFSR, IsBasis]);



Print("nlfsr.gd OK,\t");