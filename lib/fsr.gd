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
##  flavours: with linear feedback <Ref Func="LFSR" /> and external feedback
##  <Ref Func="NLFSR" />. The third FSR object is called <Ref Func="FILFUN" />,
##  i.e. ``filtering
##  function''. A filtering function is simply a
##  multivariate function, and because of the similarities between filtering
##  functions and NLFSR feedbacks, the FILFUN is
##  created as an FSR object, which allows the reuse of most NLFSR methods.
##  Because of many similarities between the three, the basic common
##  functionality
##  can be found here, while specialized functions (such as <C>LFSR</C>,
##  <C>NLFSR</C> and <C>FILFUN</C> object creation) can be found in the
##  corresponding sections. Three
##  basic functionalities are defined for &FSR; objects of both types:
##  <List>
##  <Item><C>LoadFSR</C> - load the initial state. </Item>
##  <Item><C>StepFSR</C> - perform one step </Item>
##  <Item><C>RunFSR</C> - perform a sequence of steps.</Item>
##  </List>
##  Defining the FILFUN as an FSR calls for a fourth method:
##  <List>
##  <Item><C>LoadStepFSR</C> - load the initial state and perform one step.
##  </Item>
##  </List>
##  <C>LoadStepFSR</C> is implemented as <C>LoadFSR</C>, followed by
##  <C>StepFSR</C>.
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
##  Objects in this category are created using functions
##   <Ref Func="LFSR" />, <Ref Func="NLFSR" /> and <Ref Func="FILFUN" />.
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
##  This is the family of <C>FSR</C>s with characteristic....
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#
DeclareGlobalFunction( "FSRFamily" );

## storing initial state , current state and number of steps already performed
## added sym field to keep track if symbolic computation
DeclareRepresentation( "IsFSRRep", IsComponentObjectRep and
IsAttributeStoringRep and IsFSR, ["init", "state", "numsteps", "basis", "sym"] );


DeclareProperty( "IsFSRFilter", IsFSR );
DeclareSynonym(  "IsFILFUN", IsFSR and IsFSRFilter);
DeclareProperty( "IsNonLinearFeedback", IsFSR );
DeclareSynonym(  "IsNLFSR", IsFSR and IsNonLinearFeedback);
DeclareProperty( "IsLinearFeedback", IsFSR );
DeclareSynonym(  "IsLFSR", IsFSR and IsLinearFeedback);

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
##  function defining the feedback in case of <C>NLFSR</C> and <C>FILFUN</C>.
##  <P/><C>OutputTap</C> holds the output tap position(s): the sequence elements
##  are taken from the stage(s) listed in <C>OutputTap</C>. In case of FILFUL,
##  this attribute is set to stage <M>S_0</M> and is never used.
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
#M  ConstTermOfFSR( <fsr> )
##
##  <#GAPDoc Label="ConstTermOfFSR">
##  <ManSection>
##  <Meth Name="ConstTermOfFSR" Arg='fsr' />
##
##  <Description>
##  Returns the constant term of the polynomial defining the
##  feedback function for (N)LFSR or the filtering function for FILFUN.
##  Example below shows the constant term for a simple FILFUN and an LFSR.
##  <Example>
##  <![CDATA[
##  gap> test := FILFUN(GF(2), x_1^5+x_0*x_1+Z(2)^0);
##  < FILFUN of length 2 over GF(2),
##    with the MultivarPoly = x_0*x_1+x_1+Z(2)^0>
##  gap> ConstTermOfFSR(test);
##  Z(2)^0
##  gap> test := LFSR(GF(2), x_1^5+x_1^3+x_1);
##  < empty LFSR over GF(2)  given by FeedbackPoly = x_1^5+x_1^3+x_1 >
##  gap> ConstTermOfFSR(test);
##  0*Z(2)
##  ]]>
##  </Example>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareOperation( "ConstTermOfFSR",  [IsFSR]);






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
##  <M> width = DegreeOverPrimeField(UnderlyingField(<A>fsr</A>))</M>.<P/>
##
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
##  <C>UnderlyingField(fsr)</C> over its prime subfield.<P/>
##
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
#M  SymbolicFSR( <fsr> )
##
##  <#GAPDoc Label="SymbolicFSR">
##  <ManSection>
##  <Meth Name="SymbolicFSR" Arg='fsr' />
##
##  <Description>
##  <C>SymbolicFSR</C>  returns the value of component <C>sym</C>
##  currently set for the <A>fsr</A>. Component <C>sym</C> is updated during
##  the loading with <Ref Meth="LoadFSR" /> or during <Ref Meth="StepFSR" />,
##  when a symbol is used for the external step.
##  <C>SymbolicFSR</C> is shown in the
##  example for <Ref Meth="LoadFSR" />.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareOperation("SymbolicFSR", [IsFSR]);

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
##  vector of same length as <A>fsr</A>. The vector elements must be either
##  FFEs from the
##  underlying finite field of the <A>fsr</A> or symbols.
##  If either of these requirements is violated,
##  loading fails and error message appears. At the time of loading
##  the initial sequence element(s) (i.e., zeroth element(s)) are obtained and
##  <C>numsteps</C> is set to 0.<P/>
##  Symbols  <M>s_0, \dots, s_{199}</M> are prepared as global variables at the
##  time the package is loaded. Below is an example of loading an LFSR with
##  finite field elements and with symbols.
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);;  y := X(K, "y");;  l := y^3 + y + 1;;
##  gap> test :=  LFSR(K, l);
##  < empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
##  gap> ist := [One(K), One(K), One(K)];; LoadFSR(test,ist);;
##  gap> SymbolicFSR(test);
##  false
##  gap> ist := [s_2, s_1, s_0];; LoadFSR(test,ist);;
##  gap> SymbolicFSR(test);
##  true
##  ]]>
##  </Example>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##




