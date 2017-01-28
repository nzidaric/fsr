#############################################################################
##
#W  fsr.gd                   GAP Package                   nusa zidaric
##
##


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
##  using functions <Ref Func="LFSR" /> or <Ref Func="LFSR" />.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
DeclareCategory( "IsFSR",  IsObject ); 
 

#############################################################################
##
#F  FSRFamily( <p> )
##
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
##  <Func Name="ChooseField" />
##  <Description>
##  Choose the underlying finite field and prepare indeterminated in the chosen field. 
##  The indeterminates will be used for the multivariable polynomial, which will define the NLFSR feedback.
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
##  <C>FieldPoly</C> of the FSR stores the irreducible polynomial used to construct the extension field or 1 in case of a prime field.<P/>
##  <C>UnderlyingField</C> of the FSR is the finite field over which the FSR is defined (all indeterminates and constants are from this field). 
##  <C>FeedbackVec</C> of the FSR stores the coefficients of the <C>CharPoly</C> without its leading term in case of LFSR, 
##  and coefficients of the nonzero monomials present in the multivariate function defining the feedback in case of NLFSR .<P/>
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
##  <C>Length</C> of the FSR is the number of its stages.<P/>
##  <C>InternalStateSize</C> of the FSR is size in bits needed to store the state (length * width) 
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
##  Loading the FSR <A>fsr</A> with the initial state <A>ist</A>, which is a FFE vector
##  of same length as the FSR and with elements from the underlying finite field. If either of those two
##  requirements is violated, loading fails and error message appears. At the time of loading 
##  the initial sequence elements (ie zeroth elements) are obtained and <C>numsteps</C> is set to 0.
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
##  <Meth Name="StepFSR" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
##  Perform one step the FSR <A>fsr</A>, ie. compute the new <C>state</C> and update the <C>numsteps</C>, then output the
##  elements denoted by <C>OutputTap</C>. If the optional parameter <A>elm</A> is used then the new element is computed as 
##  a sum of computed feedback and <A>elm</A>. Elemen <A>elm</A> must be an element of the underlying finite field. <P/>
##  An error is triggered if <C>StepFSR</C> is called for an empty FSR. As this is a way to destroy the linearity of an LFSR, 
##  we refer to StepFSR with the optiomal nonzero <A>elm</A> as <C>nonlinear step</C><P/>.
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
##  <Meth Name="RunFSR" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
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
DeclareOperation("RunFSR", [IsFSR, IsFFE]);				  #IX.   run with the same nonlinear input on each step without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsFFECollection, IsBool]);# X. run for num steps with the different nonlinear input on each step with/without print to shell


Print("fsr.gd OK,\t");