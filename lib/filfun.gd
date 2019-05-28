#############################################################################
##
#W  filfun.gd                   GAP Package                   nusa zidaric
##
##





#############################################################################
##
#F  FILFUN( <K>, <mpoly>  )   . . . . . . . . . . . . . create  FILFUN # len 2
#F  FILFUN( <K>, <clist>, <mlist>  )  . . . . . . . . . create  FILFUN # len 3
#F  FILFUN( <K>, <fieldpol>, <clist>, <mlist> ,)  . . . create  FILFUN # len 4
##
##  <#GAPDoc Label="FILFUN">
##  <ManSection>
##  <Func Name="FILFUN" Arg='F, mpoly' />
##  <Func Name="FILFUN" Arg='F, clist , mlist'
##  Label="with clist and mlist"/>
##  <Func Name="FILFUN" Arg='F, fieldpoly, clist , mlist'
##  Label="with field defining polynomial"/>
##  <Returns>
##  An empty <C>FILFUN</C>  with components <C>init</C>, <C>state</C>,
##   <C>numsteps</C> and <C>basis</C>.
##  </Returns>
##  <Description>
##  Function FILFUN provides four ways to create an <C>FILFUN</C> object;
##  they differ in the way the underlying finite field is constructed and/or
##  in the way the multivariate polynomial is defined.
##  The <C>FILFUN</C> is uniquely
##  described with a a multivariate polynomial <C>mpoly</C>. It can also be
##  given by two lists:
##  a list of monomials <A>mlist</A>, and a list of their corresponding
##  coefficients <A>clist</A>, just as is requiered by the
##  <Ref Func="NLFSR" /> function. <P/>
##  <!--NOTE: before creating the <C>FILFUN</C>, we must always create the
##  indeterminates to be used for the feedback using <Ref Func="ChooseField" />
##  function call!  <P/>  -->
##  Inputs:
##  <List>
##  <Item> <A>F</A> - the underlying finite field (either an extension field
##   or a prime field).</Item>
##  <Item> <A>fieldpoly</A> - the defifning polynomial of the extension field
##  (must be irreducible). </Item>
##  <Item> <A>mpoly</A> - the multivariate polynomial. </Item>
##  <Item> <A>clist</A> - the list of coefficients for the monomials in
##  <A>mlist</A>. </Item>
##  <Item> <A>mlist</A> - the list of monomials.  </Item>
##  </List>
##  NOTE: the lists <A>clist</A> and <A>mlist</A> must be of same length, and
##  all elements
##  in <A>clist</A> must belong to the underlying field. Indetermincates in
##  <A>mlist</A> define the length of components <C>init</C> and <C>state</C>.
##  <P/>
##  Compoents: because of similarities between with the <C>NLFSR</C>, it is
##  convenient to be able to reuse the allready existing functions. Hence, the
##  <C>FILFUN</C> is a member of the FSRFamily
##  <List>
##  <Item> <C>init</C> - unused, but kept for similarity with (N)LFSRs</Item>
##  <Item> <C>state</C> - a vector of length <M>n</M>, where <M>n</M> is the
##  number of distinct indeterminates that appear in <A>mpoly</A> or
##  <A>mlist</A> respectively,
##  storing the <E>current</E> state of the <C>FILFUN</C>.
##  Can be a vector of FFEs and/or symbols <M>s_0,\dots,s_{199}</M>.</Item>
##  <Item> <C>numsteps</C> - unused, but kept for similarity with (N)LFSRs</Item>
##  <Item> <C>basis</C> - basis of F over its prime subfield. The component
##  <C>basis</C> is set to the canonical basis of <A>F</A> over its prime
##  subfield. None of the <C>FILFUN</C> calls contain the basis as argument: the
##  basis is set to canonical basis and must be later changed by
##  <Ref Meth="ChangeBasis"  />.  </Item>
##  <Item> <C>sym</C> - set to <C>false</C> by default. This component is updated
##  each time the FILFUN is loaded or a step is performed.
##  If a symbol <M>s_k</M> enters the
##  <C>state</C>, either through loading or an external step, this component is
##  set <C>true</C>.</Item>
##  </List>
##  <P/>
##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingField" />,
##  <Ref Attr="MultivarPoly" />, <Ref Attr="MonomialList" />,
##  <Ref Attr="IndetList" />,  <Ref Attr="FeedbackVec" />, <Ref Attr="Length" />
##   and the properties
##  <C>IsNonLinearFSRFilter</C> and <C>IsLinearFSRFilter</C>
##  are set during the construction of an <C>FILFUN</C>.
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an
##   extension field using a reducible poynomial), an error message appears and
##  the function returns <C>fail</C>.
##  <Example>
##  <![CDATA[
##  gap> test := FILFUN(GF(2) , x_0 +x_1*x_2);
##  < FILFUN of length 3 over GF(2),
##  with the MultivarPoly = x_1*x_2+x_0>
##  ]]>
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##