DeclareOperation("LoadFSR", [IsFSR,  IsRingElementCollection]);
DeclareOperation("LoadFSR", [IsFSR,  IsRingElement]);  # is it ever used ?

#DeclareProperty("IsEmpty", IsFSR); DONT coz once set cant change again


# TO DO : from initial state and number of steps , knowing the feedback
#polynomial, we can check if
## current state is
# VALID (if we can get it from initial state in num of steps), and if not
# valid then reset the LFSR
# is it the same for both ????


#############################################################################
##
#M  FeedbackFSR( <fsr>)
##
##  <#GAPDoc Label="FeedbackFSR">
##  <ManSection>
##  <Meth Name="FeedbackFSR" Arg='fsr' />
##  <Returns>
##  The new element computed by evaluating the feedback function using the
##  current values from the <C>state</C>  component of the <A>fsr</A> or returns
##  an error if the <A>fsr</A> is not loaded. <P/>
##  In case of symbolic FSR, the resulting feedback is reduced w.r.t.
##  UnderlyingField <M>\mathbb{F}_q</M> using the relationship <M>s_i^q=s_i</M>.
##  </Returns>
##  <Description>

##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##

# compute new
DeclareOperation("FeedbackFSR", [IsFSR]);

#############################################################################
##
#M  StepFSR( <fsr>)
#M  StepFSR( <fsr>, <elm>)
##
##  <#GAPDoc Label="StepFSR">
##  <ManSection>
##  <Meth Name="StepFSR" Arg='fsr[, elm]' />
##  <Returns>
##  The next sequence element(s) generated by <A>fsr</A> in case of (N)LFSR and
##  the new value in case of FILFUN.
##  An error if the <A>fsr</A> is not loaded.
##  </Returns>
##  <Description>
##  <C>StepFSR</C> performs one step the <A>fsr</A>, i.e., call
##  <Ref Meth="FeedbackFSR" /> to compute the feedback value <M>fb = </M>
##  <C>FeedbackFSR</C>(<M>fsr</M>) and then
##  obtain the new element using one of two options:
##  <List>
##  <Item><E>regular step</E> - the new state
##  depends only of the feedback and the current state (call
##  <C>StepFSR</C>(<A>fsr</A>)): <M>new = fb </M>
## </Item>
##  <Item><E>external step</E> - the optional parameter <A>elm</A> is used and
##  then the new element is computed as
##  a sum of the computed feedback <M>fb</M> and <A>elm</A>, i.e., new state
##  depends on the feedback, the current state and the input <A>elm</A> (call
##  <C>StepFSR</C>(<A>fsr</A>, <A>elm</A>)): <M>new = fb  + elm</M>.
##  The element <A>elm</A> must be an
##  element of the underlying finite field or a symbol
##   <M>s_0, \dots, s_{199}</M>. </Item>
##  </List>

##  In case of the two true feedback shift registers LFSR and NLFSR, the
##  <C>state</C> and <C>numsteps</C> are updated, then the sequence element(s)
##  denoted by <C>OutputTap</C> are returned. The state is updated by shifting
##  the current state and updating the vacant stage with <M>new</M> computed
##  either as regular or external step. In case of the FILFUN, there is no
##  notion of shifting or registers; the
##  <C>state</C> and <C>numspets</C> are not updated, and the value <M>new</M>
##  is returned by the  <C>StepFSR</C>.


