#############################################################################
##
##
#W  outfsr.gd          FSR Package                  Nusa
##
##  Declaration file for the LFSR specific output formatting functions
##


#############################################################################
##
#M  ViewObj( <lfsr> )
#M  PrintObj( <lfsr> )
#M  Display( <lfsr> )
#M  PrintAll( <lfsr> )
##
##  <#GAPDoc Label="ViewObjFSR">
##  <ManSection>
##  <Meth Name="ViewObj" Arg='fsr  ' />
##  <Meth Name="PrintObj" Arg='fsr [,b] ' />
##  <Meth Name="PrintAll" Arg='fsr [,b] ' />
##
##  <Description>
##  Different detail on <A>fsr</A> created either by <Ref Func="LFSR" /> or
##  <Ref Func="NLFSR" />:
##  <List>
##  <Item> <C>Display/View</C>:
##  			<List>
##						<Item> LFSR: show the
##  <Ref Attr="FeedbackPoly" /> and wheter or
##  not the <A>fsr</A> is empty.</Item>
##  					<Item> NLFSR: show the
##  <Ref Attr="MultivarPoly" /> and wheter or
##  not the <A>fsr</A> is empty.</Item>
##  					<Item> FILFUN: show the
##  <Ref Attr="MultivarPoly" />.</Item>
##				</List>
##  </Item>
##  <Item> <C>Print</C>: same as <C>Display/View</C> if <A>fsr</A> is empty,
##  otherwise it also shows the values of components  <C>state</C>,
##  <C>numsteps</C> and <C>basis</C>.</Item>
##  <Item> <C>PrintAll</C>: same as <C>Print</C> if <A>fsr</A> is empty,
##  otherwise it also shows the values of all four components <C>init</C>,
##  <C>state</C> , <C>numsteps</C> and <C>basis</C>
##  with additional information about the underlying field and the tap positions
##  .</Item>
##  </List>
##  NOTE: both <C>Print</C> and <C>PrintAll</C> can be used with optional
##  parameter <A>b</A> for desiered output format: when <C>true</C> the output
##  will use the currently set basis. When <A>fsr</A> is symbolic, the
##  basis switch <A>b</A> is ignored.
##  <P/>
##  Examples below show different outputs for an LFSR:
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");; f := x^4 + x^3 + 1;;
##  gap> F := FieldExtension(K, f);; y := X(F, "y");; l := y^4 + y + Z(2^4);;
##  gap> test := LFSR(K, f, l);; Print(test);
##  empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
##  gap> ist := [ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ];; LoadFSR(test, ist);;
##  gap> Print(test);
##  LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with current state =[ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ]
##  after  0 steps
##  gap> RunFSR(test,5);; Print(test);
##  LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with current state =[ Z(2^2), Z(2^4)^2, Z(2^4)^2, Z(2^4)^11 ]
##  after  5 steps
##  gap> PrintAll(test);
##  LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
##  with initial state  =[ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ]
##  with current state  =[ Z(2^2), Z(2^4)^2, Z(2^4)^2, Z(2^4)^11 ]
##  after 5 steps
##  with output from stage S_0
##  gap> PrintAll(test, true);
##  LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0  given by FeedbackPoly = \
##  y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with feedback coeff =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 0 ],
##    [ 0, 1, 1, 0 ] ]
##  with initial state  =[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ],
##    [ 1, 0, 0, 0 ] ]
##  with current state  =[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ],
##    [ 0, 1, 1, 1 ] ]
##  after 5 steps
##  with output from stage S_0
##  ]]>
##  </Example>
##  Examples below show  outputs for an NLFSR and a FILFUN:
##  <Example>
##  <![CDATA[
##  gap> F := GF(2);;
##  gap> clist := [One(F), One(F)];; mlist := [x_0, x_1*x_2];;
##  gap> test := NLFSR(F, clist, mlist, 3);
##  < empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_1*x_2+x_0>
##  gap> Display(test);
##  < empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_1*x_2+x_0>
##  gap>  test := FILFUN(F, clist, mlist);; PrintAll(test);
##  FILFUN of length 3 over GF(2),
##    with the MultivarPoly = x_1*x_2+x_0
##  with basis =[ Z(2)^0 ]
##  with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
##  ]]>
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation("PrintObj", [IsFSR, IsBool]);
DeclareOperation("PrintObj", [IsFSR]);


