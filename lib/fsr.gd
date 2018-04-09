#############################################################################
##
#W  fsr.gd                   GAP Package                   nusa zidaric
##
##

###############################################################################
##
##  <#GAPDoc Label="fsr">
##  <Index>fsr</Index>
##  We define an object &FSR; (Feedback Shift Register), which can come in two 
##  flavours: with linear feedback <Ref Func="LFSR" /> and nonlinear feedback  
##  <Ref Func="NLFSR" />.
##  Because of many similarities between the two, the basic common functionality
##  can be found here, while specialized functions (such as <C>LFSR</C> and 
##  <C>NLFSR</C> object creation) can be found in corresponding sections. Three 
##  basic functionalities are defined for &FSR; objects of both types: 
##  <List>
##  <Item><C>LoadFSR</C> - load the initial state. </Item>
##  <Item><C>StepFSR</C> - perform one step: compute the new state and output 
##  the next sequence element(s). </Item> 
##  <Item><C>RunFSR</C> - perform a sequence of steps.</Item>  
##  </List>
##  <#/GAPDoc>

#############################################################################
##
#C  IsFSR( <obj> )
##
##  <#GAPDoc Label="IsFSR">
##
##  <ManSection>
##  <Filt Name="IsFSR" />
##  <Description>
##  This is the category of <C>FSR</C> objects.
##  Objects in this category are created
##  using functions <Ref Func="LFSR" /> or <Ref Func="NLFSR" />.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareCategory( "IsFSR",  IsObject );


#############################################################################
##
#F  FSRFamily( <p> )
##
##
##  copied from FFEFamily :)
##
##  <#GAPDoc Label="FSRFamily">
##  <ManSection>
##  <Fam Name="FSRFamily" />
##  <Description>
##  This is the family of <C>FSR</C>s with characteristic <P/>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#
DeclareGlobalFunction( "FSRFamily" );

## storing initial state , current state and number of steps already performed
DeclareRepresentation( "IsFSRRep", IsComponentObjectRep and
IsAttributeStoringRep and IsFSR, ["init", "state", "numsteps", "basis"] );


DeclareProperty( "IsFSRFilter", IsFSR );
DeclareSynonym( "IsFSRFIL", IsFSR and IsFSRFilter);
DeclareProperty( "IsNonLinearFeedback", IsFSR );
DeclareSynonym( "IsNLFSR", IsFSR and IsNonLinearFeedback);
DeclareProperty( "IsLinearFeedback", IsFSR );
DeclareSynonym( "IsLFSR", IsFSR and IsLinearFeedback);

#############################################################################
##
#A  FieldPoly( <fsr> )
#A  UnderlyingField( <fsr> )
#A  FeedbackVec( <fsr> )
#A  OutputTap( <fsr> )
##
##  <#GAPDoc Label="FieldPoly">
##  <ManSection>
##  <Attr Name="FieldPoly" Arg='fsr' />
##  <Attr Name="UnderlyingField" Arg='fsr'/>
##  <Attr Name="FeedbackVec" Arg='fsr'/>
##  <Attr Name="OutputTap" Arg='fsr' />
##  <Description>
##  <C>FieldPoly</C> of the <A>fsr</A> stores the irreducible polynomial used to
##  construct the extension field or 1 in case of a prime field.<P/>
##  <C>UnderlyingField</C> of the <A>fsr</A> is the finite field over which the
##  <A>fsr</A> is defined
##  (all indeterminates and constants are from this field). <P/>
##  NOTE: it may seem redundant to store both <C>FieldPoly</C> and
##  <C>UnderlyingField</C>, especially since they can also be accessed from the
##  basis component of the <A>fsr</A>, however,
##  they are used by other functions in the package. <P/>
##  <C>FeedbackVec</C> of the <A>fsr</A> stores the coefficients of the
##  <C>FeedbackPoly</C> without its
##  leading term in case of <C>LFSR</C>,
##  and coefficients of the nonzero monomials present in the multivariate
##  function defining the feedback in case of <C>NLFSR</C>.<P/>
##  <C>OutputTap</C> holds the output tap position(s): the sequence elements
##  are taken from the stage(s) listed in <C>OutputTap</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareAttribute( "FieldPoly", IsFSR );
DeclareAttribute( "UnderlyingField", IsFSR );
DeclareAttribute( "FeedbackVec", IsFSR );
DeclareAttribute( "OutputTap", IsFSR );



