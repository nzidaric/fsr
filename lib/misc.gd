#############################################################################
##
#W  misc.gd                   GAP Package                   nusa zidaric
##
##
#############################################################################
##
#F  ChooseField( <F> )
##
##  choose the underlying finite field for the NLFSR
##
##
##  <#GAPDoc Label="ChooseField">
##  <ManSection>
##  <Func Arg="F" Name="ChooseField"  />
##  <Description>
##  Workaround for the <C>NLFSR</C> object definition: we need to fix the
##  chosen underlying finite
##  field and prepare indeterminates in the chosen field.
##  The indeterminates will be used for the multivariable polynomial, which will
##  define the <C>NLFSR</C> feedback.
##  The current threshold is set by global <C>MaxNLFSRLen</C> = 200. <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#
DeclareGlobalFunction( "ChooseField" );

#############################################################################
##
#O  TrimLeadCoeff(<coefs>) 			Trim the leading coefficient
##
##  <#GAPDoc Label="TrimLeadCoeff">
##  <ManSection>
##  <Meth Name="TrimLeadCoeff" Arg='F, poly'  Label="for an LFSR"/>
##  <Meth Name="IdxNonzeroCoeffs" Arg='F, poly'  Label="for an LFSR"/>
##  <Meth Name="NrNonzeroCoeffs" Arg='F, poly'  Label="for an LFSR"/>
##  <Description>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "TrimLeadCoeff",  [IsFFECollection and IsRowVector]);
DeclareOperation( "IdxNonzeroCoeffs",  [IsFFECollection and IsRowVector]);
DeclareOperation( "NrNonzeroCoeffs",  [IsFFECollection and IsRowVector]);





#############################################################################
##
#O  LeadingTerm(<F>, <poly>) 			
##
##  <#GAPDoc Label="LeadingTerm">
##  <ManSection>
##  <Meth Name="LeadingTerm" Arg='F, poly' />
##  <Meth Name="TermOverField" Arg='F, poly'   />
##  <Meth Name="MonomialOverField" Arg='F, poly'   />
##
##  <Description>
##  All methods in this section work for both, univariate and multivariate 
##  polynomials. 
##  <C>LeadingTerm</C> returns the leading term of polynomial 
##  <A>poly</A>, i.e., it returns the leading monomial together with its
##  coefficient, but checks if the coefficient belongs to the field <A>F</A>. 
##  The powers of the indeterminates are not reduced. <P/>
##  <C>MonomialOverField</C> takes the leading term of the given polynomial 
##  <A>poly</A> (all other terms will be ignored) and reduces all 
##  exponents modulo (Size(<A>F</A>)-1) for a given field <A>F</A>. 
##  This method will not work on a constant, but it may return a constant. <P/>
##  NOTE: The leading term is selected first, and then reduced modulo 
##  (Size(<A>F</A>)-1), which means that the monomial returned may in fact not 
##  be the actual leading monomial. To obtain the actual leading monomial, 
##  please use <C>LeadingMonomialOverField</C>, where the monomials are reduced 
##  first, which may cause cancellations, and then the leading term is found. 
##  The differences between <C>MonomialOverField</C> and 
##  <C>LeadingMonomialOverField</C> are illustrated in the example below. <P/>
##
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);;  y := X(K, "y");; F := GF(2^2);; 
##  gap> ChooseField(F);;
##  You can now create an NLFSR with up to 200 stages
##  with up to  200 nonzero terms
##  gap> poly1 := Z(2^2)*y^3 + y + Z(2^2)^2;;
##  gap> poly2 := Z(2^2)*y^7 + y + Z(2^2)^2;; 
##  gap> poly3 := Z(2^2)*x_0*x_1*x_9 + Z(2^2)*x_3^7*x_12 + Z(2^2)^2*x_5;;
##  gap> LeadingTerm(F, poly1); LeadingTerm(F, poly2); LeadingTerm(F, poly3);
##  Z(2^2)*y^3
##  Z(2^2)*y^7
##  Z(2^2)*x_3^7*x_12
##  gap> TermOverField(F, poly1); TermOverField(F, poly2); 
##  Z(2^2)
##  Z(2^2)*y
##  gap> TermOverField(F, poly3); 
##  Z(2^2)*x_3*x_12
##  gap> MonomialOverField(F, poly1); MonomialOverField(F, poly2); 
##  Z(2)^0
##  y
##  gap> MonomialOverField(F, poly3); 
##  x_3*x_12

##  ]]>
##  </Example>



##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##

DeclareOperation( "LeadingTerm",  [IsField, IsPolynomial]);
DeclareOperation( "TermOverField",  [IsField, IsPolynomial]);
DeclareOperation( "MonomialOverField",  [IsField, IsPolynomial]);