##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##


#regular step
DeclareOperation("StepFSR", [IsFSR]);
#external step
DeclareOperation("StepFSR", [IsFSR, IsRingElement]);




#############################################################################
##
#M  LoadStepFSR( <fsr>)
#M  LoadStepFSR( <fsr>, <elm>)
##
##  <#GAPDoc Label="LoadStepFSR">
##  <ManSection>
##  <Meth Name="LoadStepFSR" Arg='fsr[, elm, pr]' />
##  <Returns>
##  The next sequence element(s) generated by <A>fsr</A> in case of (N)LFSR and
##  the new value in case of FILFUN.
##  </Returns>
##  <Description>
##  <C>LoadStepFSR</C> calls  <Ref Meth="LoadFSR" />, followed by a regulat or
##  an external <Ref Meth="StepFSR" />.
##  A printswitch <A>pr</A> can also be used.
##  This method is implememented maianly for the FILFUNs, but also works for
##  (N)LFSRs. For the (N)LFSRs, <C>LoadStepFSR</C> will return two sequence
##  elements, <M>seq_0, seq_1</M>, where <M>seq_0</M> is the output from the
##   <C>OutputTap</C> stages after loading, and  <M>seq_1</M> the output after
##  the first step. For the FILFUNs, <C>LoadStepFSR</C>  returns only the
##  element  <M>new = fb </M> or  <M>new = fb  + elm</M>, as explained in
##   <Ref Meth="StepFSR" />.<P/>
##  Example of <C>LoadStepFSR</C> below is called for FILFUN <C>filfun</C> over
##  <M>\mathbb{F}_{2^4}</M>, first showing a regular and then the external
##  <C>LoadStepFSR</C>. Then, the regular <C>LoadStepFSR</C> is shown for an
##  NLFSR with the same multivariate polynomial.
##  <Example>
##  <![CDATA[

##  gap> F := GF(2^4);; f := x_0*x_1+x_2;; filfun := FILFUN(F, f);;
##  gap> LoadStepFSR(filfun, [Z(2)^0, Z(2)^0,Z(2)^0]);
##  0*Z(2)
##  gap> LoadStepFSR(filfun, [Z(2)^0, Z(2)^0,Z(2)^0], Z(2^4));
##  Z(2^4)
## gap> nlfsr := NLFSR(F, f,3);;
## gap> LoadStepFSR(nlfsr, [Z(2)^0, Z(2)^0,Z(2)^0]);
## [ Z(2)^0, Z(2)^0 ]

##  ]]>
##  </Example>


##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



# load + 1step
#regular step
DeclareOperation("LoadStepFSR", [IsFSR, IsRingElementCollection]);

#external step
DeclareOperation("LoadStepFSR", [IsFSR, IsRingElementCollection, IsRingElement]);

#regular step
DeclareOperation("LoadStepFSR", [IsFSR, IsRingElement]);

#external step
DeclareOperation("LoadStepFSR", [IsFSR, IsRingElement, IsRingElement]);



DeclareOperation("PrintHeaderRunFSR", [IsFSR, IsRingElement, IsPosInt]);
DeclareOperation("PrintHeaderRunFSR", [IsFSR, IsRingElement, IsRingElement, IsPosInt]);



