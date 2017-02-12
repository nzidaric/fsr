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
##  An empty &NLFSR; with components <C>init</C>, <C>state</C> and <C>numsteps</C>
##  </Returns>	
##  <Description>
##  Different ways to create an &NLFSR; oblject, main difference is in creation of the underlying finite field.
##  <P/>
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field or a prime field)</Item>
##  <Item> <A>fieldpol</A> - defifning polynomial of the extension field (must be irreducible) TO DO </Item>
##  <Item> <A>clist</A> - list of coefficients for the monomials in <A>mlist</A> </Item>
##  <Item> <A>mlist</A> - list of monomials  </Item>
##  <Item> <A>len</A> - length of  &NLFSR; </Item>
##  <Item> <A>tap</A> - optional parameter: the output tap (must be a positive integer or a list of positive integers)
##  and will be changed to the default S_0 if the specified integer is out of &NLFSR; range.</Item>
##  </List>
##  NOTE: <A>clist</A>  and <A>mlist</A> must be of same length, all elements in <A>clist</A> must belong to the underlying field. Monomials in <A>mlist</A> 
##  must not include any indeterminates that are out of range specified by <A>len</A>: stages of &NLFSR; are represented by indeterminants and the feedback is not allowed to use 
##  a stage that doesnt exist. A second constraint on <A>mlist</A> requires that it must contain at least one monomial of degree $>$ 1, otherwise we must create an &LFSR;. <P/> 
##  Compoents:
##  <List>
##  <Item> <C>init</C> - &FFE; vector of length n=deg(charpol), storing the initial state of the &NLFSR;, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>state</C> - &FFE; vector of length n=deg(charpol), storing the current state of the &NLFSR;, with indeces from n-1, ..., 0</Item> 
##  <Item> <C>numsteps</C> - the number of steps performed thus far (initialized to -1 when created, set to 0 when loaded using <Ref Meth="LoadFSR" /> and incremented by 1 with each step (using <Ref Meth="StepFSR" />)) </Item>
##  </List>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingFied" />, <C>MultivarPoly</C>, <Ref Attr="FeedbackVec" />, <Ref Attr="IndetList" />, <Ref Attr="Length" /> and <Ref Attr="OutputTap" />  and the property <C>IsNonLinearFeedback</C> are set during the 
##  construction of an &NLFSR;. 
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an extension field using a reducible poynomial), an error message appears and the function returns <C>fail</C>.
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
##  <Prop Name="IsNonLinearFeedback" Arg='nlfsr' Label="for an NLFSR"/>
##  <Filt Name="IsNLFSR" Arg='nlfsr' Label="for an NLFSR"/>
##
##  <Description>
##  For the multivariate polynomial given by <A>clist</A>  and <A>mlist</A>, 
##  DegreeOfPolynomial greter than 1 sets <C>IsNonLinearFeedback</C> to <E>true</E>.
##  otherwise it prints out a warning that you need to use the &LFSR; constructor instead. <P/>
##  Filter <C>IsNLFSR</C> is defined as and-filter of <C>IsFSR</C>  and <C>IsNonLinearFeedback</C>. 
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
##  <Attr Name="MultivarPoly" Arg='nlfsr' Label="for an NLFSR"/>
##  <Attr Name="IndetList" Arg='nlfsr' Label="for an NLFSR"/>
##  <Description>
##  <C>MultivarPoly</C> holds the multivariate function defining the feedback of the &NLFSR;. 
##  <C>IndetList</C> holds all the indeterminates that are present in <C>MultivarPoly</C>
##  and <C>FeedbackVec</C> holds only the nonzero coefficients (as opposed to the LFSR, where 
##  this field holds coefficients for all stages of the &FSR;). The feedback element is computed from 
##  <C>MultivarPoly</C>, <C>IndetList</C> and <C>state</C>, and not from <C>FeedbackVec</C>.
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
##  <#GAPDoc Label="ViewObj">
##  <ManSection>
##  <Meth Name="ViewObj" Arg='[B,] nlfsr' Label="for an NLFSR"/>
##  <Meth Name="PrintObj" Arg='[B,] nlfsr' Label="for an NLFSR"/>
##  <Meth Name="PrintAll" Arg='[B,] nlfsr' Label="for an NLFSR"/>
##
##  <Description>
##  Different detail on the &NLFSR; created by <Ref Func="NLFSR" />:
##  <List>
##  <Item> <C>Display/View</C>:  show the <C>MultivarPoly</C> and wheter or not the &NLFSR; is empty</Item>
##  <Item> <C>Print</C>: same as <C>Display/View</C> if &NLFSR; is empty, otherwise it also shows the values of the three components <C>init</C>, <C>state</C> and <C>numsteps</C></Item>
##  <Item> <C>PrintAll</C>: same as <C>Print</C> if &NLFSR; is empty, otherwise it also shows the values of the three components <C>init</C>, <C>state</C> and <C>numsteps</C> 
##  with additional information about the underlying field and the tap positions</Item>
##  </List> 
##  Can be used with optional parameter basis <A>B</A> for desiered output format. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation("PrintObj", [IsNLFSR]);
DeclareOperation("PrintObj", [IsBasis, IsNLFSR]);
DeclareOperation("PrintAll", [IsNLFSR]);
DeclareOperation("PrintAll", [IsBasis, IsNLFSR]);



Print("nlfsr.gd OK,\t");