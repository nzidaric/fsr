#############################################################################
##
#W  fsr.gd                   GAP Package                   nusa zidaric
##
##


#############################################################################
##
#C  IsFSR( <obj> )
##
DeclareCategory( "IsFSR",  IsObject ); 
 

#############################################################################
##
#F  FSRFamily( <p> )
##
##  is the family of finite field elements in characteristic <p>.
##
DeclareGlobalFunction( "FSRFamily" );



#############################################################################
##
#F  ChooseField( <F> )
##
##  choose the underlying finite field for the NLFSR
##
DeclareGlobalFunction( "ChooseField" );


DeclareAttribute( "FeedbackVec", IsFSR ); 
# should be IsLFSR , the equivalent for IsNLFSR will be CoeffVec ... maybe can have the same name coz theyre both coefficients  
DeclareAttribute( "FieldPoly", IsFSR );
DeclareAttribute( "UnderlyingField", IsFSR );
DeclareAttribute( "OutputTap", IsFSR );

#############################################################################
##
#A  Length( <fsr> )
#A  InternalStateSize( <fsr> )
##
##  <#GAPDoc Label="Length">
##  <ManSection>
##  <Attr Name="Length" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "Length", IsFSR );
DeclareAttribute( "InternalStateSize", IsFSR );



#############################################################################
##
#O  LoadFSR( <fsr>, <ist> )
##
##  <#GAPDoc Label="LoadFSR">
##  <ManSection>
##  <Attr Name="LoadFSR" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation("LoadFSR", [IsFSR,  IsFFECollection]);
#DeclareProperty("IsEmpty", IsFSR); DONT coz once set cant change again

#############################################################################
##
#O  StepFSR( <fsr>)
#O  StepFSR( <fsr>, <elm>)
##
##  <#GAPDoc Label="StepFSR">
##  <ManSection>
##  <Attr Name="StepFSR" Arg='fsr' Label="for an FSR"/>
##
##  <Description>
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
##  <Attr Name="RunFSR" Arg='fsr' Label="for an FSR"/>
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