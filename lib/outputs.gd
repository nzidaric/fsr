#############################################################################
##
##
#W  output.gd          FSR Package                  Nusa
##
##
#Y
#Y


###############################################################################
##
##  <#GAPDoc Label="outputs">
##  <Index>outputs</Index>
##  There are two types of functions: ones that return the input
##  in a human friendly version (as strings or list of strings),
##  and ones that write the human friendly version of the input into a
##  file (txt or tex). The TEX versions contain objects formatter for *.tex.
##  <P/>
##  The TEX functions only write the fileds, field elements and
##  polynomials formatted
##  for  *.tex files. Two versions exist: represent the element w.r.t. a
##  given basis <A>B</A> or as a power of a generator <A>gen</A>
##   of the finite field <A>F</A>  to the output file <A>output</A>.<P/>
##  Generator <A>gen</A> is used to get the exponents of the elements, and the
##  elements themselfs are printed as e.g. <M>\alpha^{exponent}</M>, where
##  <A>strGen</A> is set to "alpha" ( it must be a string representing a greek
##  letter in *.tex). Use of "omega" is not allowed: it is reserved for the
##  root of the field defining polynomial in cases when  the root is different
##  from <A>gen</A>.
##  <P/>
##  <#/GAPDoc>


#############################################################################
##
#M  IntFFExt( [<B>,] <ffe> )    .  . write ffe as integer / vector of integers from the prime subfield
#M  IntVecFFExt( [<B>,] <vec> ) . . . . . write vector of integers from the prime subfield
#M  IntMatFFExt( [<B>,] <M> )   . . . . . write matrix of integers from the prime subfield
##
##  <#GAPDoc Label="IntFFExt">
##  <ManSection>
##  <Meth Name="IntFFExt" Arg="[B,] ffe"/>
##  <Meth Name="IntVecFFExt" Arg="[B,] vec"/>
##  <Meth Name="IntMatFFExt" Arg="[B,] M"/>
##
##  <Description>
##  <C>IntFFExt</C> takes the <A>ffe</A> and writes it as an integer of the
##  prime field f <A>ffe</A> is an element of the prime field (same as Int(ffe)),
##  or writes it as a vector of integers from the prime subfield
##  if <A>ffe</A> is an element of an extension field, using the given basis
##  <A>B</A> or canonical basis representation of <A>ffe</A> if no basis is
##  provided.<P/>
##  <C>IntVecFFExt</C> takes the vector <A>vec</A> of FFEs and writes it in a
##  human friendly version: as a vector of integers from the prime field if all
##  components of <A>vec</A> belong to a prime field, or as a vector of
##  vectors of integers from the prime subfield, if the components belong to
##  an extension field, using the given basis <A>B</A> or canonical basis
##  representation of <A>ffe</A>, if no basis is provided.
##  (note: all components are treated as elements of the largest field).
##  <P/>
##  <C>IntMatFFExt</C> takes a matrix <A>M</A> and returns its human friendly
##  version: a matrix of vectors of integers from the prime
##  field if all components of <A>M</A> belong to a prime field, or a vector of
##  row vectors, whose elements are vectors of integers from the prime subfield,
##  if the components belong to an extension field, using the given
##   basis <A>B</A> or canonical basis representation of components of <A>M</A>.
##  <P/>
##  NOTE: the non-basis versions return a representation in the smallest field
##  that contains the element. For representation in a specific field, use the
##  basis version with desired basis.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#T test file tstfsroutputs.tst

DeclareOperation( "IntFFExt", [IsBasis, IsFFE]);
DeclareOperation( "IntFFExt", [IsFFE]);

DeclareOperation( "IntVecFFExt" ,[IsBasis, IsFFECollection]);
DeclareOperation( "IntVecFFExt" ,[IsFFECollection]);

DeclareOperation( "IntMatFFExt" , [IsBasis, IsFFECollColl]);
DeclareOperation( "IntMatFFExt" , [IsFFECollColl]);