#############################################################################
##
#O  SplitCoeffsAndMonomials(<F>, <poly>) 			Degree of polynomial
##
##  <#GAPDoc Label="MonomialsOverField">
##  <ManSection>
##  <Meth Name="SplitCoeffsAndMonomials" Arg='F, poly' />
##  <Meth Name="ReduceMonomialsOverField" Arg='F, poly'   />
##  <Meth Name="ReduceMonomialsOverField" Arg='F, mlist' />
##  <Meth Name="LeadingTermOverField" Arg='F, poly' />
##  <Meth Name="LeadingMonomialOverField" Arg='F, poly' />
##  <Description>
##  All methods in this section work for both, univariate and multivariate 
##  polynomials. Caution is required with univariate polynomials when 
##  the exponents of the variable are reduced w.r.t. <A>F</A>, for example 
##  with methods <C>ReduceMonomialsOverField</C>, <C>LeadingTermOverField</C>
##  and <C>LeadingMonomialOverField</C>.
##  <P/>  
##  <C>SplitCoeffsAndMonomials</C> takes a finite field <A>F</A> over which the 
##  polynomail <A>poly</A> is defined and returns a with the list of 
##  coefficients <C>clist</C> that correspond to the monomials in the second 
##  list <C>mlist</C>. That is, for the polynomial 
##  <M>\sum_{i=0}^{n-1}c_im_i</M>, the method returns 
##  <M>[[c_{n-1}, \dots, c_0], [m_{n-1},\dots, m_0]]</M>, with coefficients 
##  <M>c_i\in F</M>. The monomials <M>m_i</M> can contain one or more variables,
##  i.e., the method works for both, univariate and multivariate polynomials. 
##  In case <M>c_i\ni F</M> and error is triggered and the method returns 
##  <C>fail</C>. The exponents of the monomials are not reduced w.r.t. <A>F</A>.
##  <P/>
##  <C>ReduceMonomialsOverField</C> takes a polynomial <A>poly</A> or a list of 
##  monomials
##  <A>mlist</A> and reduces all the exponents modulo (Size(<A>F</A>)-1)
##  for a given field <A>F</A>. If a constant FFE is a part of the list, 
##  it will stay untouched. 
##  For <M>\mathbb{F}_2</M> all the exponents are set to 1.
##  <P/>
##  <C>LeadingTermOverField</C> first reduces exponents in all terms modulo 
##  (Size(<A>F</A>)-1) for a given field <A>F</A> (using the method 
##  <C>ReduceMonomialsOverField</C>), then returns the leading 
##  term of the remaining polynomial. <P/>
##  <C>LeadingMonomialOverField</C> first reduces exponents in all terms modulo 
##  (Size(<A>F</A>)-1) for a given field <A>F</A> (using the method 
##  <C>ReduceMonomialsOverField</C>), then returns the leading 
##  monomial of the remaining polynomial. 
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);;  y := X(K, "y");; F := GF(2^2);; 
##  gap> ChooseField(F);;
##  You can now create an NLFSR with up to 200 stages
##  with up to  200 nonzero terms
##  gap> poly1 := Z(2^2)*y^3 + y + Z(2^2)^2;;
##  gap> poly2 := Z(2^2)*y^7 + y + Z(2^2)^2;; 
##  gap> poly3 := Z(2^2)*x_0*x_1*x_9 + Z(2^2)*x_3^7*x_12 + Z(2^2)^2*x_5;;
##  gap> SplitCoeffsAndMonomials(F, poly1); SplitCoeffsAndMonomials(F, poly2);
##  [ [ Z(2^2), Z(2)^0, Z(2^2)^2 ], [ y^3, y, Z(2)^0 ] ] 
##  [ [ Z(2^2), Z(2)^0, Z(2^2)^2 ], [ y^7, y, Z(2)^0 ] ]
##  gap> SplitCoeffsAndMonomials(F, poly3);                          
##  [ [ Z(2^2), Z(2^2), Z(2^2)^2 ], [ x_3^7*x_12, x_0*x_1*x_9, x_5 ] ]
##  gap> ReduceMonomialsOverField(F, poly1); ReduceMonomialsOverField(F, poly2);
##  y+Z(2)^0
##  Z(2^2)^2*y+Z(2^2)^2
##  gap> ReduceMonomialsOverField(F, poly3);                                    
##  Z(2^2)*x_0*x_1*x_9+Z(2^2)*x_3*x_12+Z(2^2)^2*x_5
##  gap> ReduceMonomialsOverField(F, SplitCoeffsAndMonomials(F, poly3)[2]);
##  [ x_3*x_12, x_0*x_1*x_9, x_5 ]
##  gap> LeadingTermOverField(F, poly1); LeadingTermOverField(F, poly2); 
##  y
##  Z(2^2)^2*y
##  gap> LeadingTermOverField(F, poly3); 
##  Z(2^2)*x_0*x_1*x_9
##  gap> LeadingMonomialOverField(F, poly1); LeadingMonomialOverField(F, poly2); 
##  y
##  y
##  gap> LeadingMonomialOverField(F, poly3);
##  x_0*x_1*x_9
##  
##  ]]>
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



