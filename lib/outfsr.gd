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
##						<Item> for LFSR: show the <C>FeedbackPoly</C> and wheter or
##  not the <A>fsr</A> is empty</Item>
##  					<Item> for NLFSR: show the <C>MultivarPoly</C> and wheter or
##  not the <A>fsr</A> is empty</Item>
##				</List>
##  </Item>
##  <Item> <C>Print</C>: same as <C>Display/View</C> if <A>fsr</A> is empty,
##  otherwise it also shows the values of components  <C>state</C> ,
##  <C>numsteps</C> and <C>basis</C></Item>
##  <Item> <C>PrintAll</C>: same as <C>Print</C> if <A>fsr</A> is empty,
##  otherwise it also shows the values of all four components <C>init</C>,
##  <C>state</C> , <C>numsteps</C> and <C>basis</C>
##  with additional information about the underlying field and the tap positions
##  </Item>
##  </List>
##  Both <C>Print</C> and <C>PrintAll</C> can be used with optional parameter
##  <A>b</A> for desiered output format: when <C>true</C> the output will use
##  the currently chosen basis.
##  <P/>
##  Examples below show different outputs for an LFSR:
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");;
##  gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);;
##  gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
##  gap> test := LFSR(K, f, l);;
##  gap> Print(test);
##  empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
##  gap> ist := [ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ];; LoadFSR(test, ist);
##  Z(2)^0
##  gap> Print(test);
##  LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with current state =[ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ]
##  after  0 steps
##  gap> RunFSR(test,5);
##  [ Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
##  gap> Print(test);
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
##  gap>  PrintAll(test, true);
##  LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0  given by FeedbackPoly = y^4\
##  +y+Z(2^4)
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
##  Examples below show different outputs for an NLFSR:
##  <Example>
##  <![CDATA[
##  gap>  F := GF(2);; ChooseField(F);
##  You can now create an NLFSR with up to 100 stages
##  with up to  100 nonzero terms
##  gap>  clist := [One(F), One(F)];; mlist := [x_0*x_1, x_2];;
##  gap>  test := NLFSR(F, clist, mlist, 3);
##  < empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_0*x_1+x_2>
##  gap> Display(test);
##  < empty NLFSR of length 3 over GF(2),
##   given by MultivarPoly = x_0*x_1+x_2>
##  gap> PrintAll(test,true);
##  empty NLFSR of length 3 over GF(2),
##    given by MultivarPoly = x_0*x_1+x_2
##  with basis =[ Z(2)^0 ]
##  with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
##  with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
##  after initialization
##  with output from stage S_0
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
##  <Func Name="WriteAllFSR" Arg="output, fsr"/>
##  <Func Name="WriteTEXAllFSR" Arg="output, fsr"/>
##
##  <Description>
##  <C>WriteAllFSR</C> is equivalent to PrintAll, but it writes to an output
##  stream. <C>WriteTEXAllFSR</C> formats the output for *.tex files. <P/>
##  NOTE: For both versions, the basis switch must be present and if <E>true</E>, the
##  currently set basis of the
##   <A>fsr</A> is used.
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
##  <Func Name="WriteTEXSequenceByGenerator"
##  Arg="output, fsr, sequence, strGen, gen"/>
##
##  <Description>
##  <C>WriteSequenceFSR</C> writes the sequence generated by some version of
##  RunFSR(lfsr)  to *.txt file, with addition of separating sequences from
##  different taps and writing them in currently set
##  basis of the <A>fsr</A>.
##  <P/>
##  <C>WriteTBSequenceFSR</C> is a version of <C>WriteSequenceFSR</C>
##   intended for testbenching purposes: the generated sequence is written
##  to *.txt file, with sequences from different taps separated into
##  <E>columns</E> separated by "\t". Again the
##  currently set basis of the <A>fsr</A> is used.
##  The order of columns is determined by  <C>OutputTap(<A>fsr</A>)</C>.
##  <P/>
##  <C>WriteTEXSequenceByGenerator</C> is a *.tex version of
##  <C>WriteSequenceFSR</C>  but allows to
##  write the sequence elements as powers of a chosen generator <A>gen</A>.
##  Generator <A>gen</A> is used to get the exponents of the elements, and the
##  elements themselfs are printed as for example <M>\alpha^{exponent}</M>,
##  where <A>strGen</A> is set to "alpha" ( it must be a string representing
##  a greek letter in *.tex). Use of "omega" is not allowed.
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
##  <Func Name="WriteNonlinRunFSR" Arg="output, fsr, ist, elmvec"/>
##
##  <Description>
##  <C>WriteRunFSR</C> is an output to *.txt version of RunFSR(<A>fsr</A>,
##   <A>ist</A>, <A>num</A>), with addition of separating sequences from
##  different taps and writing them in currently set basis
##  of the <A>fsr</A>. Before the run begins and after loading, the
##  <C>WriteAllFSR(output,  x, true)</C> is called to record the FSR being used.
##  When the run is finished, <C>WriteSequenceFSR</C> is called to record the
##  output sequence in compact version.
##  <C>WriteRunFSR</C> returns the sequence generated by this run.
##  <P/>
##  <C>WriteNonlinRunFSR</C> is an output to *.txt version of RunFSR(<A>fsr</A>,
##   <A>ist</A>, <A>elmvec</A>). <C>WriteNonlinRunFSR</C> returns a sequence
##  generated by this run, however, the length of returned sequence is
##  Length(<A>elmvec</A>)+1, because the first element of
##  the output sequence is the element that was loaded with <A>ist</A>. <P/>
##  An example of the the <C>WriteRunFSR</C>  output can be seen in figure below: <P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.6]{testLFSRtxt1}\caption{Sample output of WriteRunFSR}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="testLFSRtxt11.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>
##  An example of the the <C>WriteNonlinRunFSR</C>  output can be seen in figure below: <P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.6]{testLFSRtxt2}\caption{Sample output of WriteNonlinRunFSR}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="testLFSRtxt2.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteRunFSR" );
DeclareGlobalFunction( "WriteNonlinRunFSR" );