#############################################################################
##
#M  GeneratorOfUnderlyingField( <fsr> )    . . . .. get generator of zechs log
##
##
##  <#GAPDoc Label="GeneratorOfUnderlyingField">
##  <ManSection>
##  <Meth Name="GeneratorOfUnderlyingField" Arg="fsr"/>
##
##  <Description>
##  <C>GeneratorOfUnderlyingField</C> returns the root of the defining
##  polynomial if the root is also a generator, otherwise it returns the first
##  element <M>x \ni: order(x)=Size(F)-1</M> by calling <C>GeneratorOfField</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>


DeclareOperation( "GeneratorOfUnderlyingField", [IsFSR]);


#############################################################################
##
#M  FFEextCoefficients( <fsr> )    . . . .. get generator of zechs log
##
##
##  <#GAPDoc Label="FFEextCoefficients">
##  <ManSection>
##  <Meth Name="FFEextCoefficients" Arg="fsr"/>
##
##  <Description>
##  <C>FFEextCoefficients</C> returns the vector of nonzero coefficients that  
##  belong to the extension field but not ground field <M>\mathcal(F)_p</M>.
##  If <Ref Attr="UnderlyingField" /> is a prime field, the method will return
##  <C>fail</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>



DeclareOperation( "FFExtCoefficients", [IsFSR] );


#############################################################################
##
#A  Length( <fsr> )
#A  InternalStateSize( <fsr> )
#A  Threshold( <fsr> )
##
##  <#GAPDoc Label="Length">
##  <ManSection>
##  <Attr Name="Length" Arg='fsr' />
##  <Attr Name="InternalStateSize" Arg='fsr'/>
##  <Attr Name="Threshold" Arg='fsr'/>
##
##  <Description>
##  <C>Length</C> of the <A>fsr</A> is the number of its stages.<P/>
##  <C>InternalStateSize</C> of the <A>fsr</A> is size in bits needed to store
##  the state computed as <M>length \cdot width</M>, where
##  <M> width = DegreeOverPrimeField(UnderlyingField(<A>fsr</A>))</M>.
##  <P/>
##  <C>Threshold</C> of the <A>fsr</A> is currently set to
##  <M>Characteristic(<A>fsr</A>)^t+\ell</M>,
##  where <M>t=InternalStateSize(<A>fsr</A>)</M> and
##  <M>\ell=Length(<A>fsr</A>)</M>.
##  <C>Threshold</C> is not related to the <A>fsr</A> itself, but to the number
##  of times the <A>fsr</A> can be clocked, that is it serves as the upper
##  threshold to the length of the sequence produced. <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Length", IsFSR );
DeclareAttribute( "InternalStateSize", IsFSR );
DeclareAttribute( "Threshold", IsFSR );

#############################################################################
##
#M  ChangeBasis( <fsr>, <B> )
#M  WhichBasis( <fsr> )
##
##  <#GAPDoc Label="ChangeBasis">
##  <ManSection>
##  <Meth Name="ChangeBasis" Arg='fsr, B' />
##  <Meth Name="WhichBasis" Arg='fsr' />
##
##  <Description>
##  <C>ChangeBasis</C> allows changing the basis of the <A>fsr</A> to basis
##  <A>B</A>. The argument <A>B</A> must be given for the
##  <C>UnderlyingField(fsr)</C> over its prime subfield.
##  <P/>
##  <C>WhichBasis</C> returns the basis currently set for the <A>fsr</A>.
##  Elements in the <A>fsr</A> state are still represented in &GAP; native
##  representation, but the functions with basis switch
##  turned on will print the elements w.r.t. to currently set basis.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("ChangeBasis", [IsFSR,  IsBasis]);
DeclareOperation("WhichBasis", [IsFSR]);