DeclareGlobalFunction( "FILFUN" );


#############################################################################
##
#P  IsFSRFilter(<filfun>)
#P  IsLinearFSRFilter( <filfun> )
#P  IsNonLinearFSRFilter( <filfun> )
##
##  <#GAPDoc Label="IsFSRFilter">
##  <ManSection>
##  <Prop Name="IsFSRFilter" Arg='filfun'/>
##  <Filt Name="IsFILFUN" Arg='filfun' />
##  <Prop Name="IsLinearFSRFilter" Arg='filfun'/>
##  <Filt Name="IsNonLinearFSRFilter" Arg='filfun' />
##
##  <Description>
##  <C>IsFSRFilter</C> is set to <E>true</E> at the creation time of the
##  <C>FILFUN</C>, and at the same time, properties <C>IsLinearFeedback</C> and
##  <C>IsNonLinearFeedback</C> are set to <E>false</E> to differentiate the
##  FILFUN from LFSR and NLFSR. The filter <C>IsFILFUN</C> is defined as
##  and-filter of <C>IsFSR</C> and <C>IsFSRFilter</C>.
##  <P/>
##  For the multivariate polynomial given defining <A>filfun</A>,
##  the <Ref Meth="DegreeOfPolynomialOverField" /> sets the values for
##  <C>IsNonLinearFSRFilter</C> and <C>IsLinearFSRFilter</C>.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##

DeclareProperty( "IsLinearFSRFilter", IsFILFUN);
DeclareProperty( "IsNonLinearFSRFilter", IsFILFUN );

#############################################################################
##
#A  MultivarPoly( <filfun> )
#A  MonomialList(<filfun>)
#A  IndetList( <filfun> )
##
##  <#GAPDoc Label="MultivarPoly">
##  <ManSection>
##  <Attr Name="MultivarPoly" Arg='x'   />
##  <Attr Name="MonomialList" Arg='x'  />
##  <Attr Name="IndetList" Arg='x'  />
##  <Description>
##  These attributes are set for NLFSR and FILFUN objects at the time of their
##  creation, i.e. <A>x</A> is either an NLFSR or a FILFUN.<P/>
##  <C>MultivarPoly</C> holds the multivariate function defining
##  the feedback of the <C>NLFSR</C> or the  <C>FILFUN</C>. <P/>
##  <C>MonomialList</C> holds a copy of the initial monomial list
##   <C>mlist</C> used to create <A>x</A>.<P/>
##  <C>IndetList</C> holds all
##  the indeterminates that are present in <C>MultivarPoly</C> and
##  <C>MonomialList</C>. This list is needed for the computation of the feedback
##  for the NLFSR and the output element for the FILFUN,
##  which is in both cases computed from <C>MultivarPoly</C>,
##  <C>IndetList</C> and <C>state</C>, and not from <C>FeedbackVec</C>.
##  <P/>
##  Example below shows the values of attributes  <C>MultivarPoly</C>,
##  <C>MonomialList</C> and <C>IndetList</C> for an NLFSR.<P/>
##  <Example>
##  <![CDATA[
##  gap> nlfsr := NLFSR(GF(2), x_0+x_1*x_2, 3);;
##  gap> MultivarPoly(nlfsr); MonomialList(nlfsr); IndetList(nlfsr);
##  x_1*x_2+x_0
##  [ x_1*x_2, x_0 ]
##  [ 1, 2, 0 ]
##  ]]>
##  </Example>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MultivarPoly", IsFILFUN );
DeclareAttribute( "MonomialList", IsFILFUN );
DeclareAttribute( "IndetList", IsFILFUN );



Print("filfun.gd OK,\t");
