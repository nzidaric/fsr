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
##  and ones that write the human friendly version of the input into a file (txt or tex)
##  <#/GAPDoc>




#############################################################################
##
#M  IntFFExt( [<B>,] <ffe> )    .  . write ffe as integer / vector of integers from the prime subfield
#M  IntVecFFExt( [<B>,] <vec> ) . . . . . . . . write vector of integers from the prime subfield
#M  IntMatFFExt( [<B>,] <M> )   . . . . . . . . write matrix of integers from the prime subfield
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

DeclareOperation( "IntFFExt", [IsBasis, IsFFE]); # added to tstfsroutputs.tst
DeclareOperation( "IntFFExt", [IsFFE]); # added to tstfsroutputs.tst

DeclareOperation( "IntVecFFExt" ,[IsBasis, IsFFECollection]);# added to tstfsroutputs.tst
DeclareOperation( "IntVecFFExt" ,[IsFFECollection]);# added to tstfsroutputs.tst

DeclareOperation( "IntMatFFExt" , [IsBasis, IsFFECollColl]);# added to tstfsroutputs.tst
DeclareOperation( "IntMatFFExt" , [IsFFECollColl]);# added to tstfsroutputs.tst




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

DeclareOperation( "VecToString" ,[IsVector] ); # added to tstfsroutputs.tst
DeclareOperation( "VecToString" ,[IsBasis, IsVector] ); # added to tstfsroutputs.tst




#############################################################################
##
#F  WriteVector( <output>, <B>,  <vec> ) . . . . . . . . write vec to file
##
##  <#GAPDoc Label="WriteVector">
##  <ManSection>
##  <Func Arg="output, B, vec" Name="WriteVector"  Label="for a FFE and given basis" />
##
##  <Description>
##  Writes the human friendly version of vector <A>vec</A> represented in basis <A>B</A>,
##  to the output file <A>output</A>. Also works if <A>vec</A> is an integer or FFE. 
##  can be used to write the sequence produced by the FSR to a file, make sure that the sequence 
##  does not contain any subsequences (ie if merging two runs of the FSR, must use Append(seq,seq1), 
##  if adding new step to a run must use Add(seq, elm1))
##  <P/>
##  NOTE: the basis MUST be provided.
##  <P/>
##  Also works for writing matrices, but writes them as a row vector, not as a rectangle.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>




#T test file testWriteVector.g

#ONLY KEEPING THE BASIS VERSION, SO MUST AT LEAST PROVIDE CANONICAL BASIS!!!
DeclareGlobalFunction( "WriteVector" );


#############################################################################
##
#F  WriteMatrix( <output>, <B>, <M> ) . . . . . . . . write matrix
##
##  <#GAPDoc Label="WriteMatrix">
##  <ManSection>
##  <Func Name="WriteMatrix" Arg="output, B, M" Label="for a matrix of FFE and given basis" />
##
##  <Description>
##  Writes the human friendly version of matrix <A>M</A> represented in basis
##   <A>B</A> to the output file <A>output</A> nicely formatted (rectangular, 
##  each row in a new line).
##  <P/>
##  NOTE: the basis MUST be provided.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>




#T test file testWriteMatrix.g

#ONLY KEEPING THE BASIS VERSION, SO MUST AT LEAST PROVIDE CANONICAL BASIS!!!
DeclareGlobalFunction( "WriteMatrix" );



#############################################################################
##
#F  WriteMatrixTEX( <output>, <M>  ) . . . writes the TEX code for  matrix 
##
##  <#GAPDoc Label="WriteMatrixTEX">
##  <ManSection>
##  <Func Name="WriteMatrixTEX" Arg="output, M"/>
##
##  <Description>
##  Writes the TEX code for  matrix <A>M</A> over a prime field 
##  to the output file <A>output</A>. 
##  <P/>
##  NOTE: Only works for matrices over a prime field !!!
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#T test file testWriteMatrixTEX.g

DeclareGlobalFunction( "WriteMatrixTEX" );



Print("outputs.gd OK,\t");
#E  output.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