#############################################################################
##
#F  WriteTEXRunFSR( <output>, <fsr>, <ist>, <numsteps> ) . . . . . . . . write elm to file
##
##  <#GAPDoc Label="WriteTEXRunFSR">
##  <ManSection>
##  <Func Name="WriteTEXRunFSR" Arg="output, fsr, ist, numsteps"/>
##  <Func Name="WriteTEXNonlinRunFSR" Arg="output, fsr, ist, numsteps"/>
##  <Func Name="WriteTEXRunFSRByGenerator" Arg="output, fsr, ist, numsteps, strGen, gen"/>
##
##  <Description>
##  <C>WriteTEXRunFSR</C> is an output to *.tex version of RunFSR(<A>fsr</A>,
##  <A>ist</A>, <A>num</A>), which writes a table that can be included dircetly
##  (except for the label). Rows of the table represent the steps of the FSR and
##   include the state of the FSR and the elements from stages specfied by
##  outputTap, that is the sequence outputs at this step.
##  The table entries (FFEs) are printed using currently set basis of the <A>fsr</A>.
##  When the run is finished, <C>WriteTEXSequenceByGenerator</C>
##  is called to record the output sequence in compact version.
##  <C>WriteTEXRunFSR</C> returns the sequence generated by this run.
##  <P/>
##  An example of the the <C>WriteTEXRunFSR</C>  output can be seen in figure below: <P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.65]{testLFSRtex1}\caption{Sample output of WriteTEXRunFSR}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="testLFSRtex1.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>
##  <C>WriteTEXNonlinRunFSR</C> TO DO
##  <P/>
##  <C>WriteTEXRunFSRByGenerator</C>  is a *.tex version of <C>WriteTEXRunFSR</C>
##  but instead of using the currently set basis of the <A>fsr</A>, the table
##  entries are printed as  powers of a chosen generator <A>gen</A>.
##  Generator <A>gen</A> is used to get the exponents of the elements, and the
##  elements themselfs are printed as for example <M>\alpha^{exponent}</M>, where
##  <A>strGen</A> is set to "alpha" ( it must be a string representing a greek
##  letter in *.tex). Use of "omega" is not allowed. <P/>
##  An example of the the <C>WriteTEXRunFSRByGenerator</C>  output can be seen in figure below: <P/>
##  <Alt Only="LaTeX">\begin{figure}\centering
##  \includegraphics[scale=0.65]{testLFSRtex2}\caption{Sample output of WriteTEXRunFSRByGenerator}\end{figure}</Alt>
##  <Alt Only="HTML">&lt;img src="testLFSRtex2.jpg" align="center" /></Alt>
##  <Alt Only="Text">/See diagrams in HTML and PDF versions of the manual/</Alt>
##  <P/>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteTEXRunFSR" );
DeclareGlobalFunction( "WriteTEXRunFSRByGenerator" );



Print("outfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