DeclareOperation( "SplitCoeffsAndMonomials",  [IsField, IsPolynomial]);
DeclareOperation( "ReduceMonomialsOverField",  [IsField, IsList]);
DeclareOperation( "ReduceMonomialsOverField",  [IsField, IsPolynomial]);
DeclareOperation( "LeadingTermOverField",  [IsField, IsPolynomial]);
DeclareOperation( "LeadingMonomialOverField",  [IsField, IsPolynomial]);

##### old text
##  <C>DegreeOfPolynomialOverField</C>  for a monomial of form
##  <M>p = \prod x_i^{e_i}</M> is computed as <M>\sum e_i</M>, where <M>i</M>
##  runs through all indeterminates present in this monomial.
##  <P/>
##  <C>DegreeOfPolynomialOverField</C> for a polynomial of form
##  <M>P = \sum c_j\cdot p_j</M> where <M>c_j\in</M> <A>F</A> and 
##  <M>p_j = \prod_{i}x_i^{e_i}</M> is computed as  
##  <M>\max (DegreeOfPolynomialOverField(p_j))</M>,
##  where <M>\max</M> runs through all monomials <M>p_j</M> present in this
##  polynomial. <P/>


#############################################################################
##
#O  DegreeOfPolynomial(<poly>) 			Degree of polynomial
##
##  <#GAPDoc Label="DegreeOfPolynomial">
##  <ManSection>
##  <Meth Name="DegreeOfPolynomialOverField" Arg='F, poly' />
##  <Meth Name="DegreeOfPolynomialOverField" Arg='F, clist, mlist' />
##  <Description>

##  <C>DegreeOfPolynomialOverField</C> works for both, univariate and  
##  multivariate polynomials, but should not be used for univariate polynomials 
##  because the exponents of the indeterminates are reduced w.r.t. <A>F</A>.
##  <P/>
##  <C>DegreeOfPolynomialOverField</C> calls 
##  <Ref Meth="ReduceMonomialsOverField" /> and returns the degree of the 
##  leading term of the reduced polynomial <A>poly</A> or 
##  <M>clist \ cdot mlist</M>

##  <Example>
##  <![CDATA[
##  gap> DegreeOfPolynomialOverField(F, poly1); DegreeOfPolynomialOverField(F, poly2); 
##  1
##  1
##  gap> DegreeOfPolynomialOverField(F, poly3);
##  3
##  
##  ]]>
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##

DeclareOperation( "DegreeOfPolynomialOverField", [IsField, IsPolynomial]);
DeclareOperation( "DegreeOfPolynomialOverField", [IsField, IsFFECollection, IsList]);




#############################################################################
##
#O  ReciprocalPolynomial(<F>, <poly>) 			Degree of polynomial
##
##  <#GAPDoc Label="ReciprocalPolynomial">
##  <ManSection>
##  <Meth Name="ReciprocalPolynomial" Arg='F, poly' />
##  <Description>
##  <C>ReciprocalPolynomial</C> returns the polynomial with coefficients taken
##  from polynomial <A>poly</A> and used in the reversed order
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation( "ReciprocalPolynomial",  [IsField, IsPolynomial]);


#############################################################################
##
#M  GeneratorOfField( <F> )    . . . .. get generator of zechs log
##
##
##  <#GAPDoc Label="GeneratorOfField">
##  <ManSection>
##  <Meth Name="GeneratorOfField" Arg="F"/>
##  <Meth Name="GeneratorWRTDefiningPolynomial" Arg="F"/>
##
##  <Description>
##  <C>GeneratorOfField</C> returns the root of the defining
##  polynomial if the root is also a generator, otherwise it returns the first
##   element <M>\ni: order(x)=Size(F)-1</M>.<P/>
##  <C>GeneratorWRTDefiningPolynomial</C> returns the the coefficient vector
##  of the element returned by the  <C>GeneratorOfField</C> call w.r.t
##  polynomial basis given by the root of the defining polynomial of the field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


#T test file tstfsroutputs.tst

DeclareOperation( "GeneratorOfField", [IsField and IsFinite]);
DeclareOperation( "GeneratorWRTDefiningPolynomial", [IsField and IsFinite]);





Print("misc.gd OK,\t");
