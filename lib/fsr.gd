#############################################################################
##
#W  fsr.gd                   GAP Package                   nusa zidaric
##
##
                
###############################################################################
##
##  <#GAPDoc Label="fsr">
##  <Index>fsr</Index>
##  We define an object &FSR; (Feedback Shift Register), which can come in two flavours: 
##  with linear feedback <Ref Func="LFSR" /> and nonlinear feedback  <Ref Func="NLFSR" />. Because of many 
##  similarities between the two, the basic common functionality can be found here, 
##  while specialized functions (such as &LFSR; and &NLFSR; object creation) in corresponding sections.
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
##  This is the category of &FSR; objects.
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
##  This is the family of FSRs with characteristic <P/>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#
DeclareGlobalFunction( "FSRFamily" );

#############################################################################
##
#F  ChooseField( <F> )
##
##  choose the underlying finite field for the NLFSR
##
##
##  <#GAPDoc Label="ChooseField">
##  <ManSection>
##  <Func Arg="F" Name="ChooseField" Label="for a given field" />
##  <Description>
##  Workaround for the &NLFSR; object definition: we need to fix the chosen underlying finite field 
##  and prepare indeterminates in the chosen field. 
##  The indeterminates will be used for the multivariable polynomial, which will define the &NLFSR; feedback.
##  Current threshold is set by global <C>MaxNLFSRLen</C> = 100. <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
#
DeclareGlobalFunction( "ChooseField" );


#############################################################################
##
#A  FieldPoly( <fsr> )
#A  UnderlyingField( <fsr> )
#A  FeedbackVec( <fsr> )
#A  OutputTap( <fsr> )
##
##  <#GAPDoc Label="FieldPoly">
##  <ManSection>
##  <Attr Name="FieldPoly" Arg='fsr' Label="for an FSR"/>
##  <Attr Name="UnderlyingField" Arg='fsr' Label="for an FSR"/>
##  <Attr Name="FeedbackVec" Arg='fsr' Label="for an FSR"/>
##  <Attr Name="OutputTap" Arg='fsr' Label="for an FSR"/>
##  <Description>
##  <C>FieldPoly</C> of the &FSR; stores the irreducible polynomial used to construct the extension field or 1 in case of a prime field.<P/>
##  <C>UnderlyingField</C> of the &FSR; is the finite field over which the &FSR; is defined (all indeterminates and constants are from this field). <P/>
##  <C>FeedbackVec</C> of the &FSR; stores the coefficients of the <C>CharPoly</C> without its leading term in case of &LFSR;, 
##  and coefficients of the nonzero monomials present in the multivariate function defining the feedback in case of &NLFSR;.<P/>
##  <C>OutputTap</C> holds the output tap position(s): the sequence elements are taken from the stage(s) listed in <C>OutputTap</C>.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>

DeclareAttribute( "FieldPoly", IsFSR );
DeclareAttribute( "UnderlyingField", IsFSR );
DeclareAttribute( "FeedbackVec", IsFSR ); 
# should be IsLFSR , the equivalent for IsNLFSR will be CoeffVec ...
# maybe can have the same name coz theyre both coefficients  and belong to the feedback
# maybe rename to FeedbackCoeffs
DeclareAttribute( "OutputTap", IsFSR );

#############################################################################
##
#A  Length( <fsr> )
#A  InternalStateSize( <fsr> )
##
##  <#GAPDoc Label="Length">
##  <ManSection>
##  <Attr Name="Length" Arg='fsr' Label="for an FSR"/>
##  <Attr Name="InternalStateSize" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
##  <C>Length</C> of the &FSR; is the number of its stages.<P/>
##  <C>InternalStateSize</C> of the &FSR; is size in bits needed to store the state (length * width) 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Length", IsFSR );
DeclareAttribute( "InternalStateSize", IsFSR );

#############################################################################
##
#M  LoadFSR( <fsr>, <ist> )
##
##  <#GAPDoc Label="LoadFSR">
##  <ManSection>
##  <Meth Name="LoadFSR" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
##  Loading the &FSR; <A>fsr</A> with the initial state <A>ist</A>, which is a &FFE; vector
##  of same length as the &FSR; and with elements from the underlying finite field. If either of those two
##  requirements is violated, loading fails and error message appears. At the time of loading 
##  the initial sequence elements (ie zeroth elements) are obtained and <C>numsteps</C> is set to 0.<P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("LoadFSR", [IsFSR,  IsFFECollection]);
#DeclareProperty("IsEmpty", IsFSR); DONT coz once set cant change again


# TO DO : from initial state and number of steps , knowing the feedback polynomial, we can check if current state is
# VALID (if we can get it from initial state in num of steps), and if not valid then reset the LFSR
# is it the same for both ????

#############################################################################
##
#M  StepFSR( <fsr>)
#M  StepFSR( <fsr>, <elm>)
##
##  <#GAPDoc Label="StepFSR">
##  <ManSection>
##  <Meth Name="StepFSR" Arg='fsr[, elm]' Label="for an FSR"/>
##
##  <Description>
##  Perform one step the &FSR; <A>fsr</A>, ie. compute the new <C>state</C> and update the <C>numsteps</C>, then output the
##  elements denoted by <C>OutputTap</C>. If the optional parameter <A>elm</A> is used then the new element is computed as 
##  a sum of computed feedback and <A>elm</A>. Elemen <A>elm</A> must be an element of the underlying finite field. <P/>
##  An error is triggered if <C>StepFSR</C> is called for an empty &FSR;. As this is a way to destroy the linearity of an &LFSR;, 
##  we refer to <C>StepFSR</C> with the optiomal nonzero <A>elm</A> as <C>nonlinear step</C>. Similarly, the &NLFSR; can also have 
##  an extra element added to the (already nonlinear) feedback.<P/>
##  Returns an error if the &FSR; is not loaded!<P/>
##  NOTE: TO DO for the NLFSR !!!!!!
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("StepFSR", [IsFSR]);
DeclareOperation("StepFSR", [IsFSR, IsFFE]);