DeclareOperation("PrintAll", [IsFSR, IsBool]);
DeclareOperation("PrintAll", [IsFSR]);



#############################################################################
##
#F  WriteAllFSR( <output>, <fsr> ) . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="WriteAllFSR">
##  <ManSection>
##  <Func Name="WriteAllFSR" Arg='output, fsr, b '/>
##  <Func Name="WriteTEXAllFSR" Arg='output, fsr, b, strGen, gen'/>
##
##  <Description>
##  <C>WriteAllFSR</C> is equivalent to PrintAll, but it writes to an output
##  stream (like a *.txt file).<P/>
##  <C>WriteTEXAllFSR</C> is equivalent to PrintAll, but formats the output for
##  *.tex files. <P/>
##  NOTE: both versions must be used with <E>mandatory</E> basis switch
##  parameter <A>b</A> for desiered output format: when <C>true</C> the output
##  will use the currently set basis. If the FSR is symbolic, <A>b</A> is
##  ignored, i.e. behaves like <C>false</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteAllFSR" );
DeclareGlobalFunction( "WriteTEXAllFSR" );



#############################################################################
##
#F  WriteSequenceFSR ( <output>, <fsr>, <sequence> )
##. . . . write output sequence to file
##
##  <#GAPDoc Label="WriteSequenceFSR">
##  <ManSection>
##  <Func Name="WriteSequenceFSR" Arg="output, fsr, sequence"/>
##  <Func Name="WriteTBSequenceFSR" Arg="output, fsr, sequence"/>
##  <Func Name="WriteTEXSequence"
##  Arg="output, fsr, sequence"/>
##  <Func Name="WriteTEXSequenceByGenerator"
##  Arg="output, fsr, sequence, strGen, gen"/>
##
##  <Description>
##  <C>WriteSequenceFSR</C> writes the sequence generated by some version of
##  RunFSR(lfsr)  to an output file, with addition of separating sequences from
##  different taps. The sequence elements are written in the currently set
##  basis of the <A>fsr</A> or symbolically.
##  <P/>
##  <C>WriteTBSequenceFSR</C> is a version of <C>WriteSequenceFSR</C>
##   intended for testbenching purposes: the generated sequence is written
##  to a file, with sequences from different taps separated into
##  <E>columns</E>.
##  The order of columns is determined by  <C>OutputTap(<A>fsr</A>)</C>.
##  The currently set basis of the <A>fsr</A> is used for the sequence elements,
##  a symbolic version is not possible.
##  <P/>
##  <C>WriteTEXSequence</C>  and  <C>WriteTEXSequenceByGenerator</C> are *.tex
##  versions of <C>WriteSequenceFSR</C>, writing the sequence elements w.r.t.
##  the currently set basis of the <A>fsr</A> or
##   as powers of a chosen generator <A>gen</A>.<P/>
##  <C>WriteTEXSequenceByGenerator</C> is the only function that can write a
##  symbollic sequence,
##  however, due to the length of the sequence elements, formatting problems
##  may arise .<P/>
##  NOTE: if the symbollic sequence contains FFE constants,
##  use <M>sequence*One(s_0)</M>
##  as the input to the writing function. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##

DeclareGlobalFunction("WriteSequenceFSR");
DeclareGlobalFunction("WriteTBSequenceFSR");
DeclareGlobalFunction("WriteTEXSequenceFSR" );
DeclareGlobalFunction("WriteTEXSequenceFSRByGenerator" );


