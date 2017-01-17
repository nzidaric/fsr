#############################################################################
##
#W  misc.gd                   GAP Library                   nusa zidaric
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



Print("misc.gd OK,\t");