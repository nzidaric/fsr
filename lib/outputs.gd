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

#DeclareOperation( "DefaultFieldMat",   [IsFFECollColl]);

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
##  <p>IntFFExt takes the <A>ffe</A> and writes it as an integer of the prime field
##  if <A>ffe</A> is an element of the prime field (same as Int(<ffe>)),
##  or writes it as a vector of integers from the prime subfield
##  if <A>ffe</A> is an element of an extension field, using the given basis <A>B</A> or 
##  canonical basis representation of <A>ffe</A>.</p>
##  <p>IntVecFFExt takes the vector <A>vec</A> of FFEs and writes it as 
##  a vector of integers from the prime field if all components of <A>vec</A> belong to a prime field,
##  or as a vector of vectors of integers from the prime subfield, if the components belong to an 
##  extension field, using the given basis <A>B</A> or canonical basis representation of <A>ffe</A>.
##  (note: all components are treated as elements of the largest field). </p>
##  <p> IntMATFFExt takes a matrix <A>M</A> and returns a matrix of vectors of integers from the prime
##  field if all components of <A>M</A> belong to a prime field, or a vector of row vectors, whose 
##  elements are vectors of integers from the prime subfield, if the components belong to an extension
##  field, using the given basis <A>B</A> or canonical basis representation of <A>ffe</A>.
##  <p> NOTE: the non-basis versions return a representation in the SMALLEST field that contains the element.
##  for representation in a specific field, use the basis version with desired basis
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


#T test file for non basis versions: testOutputs.g
#T test file for basis versions: testOutputsB.g
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
##  writes a (FFE) verctor as string or list of strings using the given basis <A>B</A> or canonical 
##  basis representation of <A>ffe</A>. 
##  <p> the list of strings is more practically useful: we wish to have the components as srings, which is what we want to use 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#T test file for non basis versions: testOutputs.g
#T test file for basis versions: testOutputsB.g
DeclareOperation( "VecToString" ,[IsVector] ); # added to tstfsroutputs.tst
DeclareOperation( "VecToString" ,[IsBasis, IsVector] ); # added to tstfsroutputs.tst


#############################################################################
##
#F  WriteVector( <output>, <vec> ) . . . . . . . . write vec to file
#F  WriteVectorB( <output>, <B>,  <vec> ) . . . . . . . . write vec to file
##
##  <#GAPDoc Label="WriteVector">
##  <ManSection>
##  <Func Name="WriteVector" Arg="output, vec"/>
##
##  <Description>
##  writes the vector <A>vec</A> whose components are elms of GF(2) to
##  the output file <A>output</A>. Also works if the element is an integer or FFE. 
##  if the element is a FFE, it will be written as a vector of elements of the 
##  prime subfield using the given basis <A>B</A> or canonical basis representation of <A>vec</A>.</p> 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


#T test file for non basis versions: testWriteVector.g
#T test file for basis versions: testWriteVectorB.g


# works for both, the elements and their IntFFExt outputs
DeclareOperation( "WriteVector" ,[IsOutputStream, IsInt ]);

DeclareOperation( "WriteVector" ,[IsOutputStream, IsBasis, IsFFE]);
DeclareOperation( "WriteVector" ,[IsOutputStream, IsFFE]);

DeclareOperation( "WriteVector" ,[IsOutputStream, IsBasis, IsRowVector]);
DeclareOperation( "WriteVector" ,[IsOutputStream, IsRowVector]);

DeclareOperation( "WriteVector" ,[IsOutputStream, IsBasis, IsFFECollColl]);
DeclareOperation( "WriteVector" ,[IsOutputStream, IsFFECollColl]);



#############################################################################
##
#F  WriteMatrix( <output>, <M> ) . . . . . . . . write matrix
#F  WriteMatrix( <output>, <B>, <M> ) . . . . . . . . write matrix - basis version
##
##  <#GAPDoc Label="WriteMatrix">
##  <ManSection>
##  <Func Name="WriteMatrix" Arg="output, M"/>
##
##  <Description>
##  writes the matrix <A>M</A> whose components are FFEs to
##  the output file <A>output</A> nicely formatted (each row in a new line)
##  using the given basis <A>B</A> if called as WriteMatrixB or canonical basis representation of 
##  <A>vec</A> if called as WriteMatrix.</p>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


#T test file for non basis versions: testWriteMatrix.g
#T test file for basis versions: testWriteMatrixB.g

DeclareOperation( "WriteMatrix" ,[IsOutputStream, IsBasis, IsMatrix]);
DeclareOperation( "WriteMatrix" ,[IsOutputStream, IsMatrix]);



#############################################################################
##
#F  WriteMatrixTEX( <output>, <M>  ) . . . writes the TEX code for  matrix 
##
##  <#GAPDoc Label="WriteMatrixTEX">
##  <ManSection>
##  <Func Name="WriteMatrixTEX" Arg="output, M"/>
##
##  <Description>
##  writes the TEX code for  matrix <A>M</A> over GF(2)
##  to the output file <A>output</A>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

#T test file for non basis versions: testWriteMatrixTEX.g
DeclareGlobalFunction( "WriteMatrixTEX" );



Print("outputs.gd OK,\t");
#E  output.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
