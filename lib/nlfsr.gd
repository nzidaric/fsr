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
##  <Func Name="NLFSR" Arg='F, mpoly, len[, tap]' />
##  <Func Name="NLFSR" Arg='F, fieldpoly, mpoly, len[, tap]'
##  Label="with field defining polynomial "/>
##  <Func Name="NLFSR" Arg='F, clist , mlist, len[, tap]'
##  Label="with clist and mlist"/>
##  <Func Name="NLFSR" Arg='F, fieldpoly, clist , mlist, len[, tap]'
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
##  function call! Please see the example below. <P/>-->
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
##  exist. Currently, 200 variables <M>x_k</M> are available, which puts the
##  maximum length
##  of the NLFSR too 200 stages. A second constraint on <A>mlist</A> (and
##  <A>mploy</A>) requires that it must contain at
##  least one monomial of degree <M>>1</M>, otherwise we must create an
##  <C>LFSR</C>. In addition, if <A>mpoly</A> or <A>mlist</A> contains only
##  one variable, and error is triggered, suggesting to use the <C>LFSR</C>
##  instead.<P/>
##  Components:
##  <List>
##  <Item> <C>init</C> - a vector of length <A>len</A>,
##  storing the <E>initial</E> state
##  of the <C>NLFSR</C> <M>S_{len-1}, \dots, S_0</M>.
##  Can be a vector of FFEs and/or symbols <M>s_0,\dots,s_{199}</M>.
##  </Item>
##  <Item> <C>state</C> - a vector of length <A>len</A>,
##  storing the <E>current</E> state of the <C>NLFSR</C>
##  <M>S_{len-1}^{ns}, \dots, S_0^{ns}</M>, where <M>ns</M>=<C>numsteps</C>.
##  Can be a vector of FFEs and/or symbols <M>s_0,\dots,s_{199}</M>.
##  </Item>
##  <Item> <C>numsteps</C> - the number of steps performed thus far
##  (initialized to -1 when created, set to 0 when loaded using
##  <Ref Meth="LoadFSR" /> and incremented by 1 with each step (using
##  <Ref Meth="StepFSR" />)). </Item>
##  <Item> <C>basis</C> - basis of F over its prime subfield (if no basis is
##  given this component is set to canonical basis of F over its prime subfield)
##  .</Item>
##  <Item> <C>sym</C> - set to <C>false</C> by default. This component is updated
##  each time the NLFSR is loaded or clocked. If a symbol <M>s_k</M> enters the
##  <C>state</C>, either through loading or an external step, this component is
##  set <C>true</C>.</Item>
##  </List>

##  Attributes <Ref Attr="FieldPoly" />, <Ref Attr="UnderlyingField" />,
##  <Ref Attr="MultivarPoly" />, <Ref Attr="MonomialList" />,
##  <Ref Attr="IndetList" />,  <Ref Attr="FeedbackVec" />, <Ref Attr="Length" />
##  and <Ref Attr="OutputTap" />  and the property  <C>IsNonLinearFeedback</C>
##  <!--<Ref Prop="IsNonLinearFeedback" />  -->
##  are set during the construction of an <C>NLFSR</C>.
##  <P/>
##  If there is something wrong with the arguments (e.g. attempting to create an
##   extension field using a reducible poynomial), an error message appears and
##  the function returns <C>fail</C>.
##  <Example>
##  <![CDATA[
##  gap> test := NLFSR(GF(2), x_0*x_3*x_1 + x_2, 5);
##  < empty NLFSR of length 5 over GF(2),
##     given by MultivarPoly = x_0*x_1*x_3+x_2>
##  gap> clist := [One(F), One(F)];; mlist := [x_0, x_1*x_2];;
##  gap> test := NLFSR(GF(2), clist, mlist, 3);
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
##  For the multivariate polynomial  defining the  <C>NLFSR</C>,
##  <Ref Meth="DegreeOfPolynomialOverField" /> greter than 1 sets
##  <C>IsNonLinearFeedback</C> to
##  <E>true</E>. This property is set during the creation of the <C>NLFSR</C>
##  using <Ref Func="NLFSR" />, which will print an error message instructing
##  to use the <Ref Func="LFSR" /> constructor instead.
##  <P/>
##  The filter <C>IsNLFSR</C> is defined as and-filter of <C>IsFSR</C>  and
##  <C>IsNonLinearFeedback</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
## MOVED to fsr.gd
#DeclareProperty( "IsNonLinearFeedback", IsFSR );
#DeclareSynonym( "IsNLFSR", IsFSR and IsNonLinearFeedback);

#############################################################################
##
#A  MultivarPoly( <nlfsr> )
#A  MonomialList(<nlfsr>)
#A  IndetList( <nlfsr> )
##
##
DeclareAttribute( "MultivarPoly", IsNLFSR );
DeclareAttribute( "MonomialList", IsNLFSR );
DeclareAttribute( "IndetList", IsNLFSR );




Print("nlfsr.gd OK,\t");