#############################################################################
##
#O  RunFSR( <FSR> , <num>, <pr> )
##                ......... I.   run for num steps with/without print to shell
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
#O  RunFSR(<FSR>, <ist>, <elmevec>, <pr> )
##                       .. Xb.    run for num steps with the different
##                     external input on each step with/without print to shell
##
##  <#GAPDoc Label="RunFSR">
##  <ManSection>
##  <Meth Name="RunFSR" Arg='fsr [, ist, num, pr]'/>
##  <Meth Name="RunFSR" Arg='fsr , ist, elmvec [, pr]'
##  Label="load and run with different external input"/>
##  <Meth Name="RunFSR" Arg='fsr , z, elmvec [, pr]'
##  Label="run with different external input"/>
##  <Meth Name="RunFSR" Arg='filfun , istvec, [elmvec , pr]'
##  Label="run filfun with different initial state and external input"/>
##  <Returns>
##  A sequence of elements generated by the <C>FSR</C>.
##  </Returns>
##  <Description>
##  All <C>RunFSR</C> calls perform a sequence of &FSR; steps.
##  The <A>fsr</A> will be run for <M>min(<A>num</A>, Threshold(<A>fsr</A>))</M>
##   number of steps: value Threshold(<A>fsr</A>) is used by all versions
##  without explicit <A>num</A> and enforced when <A>num</A> exceeds
##   <Ref Attr="Threshold" />.
##  <P/>
##  The <C>RunFSR</C> calls where the initial state <A>ist</A> is passed as an
##  argument are the load-and-run calls. As with <Ref Meth="StepFSR" />,
##  <C>RunFSR</C>
##  also exists as a <E>regular</E> and <E>external</E> run. The external runs
##  are <C>RunFSR</C> calls with a vector of finite field elements
##  <A>elmvec</A> passed as an argument.
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
##  with/without output (i.e., <E>regular</E> version).</Item>
##  <Item> <C>RunFSR(<A> fsr,  ist, elmvec [, pr] </A>)</C> - load <A>fsr</A>
##  with <A>ist</A>, then run <A>fsr</A> for <E>Length(<A>elmvec</A>)</E> steps,
##   whereby one element of <A>elmvec</A> is added to the feedback at
##  each step (starting with <A>elmvec[1]</A>), with/without output (i.e.,
##  <E>external</E> version). NOTE: the sequence returned has length
##  <E>Length(elmvec)+1</E>, because the zeroth sequence element is returned at
##   the	time of loading the <C>FSR</C>.</Item>
##  <Item> <C>RunFSR(<A> fsr,  z, elmvec [, pr] </A>)</C> - input <A>z</A> must
##  be set to 0 to indicate we want to continue a run with new <A>elmvec</A>:
##  run <A>fsr</A> for  <E>Length(<A>elmvec</A>)</E> steps, whereby one element
##  of <A>elmvec</A> is added to	the feedback at each step (starting with
##  <A>elmvec[1]</A>), with/without output (i.e., <E>external</E> version).
##  NOTE: the sequence returned has length  <E>Length(elmvec)</E>.</Item>
##  <Item> <C>RunFSR(<A> filfun , istvec, [elmvec , pr] </A>)</C> - for the
##  FILFUNs only -
##  performs a sequence of
##  <Ref Meth="LoadStepFSR" /> calls with a new initial state on every step,
##  with/without output.
##  The number of <Ref Meth="LoadStepFSR" /> depends on the
##  length of <A>istvec</A>. When is used with
##  both <A>istvec</A> and <A>elmvec</A> (i.e., <E>external</E> version),
##  the two vectors must be of the same
##  length. </Item>
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
##  Example of <C>RunFSR</C> called for an LFSR <C>test</C> over
##  <M>\mathbb{F}_{2^4}</M>,
##  with initial state <C>ist</C>, print switch <E>true</E>, basis <C>B</C>,
##  and with run length 5:
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");;
##  gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
##  gap> y := X(F, "y");; l := y^4 + y^3 + y + Z(2^4);;
##  gap> test := LFSR(K, f, l);;
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
##  Example of <C>RunFSR</C> called for an LFSR <C>test</C> over
##  <M>\mathbb{F}_{2^4}</M>,
##  with initial state <C>ist</C>, print switch <E>true</E>, basis
##   <C>B</C>, and with 5 external inputs given as <C>elmvec</C>:
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
##  case empty, because the first example is showing the <E>regular</E> run,
##  while in the second example, this column shows the element being added at
##  each step of the <E>external</E> run
##  (empty in first row - the loading step).<P/>
##  Also note that in the two examples above, <C>RunFSR</C> will call
##  <Ref Meth="LoadFSR" /> first, which adds the elm seq<M>{{_0}}</M> to the sequence,
##  so both sequences above are of length <A>num+1</A>/<A>Length(elmvec)+1</A>,
##   i.e.,6. <P/>
##  The last row in both examples is the actual sequence obtained from
##  this run, and is kept in Zechs logarithm representation. To represent the
##  elements in the first 6 rows, the basis printed out at the beginning is
##   used; it can be changed by using <C>ChangeBasis</C> call and
##  repeating <C>RunFSR</C>.<P/>
##  When FILFUNs are created, their current state is set to all zero. Calling
##  <C>RunFSR(fsr [, ist, num, pr])</C> or
##  <C>RunFSR(<A> fsr,  z, elmvec [, pr] </A>)</C> will work, even without
##  <A>ist</A>, however, it will just repeat the same computation <A>num</A> times.
##  For this reason, separate
##  <C>RunFSR</C> are implemented for FILFUNs only: they use a sequence of
##  <Ref Meth="LoadStepFSR" /> calls rather than a
##  single <Ref Meth="LoadFSR" />, followed by a sequence of
##  <Ref Meth="StepFSR" /> calls. The example below for a FILFUN <C>filfun</C>
##  over <M>\mathbb{F}_{2^4}</M>,
##  with two initial states <A>istvec</A>  will perform two calls of
##  <Ref Meth="LoadStepFSR" />. First call is without and second with an external
##  element taken from <A>elmvec</A>, also of length 2.
##  <Example>
##  <![CDATA[