#############################################################################
##
#M  LoadFSR( <fsr>, <ist> )
##
##  <#GAPDoc Label="LoadFSR">
##  <ManSection>
##  <Meth Name="LoadFSR" Arg='fsr, ist' />
##
##  <Description>
##  Loading the <A>fsr</A> with the initial state <A>ist</A>, which is a
##  <A>FFE</A> vector of same length as <A>fsr</A> and with elements from its
##  underlying finite field. If either of those two requirements is violated,
##  loading fails and error message appears. At the time of loading
##  the initial sequence element(s) (i.e., zeroth element(s)) are obtained and
##  <C>numsteps</C> is set to 0.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("LoadFSR", [IsFSR,  IsFFE]);
DeclareOperation("LoadFSR", [IsFSR,  IsFFECollection]);
#DeclareProperty("IsEmpty", IsFSR); DONT coz once set cant change again


# TO DO : from initial state and number of steps , knowing the feedback
#polynomial, we can check if
## current state is
# VALID (if we can get it from initial state in num of steps), and if not
# valid then reset the LFSR
# is it the same for both ????

#############################################################################
##
#M  StepFSR( <fsr>)
#M  StepFSR( <fsr>, <elm>)
##
##  <#GAPDoc Label="StepFSR">
##  <ManSection>
##  <Meth Name="StepFSR" Arg='fsr[, elm]' />
##  <Returns>
##  The next sequence element(s) generated by  <A>fsr</A> or an
##  an error if the <A>fsr</A> is not loaded.
##  </Returns>
##  <Description>
##  <P/><C>StepFSR</C> performs one step the <A>fsr</A>, i.e., compute the new 
##  <C>state</C> and update the <C>numsteps</C>, then output the elements 
##  denoted by <C>OutputTap</C>. Two options are possible:  
##  <List>
##  <Item><E>regular step</E> - the new state 
##  depends only of the feedback and the current state (call 
##  <C>StepFSR</C>(<A>fsr</A>)). </Item>
##  <Item><E>nonlinear step</E> - the optional parameter <A>elm</A> is used and
##  then the new element is computed as
##  a sum of the computed feedback and <A>elm</A>, i.e., new state 
##  depends only of the feedback, the current state and the input <A>elm</A> (call 
##  <C>StepFSR</C>(<A>fsr</A>, <A>elm</A>)). The element <A>elm</A> must be an
##  element of the underlying finite field. </Item>
##  </List>
##  NOTE: the use of the optional parameter <A>elm</A> 
##  is a way to destroy the linearity of an <C>LFSR</C>, therefore we call it a 
##  <C>nonlinear step</C>. Similarly, the <C>NLFSR</C> can also have
##  an extra element <A>elm</A> added to the (already nonlinear) feedback.<P/>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##


DeclareOperation("FeedbackFSR", [IsFSR]);
DeclareOperation("StepFSR", [IsFSR]);
DeclareOperation("StepFSR", [IsFSR, IsFFE]);









# load + 1step

DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFECollection, IsBool]);
DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFECollection, IsFFE, IsBool]);
DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFE, IsBool]);
DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFE, IsFFE, IsBool]);

DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFECollection]);
DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFECollection, IsFFE]);
DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFE]);
DeclareOperation("StepFSRFIL", [IsFSRFIL, IsFFE, IsFFE]);








DeclareOperation("PrintHeaderRunFSR", [IsFSR, IsFFE, IsPosInt]);
DeclareOperation("PrintHeaderRunFSR", [IsFSR, IsFFE, IsFFE, IsPosInt]);



