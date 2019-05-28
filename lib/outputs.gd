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
##  <#GAPDoc Label="outputs1">
##  <Index>outputs</Index>
##  There are two types of functions
##  for writing to a files, ones
##   without special formatting (e.g. *.txt file), and the ones
##   with TEX formatting (e.g. can be used directly in *.tex files).
## The followng tex packages must be used: <E>array, amssymb, amsmath</E>.
## <P/>
##  <#/GAPDoc>
###############################################################################
##
##  <#GAPDoc Label="outputs2">
##  Some of the common inputs to the writing functions:
##  <List>
##  <Item> <A>output</A> - output stream file (e.g., txt)</Item>
##  <Item> <A>fsr</A> - the FSR</Item>
##  <Item> <A>F</A>, <A>ffe</A>, <A>vec</A>, <A>M</A> - a finite field , a field
##  element, a vector, a matrix. </Item>
##  <Item> <A>B</A>, <A>b</A> - basis used for representation of the elmenets,
##  and the basis print switch, indicating whether or not to use <A>B</A>.</Item>
##  <Item> <A>gen</A>, <A>strGen</A> - generator of the underlying field
##  and the greek letter string for tex, e.g. "alpha", to
##   represent the generator. Will be used for
##  the representation of the elements as a power of  <A>gen</A>.
##  Only relevant for the TEX writing functions. </Item>

##  </List>


##  The TEX functions only write the fileds, field elements and
##  polynomials formatted
##  for  *.tex files. Field elements are represented either w.r.t. a
##  given basis <A>B</A> or as a power of a generator <A>gen</A>
##   of the finite field <A>F</A>.
##  The generator <A>gen</A> is used to get the exponents of the elements, and
##  the elements themselfs are printed as e.g. <M>\alpha^{exponent}</M>, where
##  <A>strGen</A> is set to "alpha" ( it must be a string representing a greek
##  letter in *.tex).
##  <P/>
##  A full example of the various WriteTEX* functions can be seen in figures
##  at the end of this section.
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

DeclareOperation( "IntFFExt", [IsBasis, IsRingElement]);
DeclareOperation( "IntFFExt", [IsRingElement]);

DeclareOperation( "IntVecFFExt" ,[IsBasis, IsRingElementCollection]);
DeclareOperation( "IntVecFFExt" ,[IsRingElementCollection]);

DeclareOperation( "IntMatFFExt" , [IsBasis, IsRingElementCollColl]);
DeclareOperation( "IntMatFFExt" , [IsRingElementCollColl]);

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
##  <#GAPDoc Label="WriteFFEVector">
##  <ManSection>
##  <Func Name="WriteFFEVec" Arg="output, B, vec"  />
##  <Func Name="WriteFFEMatrix" Arg="output, B, M"  />
##
##  <Description>
##  <C>WriteFFEVector</C> writes the human friendly version of vector <A>vec</A>
##  represented in basis
##  <A>B</A>, to the output file <A>output</A>. Also works if <A>vec</A> is an
##  integer or FFE. Can be used to write the sequence produced by the FSR to a
##   file, but the list (the sequence) shall not contain any sublists
##  (i.e. flatten the list first).  Also works for writing matrices, but writes
##  them as a row vector, not as a ``rectangle''.<P/>
##  <C>WriteFFEMatrix</C> writes the human friendly version of matrix <A>M</A>
##  represented in basis <A>B</A> to the output file <A>output</A> nicely
##  formatted (rectangular, each row in a new line).<P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#ONLY KEEPING THE BASIS VERSION, SO MUST AT LEAST PROVIDE CANONICAL BASIS!!!
DeclareGlobalFunction( "WriteFFEVec" );
DeclareGlobalFunction( "WriteFFEMatrix" );

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
##  <Func Name="WriteTEXFFEVec" Arg="output, B, vec" />
##  <Func Name="WriteTEXFFEMatrix" Arg="output, B, M" />
##  <Func Name="WriteTEXFFEByGenerator" Arg="output, F, ffe, strGen, gen" />
##  <Func Name="WriteTEXFFEVecByGenerator" Arg="output, F, vec, strGen, gen" />
##  <Func Name="WriteTEXFFEMatrixByGnerator" Arg="output, F, M, strGen, gen" />
##  <Func Name="WriteTEXSymVecByGenerator" Arg="output, F, vec, strGen, gen" />