#############################################################################
##
#F  WriteRunFSR( <output>, <fsr>, <ist>, <numsteps> ) . .  . write run to file
##
##  <#GAPDoc Label="WriteRunFSR">
##  <ManSection>
##  <Func Name="WriteRunFSR" Arg="output, fsr, ist, numsteps"/>
##  <Func Name="WriteExternalRunFSR" Arg="output, fsr, ist, elmvec"/>
##
##  <Description>
##  <C>WriteRunFSR</C> is an output to a file version of RunFSR(<A>fsr</A>,
##   <A>ist</A>, <A>num</A>), see  <Ref Meth="RunFSR" /> for details.
##  <C>WriteRunFSR</C> separates the sequences from
##  different taps and writes them in currently set basis
##  of the <A>fsr</A> or symbolically. After the FSR is loaded, the
##  <C>WriteAllFSR(output,  x, true)</C> is called to record the FSR being used.
##  When the run is finished, <C>WriteSequenceFSR</C> is called to record the
##  output sequence in compact version.
##  <C>WriteRunFSR</C> returns the sequence generated by this run.
##  <P/>
##  <C>WriteExternalRunFSR</C> is an output to a file version of
##  <C>RunFSR(<A>fsr</A>, <A>ist</A>, <A>elmvec</A>)</C> with an external element
##  added on each step. <P/>
##  An example of the the <C>WriteRunFSR</C>  output can be seen in figure
##  below: <P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.6]{WriteRunFSR1}
##  \caption{Sample output of WriteRunFSR}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="WriteRunFSR1.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>
##  NOTE: does not work properly if the basis is given over any subfield other
##  than the prime subfied. <P/>
##  NOTE: does not work for  <A>fsr</A> of type FILFUN !
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteRunFSR" );
DeclareGlobalFunction( "WriteExternalRunFSR" );

#############################################################################
##
#F  WriteTEXRunFSR( <output>, <fsr>, <ist>, <numsteps> ) . . . . . . . . write elm to file
##
##  <#GAPDoc Label="WriteTEXRunFSR">
##  <ManSection>
##  <Func Name="WriteTEXRunFSR" Arg="output, fsr, ist, nums,  strGen, gen"/>
##  <Func Name="WriteTEXRunFSRByGenerator" Arg="output, fsr, ist, nums, strGen, gen"/>
##
##  <Description>
##  <C>WriteTEXRunFSR</C> is an output to a *.tex file version of RunFSR(<A>fsr</A>,
##   <A>ist</A>, <A>num</A>), see  <Ref Meth="RunFSR" /> for details.
##  It writes a table that can be included dircetly
##  (except for the label). Rows of the table represent the steps of the FSR and
##   include the state of the FSR and the elements from stages specfied by
##  outputTap, that is the sequence outputs at this step.
##  The table entries (FFEs) are printed using currently set basis of the
##  <A>fsr</A>.
##  When the run is finished, <C>WriteTEXSequence</C>
##  is called to record the output sequence in compact version.
##  <C>WriteTEXRunFSR</C> returns the sequence generated by this run.
##  <P/>
##  <C>WriteTEXRunFSRByGenerator</C>  writes all the elements as powers of the
##  generator <A>gen</A>. <P/>
##  NOTE: does not work for symbolic FSRs, however, all the components and the
##  output sequence can be written to a *.tex file using calls
##   <Ref Func="WriteTEXSymVecByGenerator" /> and
##   <Ref Func="WriteTEXSequenceByGenerator" />.
##
##  <P/>
##  NOTE: does not work for  <A>fsr</A> of type FILFUN !<P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.8]{WriteTEXRunFSR2}
##  \caption{Sample output of WriteTEXRunFSR and  WriteTEXRunFSRByGenerator}
##  \end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="WriteTEXRunFSR2.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteTEXRunFSR" );
DeclareGlobalFunction( "WriteTEXtableElmByGenerator" );
DeclareGlobalFunction( "WriteTEXRunFSRByGenerator" );



Print("outfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