#############################################################################
##
#O  VecToString( <vec> ) . . . . . . . . write vector as s string
##
##  <#GAPDoc Label="VecToString">
##  <ManSection>
##  <Meth Name="VecToString" Arg="[B,] vec"/>
##
##  <Description>
##  Writes a FFE verctor or matrix as string or list of strings using the given
##  basis <A>B</A> or canonical basis representation of <A>ffe</A> if no basis
##  is provided. This mathod calls methods  <Ref Meth="IntFFExt" />,
##  <Ref Meth="IntVecFFExt" /> and  <Ref Meth="IntMatFFExt" />.
##  The list of strings is more practically useful: we wish to have the
##  components as srings, therefore the human friendly version of a matrix is
##  not an actual string.
##  <P/>
##  NOTE: the non-basis versions return a representation in the cononical basis
##  of the smallest field that contains the element. For representation in a
##  specific field, use the basis version with desired basis.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#T test file tstfsroutputs.tst

DeclareOperation( "VecToString" ,[IsVector] );
DeclareOperation( "VecToString" ,[IsBasis, IsVector] );

#############################################################################
##
#F  WriteVector( <output>, <B>,  <vec> ) . . . . . . . . write vec to file
##
##  <#GAPDoc Label="WriteVector">
##  <ManSection>
##  <Func Name="WriteVector" Arg="output, B, vec"  />
##  <Func Name="WriteMatrix" Arg="output, B, M"  />
##
##  <Description>
##  <C>WriteVector</C> writes the human friendly version of vector <A>vec</A>
##  represented in basis
##  <A>B</A>, to the output file <A>output</A>. Also works if <A>vec</A> is an
##  integer or FFE. can be used to write the sequence produced by the FSR to a
##   file, make sure that the sequence does not contain any subsequences (ie if
##   merging two runs of the FSR, must use Append(seq,seq1),
##  if adding new step to a run must use Add(seq, elm1)). <P/>
##  Also works for writing matrices, but writes them as a row vector,
##  not as a rectangle.<P/>
##  <C>WriteVector</C> writes the human friendly version of matrix <A>M</A>
##  represented in basis <A>B</A> to the output file <A>output</A> nicely
##  formatted (rectangular, each row in a new line).<P/>
##  NOTE: the basis MUST be provided.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#ONLY KEEPING THE BASIS VERSION, SO MUST AT LEAST PROVIDE CANONICAL BASIS!!!
DeclareGlobalFunction( "WriteVector" );
DeclareGlobalFunction( "WriteMatrix" );

#T test file testWriteVector.g
#T test file testWriteMatrix.g




#############################################################################
##
#F  WriteTEXFF( <output>, <F> ) . . . . .
##
##  <#GAPDoc Label="WriteTEXFF">
##  <ManSection>
##  <Func Name="WriteTEXFF" Arg="output, F" />
##  <Func Name="WriteTEXFFE" Arg="output, B, ffe" />
##  <Func Name="WriteTEXFFEByGenerator" Arg="output, F, ffe, strGen, gen" />
##  <Func Name="WriteTEXMatrix" Arg="output, B, M" />
##  <Func Name="WriteTEXMatrixByGnerator" Arg="output, F, M, strGen, gen" />
##
##  <Description>
##  <C>WriteTEXFF</C> writes the field as <M>\mathbb{F}_{{char}^m}</M>, where
##  <M>m = DegreeOverPrimeField(UnderlyingField(<A>fsr</A>))</M>.
##  <P/>
##  <C>WriteTEXFFE</C> writes the <A>ffe</A> w.r.t the chosen basis <A>B</A>.
##  <P/>
##  <C>WriteTEXFFEByGenerator</C> writes the <A>ffe</A> as a power of a chosen
##  generator
##  <A>gen</A> of the field <A>F</A> (to avoid using a generator of the subfield
##  in case <A>ffe</A> is a subfield element).<P/>
##  <C>WriteTEXMatrix</C> writes the elements of <A>M</A> w.r.t the given
##  basis <A>B</A> as a matrix. <P/>
##  <C>WriteTEXMatrixByGenerator</C> writes the <A>ffe</A> as a power of a chosen
##  generator
##  <A>gen</A> of the field <A>F</A> (to avoid using a generator of the subfield
##  in case <A>ffe</A> is a subfield element).<P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "WriteTEXFF" );
DeclareGlobalFunction( "WriteTEXFFE" );
DeclareGlobalFunction( "WriteTEXFFEByGeneratorNC" );
DeclareGlobalFunction( "WriteTEXFFEByGenerator" );
DeclareGlobalFunction( "WriteTEXMatrix" );
DeclareGlobalFunction( "WriteTEXMatrixByGenerator" );