##
##  <Description>
##  <C>WriteTEXFF</C> writes the field in TEX format, e.g.
##  <M>\mathbb{F}_{2}</M>, <M>\mathbb{F}_{{2}^{2}}</M> or
##  <M>\mathbb{F}_{(({2}^{2})^{2})^{2}}</M>.
##  <P/>
##  <C>WriteTEXFFE</C> writes the <A>ffe</A> w.r.t the chosen basis <A>B</A>.
##  <P/>
##  <C>WriteTEXFFEVec</C> writes the vector <A>vec</A> with elements w.r.t
##  the chosen basis <A>B</A>.
##  <P/>
##  <C>WriteTEXFFEMat</C> writes the matrix <A>M</A> with elements w.r.t
##  the chosen basis  <A>B</A>.
##  <P/>
##  Analogue to the last three ``basis'' writing functions are the functions
##  <C>WriteTEXFFEByGenerator</C>,
##  <C>WriteTEXFFEVecByGenerator</C> and
##  <C>WriteTEXFFEMatrixByGnerator</C>, that write the field elements
##  a power of a chosen
##  generator
##  <A>gen</A> of the field <A>F</A> (to avoid using a generator of the subfield
##  in case <A>ffe</A> is a subfield element).<P/>
##  NOTE: for both WriteTEXFFEMatrix functions the math environment wrappers,
##  e.g. <E>\begin{displaymath}</E>  and
##  <E>\end{displaymath}</E> must be added manually!  <P/>
##  <C>WriteTEXSymVecByGenerator</C> writes every element of the vector
##  <A>vec</A>with symbols
##  <M>s_1,\dots,s_{199}</M>   and all coefficients as powers of the
##  chosen generator <A>gen</A>. <P/>
##  NOTE: if the vector contains FFE constants, use <M>vec*One(s_0)</M> as
##  as the input to the writing function. 

##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "WriteTEXFF" );
DeclareGlobalFunction( "WriteTEXFFE" );
DeclareGlobalFunction( "WriteTEXFFEByGenerator" );
DeclareGlobalFunction( "WriteTEXFFEByGeneratorNM" );
DeclareGlobalFunction( "WriteTEXFFEVec" );
DeclareGlobalFunction( "WriteTEXFFEVecByGenerator" );
DeclareGlobalFunction( "WriteTEXFFEMatrix" );
DeclareGlobalFunction( "WriteTEXFFEMatrixByGenerator" );


DeclareGlobalFunction( "WriteTEXSymVecByGenerator" );


#############################################################################
##
#F  WriteTEXFF( <output>, <F> ) . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="WriteTEXUnivarFFPolyByGenerator">
##  <ManSection>
##  <Func Name="WriteTEXUnivarFFPolyByGenerator" Arg="output, F, f, strIndet,
##  strGen, gen"/>
##  <Func Name="WriteTEXFieldPolyByGenerator" Arg="output, F, f, strGen, gen"/>
##  <Func Name="WriteTEXLFSRPolyByGenerator" Arg="output, F, f, strGen, gen"/>
##  <Func Name="WriteTEXMultivarFFPolyByGenerator"
##  Arg="output, F, mpoly, strGen, gen"/>
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
##  <C>WriteTEXMultivarFFPolyByGenerator</C> writes the multuivariate polynomial
##  <A>mpoly</A> with indterminates <M>x_0, \dots, x_{199}</M> or
##  <M>s_0, \dots, s_{199}</M> (mix of <M>x_i</M> and <M>s_i</M> is not
##  supported). The coefficients are written
##  as powers of a chosen generator <A>gen</A>.
##
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "WriteTEXUnivarFFPolyByGenerator" );
DeclareGlobalFunction( "WriteTEXFieldPolyByGenerator" );
DeclareGlobalFunction( "WriteTEXLFSRPolyByGenerator" );
DeclareGlobalFunction( "WriteTEXMultivarFFPolyByGenerator" );


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
##  as a root of the defining polynomial of <A>F</A> if that is the case,
##  otherwise it writes the generator <A>gen</A>
##  in polynomial basis of the field <A>F</A> given by the root <M>\omega</M>
##  of the defining polynomial of <A>F</A>. <P/>
##  NOTE: In the FSR package, "omega" is the reserved greek
##  letter for the root of the defining polynomial <A>strGen</A>. Please
##  make sure that if using "omega" as <A>strGen</A>, gen is the
##  root of defining polynomial.<P/>
##  <C>WriteTEXBasisByGenerator</C> prints the elements of the given basis
##  <A>B</A>  as powers of a chosen generator <A>gen</A>.<P/>
##  <C>WriteTEXElementTableByGenerator</C> provides the context information for
##  <C>WriteTEXSequenceByGenerator</C> and <C>WriteTEXRunFSRByGenerator</C>.
##  Its output is a *.tex file with a table containing the elements of <A>F</A>
##  represented in basis <A>B</A> and their representation as powers of a
##  chosen generator <A>gen</A> in column <M>\alpha^{i}</M>,
##   where <A>strGen</A> is set to "alpha". Use of "omega" is not allowed. There
##   is an extra table column containing the order of each element.
##  The output file contains additional information, e.g. the defining
##  polynomial of
##  <A>F</A>, basis elements of <A>B</A> as powers of generator <A>gen</A>.
## <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareGlobalFunction( "WriteTEXGeneratorWRTDefiningPolynomial");
DeclareGlobalFunction( "WriteTEXBasisByGenerator");
DeclareGlobalFunction( "WriteTEXElementTableByGenerator");




###############################################################################
##
##  <#GAPDoc Label="outputsEG">
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.9]{WriteTEX}
##  \caption{Sample output of varoius WriteTEX* functions}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="WriteTEX.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.8]{WriteTEXelmTablesnap}
##  \caption{Sample output of WriteTEXElementTableByGenerator}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="WriteTEXelmTablesnap.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <#/GAPDoc>





Print("outputs.gd OK,\t");
#E  output.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
