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
##  <ManSection>
##  <Oper Name="TrimLeadCoeff" Arg='coefs'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareOperation( "TrimLeadCoeff",  [IsFFECollection and IsRowVector]);
DeclareOperation( "IdxNonzeroCoeffs",  [IsFFECollection and IsRowVector]);
DeclareOperation( "IdxNonzeroCoeffs2",  [IsFFECollection and IsRowVector]);
DeclareOperation( "NrNonzeroCoeffs",  [IsFFECollection and IsRowVector]);


#############################################################################
##
#O  DegreeOfPolynomial(<poly>) 			Degree of polynomial
##
##  <ManSection>
##  <Oper Name="DegreeOfPolynomial" Arg='poly'/>
##
##  <Description>
##  DegreeOfPolynomial as follows for both monomial and polynomial:
##  DegreeOfMonomial =  sum of powers of all indeterminates inside it
##  DegreeOfPolynomial = max_{over all monomials present} (DegreeOfMonomial)
##  so an actual extra funstion called  DegreeOfMonomial is not needed
##  </Description>
##  </ManSection>
##
DeclareOperation( "DegreeOfPolynomial",  [IsPolynomial]);
DeclareOperation( "DegreeOfPolynomial",  [IsField, IsPolynomial]);



Print("misc.gd OK,\t");