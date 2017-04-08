#############################################################################
##
#W  misc.gd                   GAP Package                   nusa zidaric
##
##

#DeclareSynonym("IsFFESqMatrix", IsMatrix and IsRectangularTable and IsFFECollColl);

#############################################################################
##
#O  TrimLeadCoeff(<coefs>) 			Trim the leading coefficient
##
##  <#GAPDoc Label="TrimLeadCoeff">
##  <ManSection>
##  <Meth Name="TrimLeadCoeff" Arg='F, poly'  Label="for an LFSR"/>
##  <Meth Name="IdxNonzeroCoeffs" Arg='F, poly'  Label="for an LFSR"/>
##  <Meth Name="IdxNonzeroCoeffs2" Arg='F, poly'  Label="for an LFSR"/>
##  <Meth Name="NrNonzeroCoeffs" Arg='F, poly'  Label="for an LFSR"/>
##  <Description>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "TrimLeadCoeff",  [IsFFECollection and IsRowVector]);
DeclareOperation( "IdxNonzeroCoeffs",  [IsFFECollection and IsRowVector]);
DeclareOperation( "IdxNonzeroCoeffs2",  [IsFFECollection and IsRowVector]);
DeclareOperation( "NrNonzeroCoeffs",  [IsFFECollection and IsRowVector]);


#############################################################################
##
#O  MonomialsOverField(<F>, <poly>) 			Degree of polynomial
##
##  <#GAPDoc Label="MonomialsOverField">
##  <ManSection>
##  <Meth Name="MonomialsOverField" Arg='F, poly'  Label="for an NLFSR"/>

##  <Description>
##  MonomialsOverField takes a monomial or a list of monomials, and 
##  reduces all the exponents modulo (Size(<A>F</A>)-1) for all extension fields
##  and prime fields except for <A>F</A>=<M>\mathcal(F)_2</M>. 
##  For <M>\mathcal(F)_2</M> all the exponents are set to 1. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "MonomialsOverField",  [IsField, IsPolynomial]);
DeclareOperation( "MonomialsOverField",  [IsField, IsList]);

#############################################################################
##
#O  DegreeOfPolynomial(<poly>) 			Degree of polynomial
##
##  <#GAPDoc Label="DegreeOfPolynomial">
##  <ManSection>
##  <Meth Name="DegreeOfPolynomial" Arg='F, poly'  Label="DegreeOfPolynomial"/>
##  <Description>
##  <C>DegreeOfPolynomial</C> as follows for both monomial of form 
##  <M>p = \prod x_i^{e_i}</M> and polynomial of form 
##  <M>P = \sum c_j\cdotp_j</M> where <M>p_j = \prod_{i}x_i^{e_i}</M>
##  DegreeOfPolynomial for a monomial: <M>=  \sum e_i</M>, where <M>i</M> 
##  runs through all indeterminates present in this monomial
##  <P/>
##  DegreeOfPolynomial for a polynomial:<M>= \max (DegreeOfPolynomial(p_j))</M>,
##  where <M>\max</M> runs through all monomials <M>p_j</M> present in this 
##  polynomial so an actual extra funstion called DegreeOfMonomial is not needed
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "DegreeOfPolynomial",  [IsPolynomial]);
#DeclareOperation( "DegreeOfPolynomial",  [IsField, IsPolynomial]);


#############################################################################
##
#M  GeneratorOfUnderlyingField( <F> )    . . . .. get generator of zechs log
##
##
##  <#GAPDoc Label="GeneratorOfUnderlyingField">
##  <ManSection>
##  <Meth Name="GeneratorOfUnderlyingField" Arg="F"/>
##
##  <Description>
##  <C>GeneratorOfUnderlyingField</C> returns the first element
##  <M>\ni: order(x)=Size(F)-1</M>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


#T test file tstfsroutputs.tst

DeclareOperation( "GeneratorOfUnderlyingField", [IsField and IsFinite]); 


Print("misc.gd OK,\t");