#############################################################################
##
#F  WriteTEXFF( <output>, <F> ) . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="WriteTEXUnivarFFPolyByGenerator">
##  <ManSection>
##  <Func Name="WriteTEXUnivarFFPolyByGenerator" Arg="output, F, f, indet"/>
##  <Func Name="WriteTEXFieldPolyByGenerator" Arg="output, F"/>
##  <Func Name="WriteTEXLFSRPolyByGenerator" Arg="output, F, l"/>
##  <Func Name="WriteTEXMultivarFFPolyByGenerator" Arg="output, F, f"/>
##
##  <Description>
##  <C>WriteTEXUnivarFFPolyByGenerator</C> writes the polynomial <A>f</A> in
##  terms of indeterminate <A>strIndent</A>, given as a string, and with
##  coefficients as powers of a chosen generator
##  <A>gen</A> of the field <A>F</A> (to avoid using a generator of the subfield
##  in case a coefficient is a subfield element).<P/>
##  <C>WriteTEXFieldPolyByGenerator</C> and <C>WriteTEXLFSRPolyByGenerator</C>
##  call <C>WriteTEXUnivarFFPolyByGenerator</C> with <A>strIndet</A> set to "x"
##  and "y" respectively. <P/>
##  <C>WriteTEXMultivarFFPolyByGenerator</C> TO DO
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "WriteTEXUnivarFFPolyByGenerator" );
DeclareGlobalFunction( "WriteTEXFieldPolyByGenerator" );
DeclareGlobalFunction( "WriteTEXLFSRPolyByGenerator" );
DeclareGlobalFunction( "WriteTEXMultivarFFPolyByGenerator" );
# TO DO (will need indet list)

#############################################################################
##
#F  WriteTEXElementTableByGenerator( <output>, <F>, <B>, <strGen>, <gen> ) . . .
## ...................... write elms table with pwrs of generators to file
##
##  <#GAPDoc Label="WriteTEXGeneratorWRTDefiningPolynomial">
##  <ManSection>
##  <Func Name="WriteTEXGeneratorWRTDefiningPolynomial"
##  Arg="output, F, strGen, gen" />
##  <Func Name="WriteTEXBasisByGenerator"
##  Arg="output, F, B, strGen, gen" />
##  <Func Name="WriteTEXElementTableByGenerator"
##  Arg="output, F, B, strGen, gen" />
##
##  <Description>
##  <C>WriteTEXGeneratorWRTDefiningPolynomial</C> either writes that <A>gen</A>
##  is a root of the defining polynomial of <A>F</A> if that is the case,
##  otherwise it writes the generator <A>gen</A>
##  in polynomial basis of the field <A>F</A> given by the root <M>\omega</M>
##  of the defining polynomial of <A>F</A>, which is also why "omega" is not
##  valid <A>strGen</A>. <P/>
##  <C>WriteTEXBasisByGenerator</C> prints the elements of the given basis
##  <A>B</A>  as powers of a chosen generator <A>gen</A>.<P/>
##  <C>WriteTEXElementTableByGenerator</C> provides the context information for
##  <C>WriteTEXSequenceByGenerator</C> and <C>WriteTEXRunFSRByGenerator</C>.
##  Its output is a *.tex file with a table containing the elements of <A>F</A>
##  represented in basis <A>B</A> and their representation as powers of a
##  chosen generator <A>gen</A>, printed as for e.g. <M>\alpha^{exponent}</M>,
##   where <A>strGen</A> is set to "alpha" ( it must be a string representing a
##  greek  letter in *.tex). Use of "omega" is not allowed.  There
##   is an extra table column containing the order of each element.
##  The output file contains additional information: defining polynomial of
##  <A>F</A>, basis elements of <A>B</A> as powers of generator <A>gen</A>,
## <P/>
##  An example of the the <C>WriteTEXElementTableByGenerator</C>
##output can be seen in figure below: <P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.7]{WriteTEXelmTablesnap}
##  \caption{Sample output of WriteTEXElementTableByGenerator}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="WriteTEXelmTablesnap.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "WriteTEXGeneratorWRTDefiningPolynomial");
DeclareGlobalFunction( "WriteTEXBasisByGenerator");
DeclareGlobalFunction( "WriteTEXElementTableByGenerator");

Print("outputs.gd OK,\t");
#E  output.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
