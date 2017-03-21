#############################################################################
##
##
#W  outfsr.gd          LFSR Package                  Nusa
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
##  <Meth Name="ViewObj" Arg='lfsr  ' />
##  <Meth Name="PrintObj" Arg='lfsr [,b] ' />
##  <Meth Name="PrintAll" Arg='lfsr [,b] ' />
##
##  <Description>
##  Different detail on <A>nsr</A> created either by <Ref Func="LFSR" /> or <Ref Func="NLFSR" />:
##  <List>
##  <Item> <C>Display/View</C>:  
##  			<List>
##						<Item> for LFSR: show the <C>CharPoly</C> and wheter or not the <A>fsr</A> is empty</Item>
##  					<Item> for NLFSR: show the <C>MultivarPoly</C> and wheter or not the <A>fsr</A> is empty</Item>
##				</List>
##  </Item>
##  <Item> <C>Print</C>: same as <C>Display/View</C> if <A>fsr</A> is empty, otherwise it also shows the values of components  <C>state</C> , <C>numsteps</C> and <C>basis</C></Item>
##  <Item> <C>PrintAll</C>: same as <C>Print</C> if <A>fsr</A> is empty, otherwise it also shows the values of all four components <C>init</C>, <C>state</C> , <C>numsteps</C> and <C>basis</C>
##  with additional information about the underlying field and the tap positions</Item>
##  </List> 
##  Both <C>Print</C> and <C>PrintAll</C> can be used with optional parameter <A>b</A> for desiered output format: when <C>true</C> the output will used the currently chosen basis. 
##  <P/>
##  Examples below show different outputs for an LFSR: 
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");;
##  gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; 
##  gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
##  gap> test := LFSR(K, f, l);;
##  gap> Print(test);           
##  empty LFSR over GF(2^4) given by CharPoly = y^4+y+Z(2^4)
##  gap> ist := [ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ];; LoadFSR(test, ist);
##  Z(2)^0
##  gap> Print(test);                         
##  LFSR over GF(2^4)  given by CharPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with current state =[ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ]
##  after  0 steps
##  gap> RunFSR(test,5);
##  [ Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
##  gap> Print(test);   
##  LFSR over GF(2^4)  given by CharPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with current state =[ Z(2^2), Z(2^4)^2, Z(2^4)^2, Z(2^4)^11 ]
##  after  5 steps
##  gap> PrintAll(test);
##  LFSR over GF(2^4)  given by CharPoly = y^4+y+Z(2^4)
##  with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
##  with initial state  =[ 0*Z(2), Z(2^4), Z(2^2), Z(2)^0 ]
##  with current state  =[ Z(2^2), Z(2^4)^2, Z(2^4)^2, Z(2^4)^11 ]
##  after 5 steps
##  with output from stage S_0
##  gap>  PrintAll(test, true);
##  LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0  given by CharPoly = y^4\
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
#F  WriteAllFSR( <output>, <fsr> ) . . . . . . . . same as PrintAll, but to a file
##
##  <#GAPDoc Label="WriteAllFSR">
##  <ManSection>
##  <Func Name="WriteAllFSR" Arg="output, fsr"/>
##
##  <Description>
##  Equivalent to PrintAll , but it writes to an output stream. NOTE: The basis switch must be present! 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareGlobalFunction( "WriteAllFSR" );
#DeclareGlobalFunction( "WriteAllLFSRTEX" );

#############################################################################
##
#F  WriteRunLFSR( <output>, <lfsr>, <ist>, <numsteps> ) . . . . . . . . write elm to file
##
##  <#GAPDoc Label="WriteRunLFSR">
##  <ManSection>
##  <Func Name="WriteRunLFSR" Arg="output, lfsr, ist, numsteps"/>
##  <Func Name="WriteRunLFSRTEX" Arg="output, lfsr, ist, numsteps"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#DeclareGlobalFunction( "WriteRunLFSR" );
#DeclareGlobalFunction( "WriteRunLFSRTEX" );


Print("outfsr.gd OK,\t");
#E  outlfsr.gd  . . . . . . . . . . . . . . . . . . . . . . . . . . . ends here