#############################################################################
##
#O  RunFSR( <FSR> , <num>, <pr> )
##                ......... Ib.   run for num steps with/without print to shell
#O  RunFSR( <FSR> , <num> )
##          ............... II.  run for num steps without print to shell
#O  RunFSR( <FSR> , <pr> )
##         ................ IIIb. run with/without print to shell
#O  RunFSR( <FSR> )
##  ....................... IV.  run without print to shell
#O  RunFSR( <FSR> , <ist>, <num>, <pr>)
##                      ... Vb.   load new initial state then run for
##                                num-1 steps with/without print to shell
#O  RunFSR( <FSR> , <ist>, <num>)
##                ......... VI.  load new initial state then run for num-1 steps
##                               without print to shell
#O  RunFSR( <FSR> , <ist>)
##         ................ VII. load new initial state then run
##                               without print to shell
## nonlinear versions
#O  RunFSR(<FSR>, <elm>, <num>, <pr>)
##                   ...... VIIIb. run for num steps with the same nonlinear
##                          input on each step and with/without print to shell
#O  RunFSR(<FSR>, <elm>, <num>)
##             ............ IX.   run for num steps with the same nonlinear
##                          input on each step without print to shell
#O  RunFSR(<FSR>, <ist>, <elmevec>, <pr> )
##                       .. Xb.    run for num steps with the different
##                     nonlinear input on each step with/without print to shell
##
##  <#GAPDoc Label="RunFSR">
##  <ManSection>
##  <Meth Name="RunFSR" Arg='fsr [, ist, num, pr]'/>
##  <Meth Name="RunFSR" Arg='fsr , elm [, num, pr]'
##  Label="with same nonlinear input"/>
##  <Meth Name="RunFSR" Arg='fsr , ist, elmvec [, pr]'
##  Label="load and run with different nonlinear input"/>
##  <Meth Name="RunFSR" Arg='fsr , z, elmvec [, pr]'
##  Label="run with different nonlinear input"/>
##  <Returns>
##  A sequence of elements generated by <C>FSR</C>.
##  </Returns>
##  <Description> 
##  All <C>RunFSR</C> calls perform a sequence of &FSR; steps. 
##  The <A>fsr</A> will be run for <M>min(<A>num</A>, Threshold(<A>fsr</A>))</M>
##   number of steps: value Threshold(<A>fsr</A>) is used by all versions
##  without explicit <A>num</A> and enforced when <A>num</A> exceeds
##  Threshold(<A>fsr</A>), see <Ref Attr="Threshold" /> for details.
##  <P/>
##  The <C>RunFSR</C> calls where the initial state <A>ist</A> is passed as an 
##  argument are the load-and-run calls. As with <C>StepFSR</C>, <C>RunFSR</C> 
##  also exists as a regular and nonlinear run. The nonlinear runs are 
##  <C>RunFSR</C> calls where either a single finite field element <A>elm</A>
##  or a vector of finite field elements <A>elmvec</A> are passed as an 
##  argument. 
##  <P/>
##  There is an optional printing switch <A>pr</A>,
##  with default set to <E>false</E>; if <E>true</E> then the state and the
##  output sequence element(s) are printed in &GAP; shell on every step of
##  the <A>fsr</A> (we call this output for <C>RunFSR</C>), and
##  the currently set basis <A>B</A> is used for representation of elements.
##  <List>
##  <Item> <C>RunFSR(<A> fsr[, num, pr] </A>)</C> - run <A>fsr</A> for
##  <A>num</A>/<A>threshold</A> steps with/without output.</Item>
##  <Item> <C>RunFSR(<A> fsr, ist[, num, pr] </A>)</C> - load <A>fsr</A> with
##  <A>ist</A>, then run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps
##  with/without output (i.e., <E>linear</E> version).</Item>
##  <Item> <C>RunFSR(<A> fsr, elm [, num, pr] </A>)</C> - run <A>fsr</A> for
##  <A>num</A>/<A>threshold</A> steps, whereby the SAME element <A>elm</A> is
##  added to the feedback at each step, with/without output
##  (i.e., <E>non-linear</E> version).</Item>
##  <Item> <C>RunFSR(<A> fsr,  ist, elmvec [, pr] </A>)</C> - load <A>fsr</A>
##  with <A>ist</A>, then run <A>fsr</A> for <E>Length(<A>elmvec</A>)</E> steps,
##   whereby one element of <A>elmvec</A> is added to the feedback at
##  each step (starting with <A>elmvec[1]</A>), with/without output (i.e.,
##  <E>non-linear</E> version). NOTE: the sequence returned has length
##  <E>Length(elmvec)+1</E>, because the zeroth sequence element is returned at
##   the	time of loading the <C>FSR</C>.</Item>
##  <Item> <C>RunFSR(<A> fsr,  z, elmvec [, pr] </A>)</C> - input <A>z</A> must
##  be set to 0 to indicate we want to continue a run with new <A>elmvec</A>:
##  run <A>fsr</A> for  <E>Length(<A>elmvec</A>)</E> steps, whereby one element
##  of <A>elmvec</A> is added to	the feedback at each step (starting with
##  <A>elmvec[1]</A>), with/without output (i.e., <E>non-linear</E> version).
##  NOTE: the sequence returned has length  <E>Length(elmvec)</E>.</Item>
##  </List>
##  For the load and run versions, element seq<M>_0</M> is a part of the output
##  sequence, hence the output sequence has the length <A>num+1</A>/
##  <A>threshold+1</A>/<A>Length(ffevec)+1</A>.
##  <P/>
##  For versions without the loading of <A>ist</A>, calling <C>RunFSR</C>
##  returns an error if
##  the <A>fsr</A> is not loaded!<P/>
##  The ouput of <C>RunFSR</C> is:
##  <List>
##  <Item> sequence of <A>FFE</A>s: seq<M>_0</M>, seq<M>_1</M>, seq<M>_2</M>,
##  <M>\dots ,</M>  for <E>Length</E>(<E>OutputTap</E>)<M>=1</M>.</Item>
##  <Item> sequence of vectors, each of them with <M>t</M> <A>FFE</A>s:
##  seq<M>_0</M>, seq<M>_1</M>, seq<M>_2</M>, <M>\dots ,</M>
##  where seq<M>_i=(</M>seq<M>_{i1}</M>,<M>\dots ,
##				</M>seq<M>_{it}</M>) for <E>Length</E>(<E>OutputTap</E>)<M>=t</M>.
##  </Item>
##  </List>
##  Example of <C>RunFSR</C> called for an lfsr <C>test</C> over <M>F_{2^4}</M>,
##  with initial state <C>ist</C>, print switch <E>true</E>, basis <C>B</C>,
##  and with run length 5:
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");;
##  gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
##  gap> y := X(F, "y");; l := y^4 + y^3 + y + Z(2^4);;
##  gap> test := LFSR(K, f, l);;
##  < empty LFSR given by FeedbackPoly = y^4+y+Z(2^4)>
##  gap> ist :=[0*Z(2), Z(2^4), Z(2^4)^5, Z(2)^0 ];;
##  gap> RunFSR(test, ist, 5, true);
##  using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  elm		[ 3,	...	...,0 ]  with taps  [ 0 ]
##  	[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]
##                                                              	[ 1, 0, 0, 0 ]
##  	[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]
##                                                              	[ 1, 1, 0, 1 ]
##  	[ [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]
##                                                              	[ 0, 1, 1, 0 ]
##  	[ [ 0, 1, 1, 1 ], [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]
##                                                              	[ 0, 0, 0, 0 ]
##  	[ [ 1, 1, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ] ]
##                                                              	[ 1, 0, 1, 1 ]
##  	[ [ 1, 0, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 1, 0, 0 ] ]
##                                                              	[ 1, 1, 0, 0 ]
##  [ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^9 ]
##  ]]>
##  </Example>
##  Example of <C>RunFSR</C> called for an lfsr <C>test</C> over <M>F_{2^4}</M>,
##  with initial state <C>ist</C>, print switch <E>true</E>, basis
##   <C>B</C>, and with 5 nonlinear inputs given as <C>elmvec</C>:
##  <Example>
##  <![CDATA[
##  gap> elmvec := [Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6];;
##  gap> RunFSR(test, ist, elmvec, true);
##  using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
##  elm			[ 3,	...	...,0 ]  with taps  [ 0 ]
##  [ 0, 0, 0, 0 ] [ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]
##                                                              	[ 1, 0, 0, 0 ]
##  [ 1, 0, 1, 1 ] [ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]
##                                                              	[ 1, 1, 0, 1 ]
##  [ 1, 0, 1, 1 ] [ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]
##                                                              	[ 0, 1, 1, 0 ]
##  [ 1, 1, 0, 1 ] [ [ 1, 0, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
##                                                              	[ 0, 0, 0, 0 ]
##  [ 0, 1, 0, 0 ] [ [ 1, 1, 1, 0 ], [ 1, 0, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ] ]
##                                                              	[ 0, 0, 0, 0 ]
##  [ 0, 0, 0, 1 ] [ [ 0, 0, 1, 1 ], [ 1, 1, 1, 0 ], [ 1, 0, 1, 0 ], [ 1, 1, 0, 0 ] ]
##                                                              	[ 1, 1, 0, 0 ]
##  [ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9 ]
##  ]]>
##  </Example>
##  In both examples above the there is a column <C>elm</C>, which is in first
##  case empty, because we are not adding nonlinear inputs to the feedback,
##  while in the second example, this column shows the element being added at
##  each step (empty in first row - the loading step).<P/>
##  Also note that in the two examples above, <C>RunFSR</C> will call
##  <C>LoadFSR</C> first, which adds the elm seq<M>{{_0}}</M> to the sequence,
##  so both sequences above are of length <A>num+1</A>/<A>Length(elmvec)+1</A>,
##   i.e.,6. <P/>
##  The last row in both examples is the actual sequence obtained from
##  this run, and is kept in Zechs logarithm representation. To represent the
##  elements in the first 6 rows, the basis printed out at the beginning is
##   used; it can be changed by using <C>ChangeBasis</C> call and
##  repeating <C>RunFSR</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



