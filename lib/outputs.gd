#############################################################################
##
##
#W  output.gd          FSR Package                  Nusa
##
##  Declaration file 
##
#Y  
#Y                          
##
##  <#GAPDoc Label="outputs">
##  <ManSection>
##
##  <Description>
##  There are two types of functions: ones that return the input 
##  in a human friendly version (as strings or list of strings), 
##  and ones that write the human friendly version of the input into a file (txt or tex)
##  <P/>
##  </Description>


#############################################################################
##
#O  IntFFExt( [<B>,] <ffe> )    . . . . . . . . write ffe as integer / vector of integers from the prime subfield
#O  IntVecFFExt( [<B>,] <vec> ) . . . . . . . . write vector of integers from the prime subfield
#O  IntMatFFExt( [<B>,] <M> )   . . . . . . . . write matrix of integers from the prime subfield
##
##  <#GAPDoc Label="IntFFExt">
##  <ManSection>
##  <Func Name=" IntFFExt" Arg="[B,]ffe"/>
##  <Func Name=" IntVecFFExt" Arg="[B,]vec"/>
##  <Func Name=" IntMatFFExt" Arg="[B,]M"/>
##
##  <Description>
##  IntFFExt takes the <A>ffe</A> and writes it as an integer of the prime field 
##  if <A>ffe</A> is an element of the prime field (same as Int(ffe)),
##  or writes it as a vector of integers from the prime subfield
##  if <A>ffe</A> is an element of an extension field, using the given basis <A>B</A> or 
##  canonical basis representation of <A>ffe</A> if no basis is provided.
##  <P/>
##  IntVecFFExt takes the vector <A>vec</A> of FFEs and writes it in a human friendly version: as 
##  a vector of integers from the prime field if all components of <A>vec</A> belong to a prime field,
##  or as a vector of vectors of integers from the prime subfield, if the components belong to an 
##  extension field, using the given basis <A>B</A> or canonical basis representation of <A>ffe</A>, 
##  if no basis is provided.
##  (note: all components are treated as elements of the largest field).
##  <P/>
##  IntMatFFExt takes a matrix <A>M</A> and returns its human friendly version:
##  a matrix of vectors of integers from the prime
##  field if all components of <A>M</A> belong to a prime field, or a vector of row vectors, whose 
##  elements are vectors of integers from the prime subfield, if the components belong to an extension
##  field, using the given basis <A>B</A> or canonical basis representation of <A>ffe</A>.
##  <P/>
##  NOTE: the non-basis versions return a representation in the smallest field that contains the element.
##  for representation in a specific field, use the basis version with desired basis
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
##  <Func Name="VecToString" Arg="[B,] vec"/>
##
##  <Description>
##  writes a (FFE) verctor  or matrix as string or list of strings using the given basis <A>B</A> or canonical 
##  basis representation of <A>ffe</A> if no basis is provided. This mathod calls methods IntFFExt, IntVecFFExt and IntMatFFExt ADDLINK.
##  The list of strings is more practically useful: we wish to have the components as srings, therefore 
##  the human friendly version of a matrix is nor an actual string.
##  <P/>
##  NOTE: the non-basis versions return a representation in the smallest field that contains the element.
##  for representation in a specific field, use the basis version with desired basis
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
##  <Func Name="WriteVector" Arg="output, B, vec"/>
##
##  <Description>
##  Writes the human friendly version of vector <A>vec</A> represented in basis <A>B</A>,
##  whose components are elms of a prime field to
##  the output file <A>output</A>. Also works if the element is an integer or FFE. 
##  If the element is a FFE, it will be written as a vector of elements of the 
##  prime subfield using the given basis <A>B</A>.
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
##  <Func Name="WriteMatrix" Arg="output, B, M"/>
##
##  <Description>
##  Writes the human friendly version of matrix <A>M</A> represented in basis <A>B</A> whose components are FFEs to
##  the output file <A>output</A> nicely formatted (each row in a new line).
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