##  gap> F := GF(2^4);; f := x_0*x_1+x_2;; filfun := FILFUN(F, f);;
##  gap> istvec := [[Z(2)^0, Z(2)^0,Z(2)^0], [0*Z(2), Z(2^4)^3, Z(2^4)] ];;
##  gap> seq:=  RunFSR(filfun, istvec );
##  [ 0*Z(2), Z(2^4) ]
##  gap> elmvec := [Z(2^4)^5, Z(2^4)];;
##  gap> seq:=  RunFSR(filfun, istvec, elmvec );
##  [ Z(2^2), 0*Z(2) ]
##  ]]>
##  </Example>
##
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



# although IsBool is only used with true when IsBasis is set (doesnt make sense
##   to have basis if we dont print steps)
# it is left to add an argument so method selection doesnt get confused
# problem with method selection: a basis will also have IsRingElementCollection = true
# so basis might get mistaken for initial state
# by having an extra parameter IsBool the number of arguments is different and
# this problem is avoided



########## problem with method selection IsPosInt will always be IsRingElement as well
# IIIb = I
# IIIc.= Ia.
# solution: remove III -> can always use StepFSR instead or make elmvec with equal entries
# also: if we really want same external all the time we can just change the const term of the poly
# removed VII for consistency



# IsPosInt when i want to specify #steps performed
# IsBool for the printswitch

# I. just run , assuming allready loaded
DeclareOperation("RunFSR", [IsFSR, IsPosInt, IsBool]);  	# I.
DeclareOperation("RunFSR", [IsFSR, IsPosInt]);				# Ia.
DeclareOperation("RunFSR", [IsFSR, IsBool]);				# Ib.
DeclareOperation("RunFSR", [IsFSR ]);							# Ic.


# II. load + run
DeclareOperation("RunFSR", [IsFSR, IsRingElementCollection, IsPosInt, IsBool]);	# II.
DeclareOperation("RunFSR", [IsFSR, IsRingElementCollection, IsPosInt]);			# IIa.
DeclareOperation("RunFSR", [IsFSR, IsRingElementCollection, IsBool]);				# IIb.
DeclareOperation("RunFSR", [IsFSR, IsRingElementCollection]);							# IIc.

## external versions
# III. run for num steps with the same external input on each step
#DeclareOperation("RunFSR", [IsFSR, IsRingElement, IsPosInt, IsBool]);				# III.
#DeclareOperation("RunFSR", [IsFSR, IsRingElement, IsPosInt]);							# IIIa.
#DeclareOperation("RunFSR", [IsFSR, IsRingElement, IsBool]);							# IIIb.
#DeclareOperation("RunFSR", [IsFSR, IsRingElement]);										# IIIc.

# IV. load and run for num steps with a different external input on each step
DeclareOperation("RunFSR", [IsFSR, IsRingElementCollection, IsRingElementCollection, IsBool]); # IV.
DeclareOperation("RunFSR", [IsFSR, IsRingElementCollection, IsRingElementCollection]);			 # Iva.


# V. continue a run with a different external input on each step
DeclareOperation("RunFSR", [IsFSR, IsZero, IsRingElementCollection, IsBool]);	# V.
DeclareOperation("RunFSR", [IsFSR, IsZero, IsRingElementCollection]);				# Va.

# run for FILFUN

# VI. run for FILFUN, using LoadStepFSR calls
DeclareOperation("RunFSR", [IsFILFUN, IsRingElementCollColl, IsBool]);		# VI.
DeclareOperation("RunFSR", [IsFILFUN, IsRingElementCollColl]);				# VIa.

# VII. run with the same external input on each step
#DeclareOperation("RunFSR", [IsFILFUN, IsRingElementCollColl, IsRingElement, IsBool]); 	# VII.
#DeclareOperation("RunFSR", [IsFILFUN, IsRingElementCollColl, IsRingElement]);				# VIIa.

# VIII. run with a different external input on each step
DeclareOperation("RunFSR", [IsFILFUN, IsRingElementCollColl, IsRingElementCollection, IsBool]);	# VIII.
DeclareOperation("RunFSR", [IsFILFUN, IsRingElementCollColl, IsRingElementCollection]);										# VIIIa.




Print("fsr.gd OK,\t");