# although IsBool is only used with true when IsBasis is set (doesnt make sense
##   to have basis if we dont print steps)
# it is left too add an argument so method selection doesnt get confused
# problem with method selection: a basis will also have IsFFECollection = true
# so basis might get mistaken for initial state
# by having an extra parameter IsBool the number of arguments is different and 
# this problem is avoided




DeclareOperation("RunFSR", [IsFSR, IsPosInt, IsBool]);
#Ib.   run for num steps with/without print to shell 

DeclareOperation("RunFSR", [IsFSR, IsPosInt]);
#II.  run for num steps without print to shell  

DeclareOperation("RunFSR", [IsFSR,  IsBool]);
#IIIb. run with/without print to shell  

DeclareOperation("RunFSR", [IsFSR ]);
#IV.  run without print to shell  

DeclareOperation("RunFSR", [IsFSR,  IsFFECollection, IsPosInt, IsBool]);
DeclareOperation("RunFSR", [IsFSR,  IsFFECollColl, IsPosInt, IsBool]);
#Vb. load new initial state then run for num-1 steps with/without print to shell


DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsPosInt]);
DeclareOperation("RunFSR", [IsFSR, IsFFECollColl, IsPosInt]);
#VI.  load new initial state then run for num-1 steps without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsBool]);
DeclareOperation("RunFSR", [IsFSR, IsFFECollColl, IsBool]);
#VIIb. load new initial state then run without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFECollection]);
DeclareOperation("RunFSR", [IsFSR, IsFFECollColl]);
#VII. load new initial state then run without print to shell  

## nonlinear versions
DeclareOperation("RunFSR", [IsFSR,  IsFFE, IsPosInt, IsBool]);
#VIIIb. run for num steps with the same nonlinear input on each step and 
#with/without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFE, IsPosInt]);
#IX. run for num steps with the same nonlinear input on each step 
#without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFE, IsBool]);
#Xb.   run with the same nonlinear input on each step without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFE]);
#X.   run with the same nonlinear input on each step without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsFFECollection, IsBool]);
# XIb. run for num steps with the different nonlinear input on each step and 
#with/without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsFFECollection]);
# XI. run for num steps with the different nonlinear input on each step and 
#with/without print to shell  


DeclareOperation("RunFSR", [IsFSR, IsZero, IsFFECollection, IsBool]);
# XIIb. run for num steps with the different nonlinear input on each step and 
#with/without print to shell  

DeclareOperation("RunFSR", [IsFSR, IsZero, IsFFECollection]);
# XII. run for num steps with the different nonlinear input on each step and 
#with/without print to shell  





Print("fsr.gd OK,\t");