#############################################################################
##
#O  RunFSR( <FSR> , <num>, <pr> ) ......... I.   run for num steps with/without print to shell
#O  RunFSR( <FSR> , <num> ) ............... II.  run for num steps without print to shell
#O  RunFSR( <FSR> , <pr> ) ................ III. run with/without print to shell
#O  RunFSR( <FSR> ) ....................... IV.  run without print to shell
#O  RunFSR( <FSR> , <ist>, <num>, <pr>) ... V.   load new initial state then run for num-1 steps with/without print to shell
#O  RunFSR( <FSR> , <ist>, <num>) ......... VI.  load new initial state then run for num-1 steps without print to shell
#O  RunFSR( <FSR> , <ist>) ................ VII. load new initial state then run without print to shell
## nonlinear versions 
#O  RunFSR(<FSR>, <elm>, <num>, <pr>) ...... VIII. run for num steps with the same nonlinear input on each step and with/without print to shell
#O  RunFSR(<FSR>, <elm>, <num>) ............ IX.   run for num steps with the same nonlinear input on each step without print to shell
#O  RunFSR(<FSR>, <ist>, <elmvec>, <pr> ) .. X.    run for num steps with the different nonlinear input on each step with/without print to shell
##
##  <#GAPDoc Label="RunFSR">
##  <ManSection>
##  <Meth Name="RunFSR" Arg='fsr [, ist] [, num] [, pr]' Label="for an FSR"/>
##
##  <Description>
##  The &FSR will be run for a certain (<A>num</A> or <A>threshold</A>) number of steps: there is a threshold value, currently set to  2^<E>Length(<A>fsr</A>)</E> + <E>Length(<A>fsr</A>)</E>, 
##  which is used by all versions without explicit <A>num</A> and enforced when <A>num</A> exceeds <A>threshold</A>. There is an optional printing switch <A>pr</A>,
##  with default set to <E>false</E>; if <E>true</E> then the state and the output sequence element(s) are printed in &GAP; shell on every step of the &FSR; (we call this output for <C>RunFSR</C>).
##  <List>
##  <Item> <C>RunLFSR(<A> fsr[, num, pr] </A>)</C> - run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps with/without output</Item>
##  <Item> <C>RunLFSR(<A> fsr, ist[, num, pr] </A>)</C> - load <A>fsr</A> with <A>ist</A>, then run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps with/without output (ie. <E>linear</E> version)</Item>
##  <Item> <C>RunLFSR(<A> fsr, elm[, num, pr] </A>)</C> - load <A>fsr</A> with <A>ist</A>, then run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps, whereby the SAME element 
##  <A>elm</A> is added to the feedback at each step, with/without output (ie. <E>non-linear</E> version)</Item>
##  <Item> <C>RunLFSR(<A> fsr, ist, elmvec[, num, pr] </A>)</C> - load <A>fsr</A> with <A>ist</A>, then run <A>fsr</A> for  <E>Length(<A>fsr</A>)</E> steps,, whereby one element
##  of <A>elmvec</A> is added to the feedback at each step (starting with elmvec[1]), with/without output (ie. <E>non-linear</E> version)</Item>
##  </List>
##  NOTE: for the load and run versions, element <A>seq$_0$</A> is a part of the output sequence
##  The ouput of <C>RunLFSR</C> is: 
##  <List> 
##  <Item> sequence of &FFE;s : seq$_0$, seq$_1$, seq$_2$, \dots for <E>Length</E>(<E>OutputTap</E>)=1</Item>
##  <Item> sequence of vectors, each of them with $t$ FFEs : seq$_0$, seq$_1$, seq$_2$, \dots, where seq$_i=($ seq$_{i1}$, \dots ,$ seq$_{it}$) for <E>Length</E>(<E>OutputTap</E>)=t</Item>
##  </List>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##






DeclareOperation("RunFSR", [IsFSR, IsPosInt, IsBool]); #I.   run for num steps with/without print to shell
DeclareOperation("RunFSR", [IsFSR, IsPosInt]);	 #II.  run for num steps without print to shell
DeclareOperation("RunFSR", [IsFSR, IsBool]);		 #III. run with/without print to shell
DeclareOperation("RunFSR", [IsFSR]);			 #IV.  run without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsPosInt, IsBool]); #V. load new initial state then run for num-1 steps with/without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsPosInt]);         #VI.  load new initial state then run for num-1 steps without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection]);                   #VII. load new initial state then run without print to shell

## nonlinear versions 
DeclareOperation("RunFSR", [IsFSR, IsFFE, IsPosInt, IsBool]);		  #VIII. run for num steps with the same nonlinear input on each step and with/without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFE, IsPosInt]);		  #IX. run for num steps with the same nonlinear input on each step without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFE]);				  #X.   run with the same nonlinear input on each step without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsFFECollection, IsBool]);# XI. run for num steps with the different nonlinear input on each step with/without print to shell


Print("fsr.gd OK,\t");