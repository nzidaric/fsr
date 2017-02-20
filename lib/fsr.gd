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
##  while specialized functions (such as <C>LFSR</C> and <C>NLFSR</C> object creation) in corresponding sections.
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

#############################################################################
##
#F  ChooseField( <F> )
##
##  choose the underlying finite field for the NLFSR
##
##
##  <#GAPDoc Label="ChooseField">
##  <ManSection>
##  <Func Arg="F" Name="ChooseField"  />
##  <Description>
##  Workaround for the <C>NLFSR</C> object definition: we need to fix the chosen underlying finite field 
##  and prepare indeterminates in the chosen field. 
##  The indeterminates will be used for the multivariable polynomial, which will define the <C>NLFSR</C> feedback.
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
##  <Attr Name="FieldPoly" Arg='fsr' />
##  <Attr Name="UnderlyingField" Arg='fsr'/>
##  <Attr Name="FeedbackVec" Arg='fsr'/>
##  <Attr Name="OutputTap" Arg='fsr' />
##  <Description>
##  <C>FieldPoly</C> of the <A>fsr</A> stores the irreducible polynomial used to construct the extension field or 1 in case of a prime field.<P/>
##  <C>UnderlyingField</C> of the <A>fsr</A> is the finite field over which the <A>fsr</A> is defined (all indeterminates and constants are from this field). <P/>
##  NOTE: it may seem redundant to sore both <C>FieldPoly</C> and <C>UnderlyingField</C>, however, they are used by other functions in the package. <P/>
##  <C>FeedbackVec</C> of the <A>fsr</A> stores the coefficients of the <C>CharPoly</C> without its leading term in case of <C>LFSR</C>, 
##  and coefficients of the nonzero monomials present in the multivariate function defining the feedback in case of <C>NLFSR</C>.<P/>
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
##  <Attr Name="Length" Arg='fsr' />
##  <Attr Name="InternalStateSize" Arg='fsr'/>
##
##  <Description>
##  <C>Length</C> of the <A>fsr</A> is the number of its stages.<P/>
##  <C>InternalStateSize</C> of the <A>fsr</A> is size in bits needed to store the state <M>length \cdot width</M>, where <M> width = DegreeOverPrimeField(UnderlyingField(<A>fsr</A>))</M>
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
##  <Meth Name="LoadFSR" Arg='fsr, ist' />
##
##  <Description>
##  Loading the <A>fsr</A> with the initial state <A>ist</A>, which is a <A>FFE</A> vector
##  of same length as <A>fsr</A> and with elements from its underlying finite field. If either of those two
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
##  <Meth Name="StepFSR" Arg='fsr[, elm]' />
##
##  <Description>
##  Perform one step the <A>fsr</A>, ie. compute the new <C>state</C> and update the <C>numsteps</C>, then output the
##  elements denoted by <C>OutputTap</C>. If the optional parameter <A>elm</A> is used then the new element is computed as 
##  a sum of computed feedback and <A>elm</A>. Elemen <A>elm</A> must be an element of the underlying finite field. <P/>
##  As this is a way to destroy the linearity of an <C>LFSR</C>, 
##  we refer to <C>StepFSR</C> with the optiomal nonzero <A>elm</A> as <C>nonlinear step</C>. Similarly, the <C>NLFSR</C> can also have 
##  an extra element added to the (already nonlinear) feedback.<P/>
##  Returns an error if the <A>fsr</A> is not loaded!<P/>
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
##  <Meth Name="RunFSR" Arg='fsr [, B, ist, num, pr]'/>
##  <Returns>
##  A sequence of elements generated by <C>FSR</C>.
##  </Returns>	
##  <Description>
##  The <A>fsr</A> will be run for a certain (<A>num</A> or <A>threshold</A>) number of steps: there is a threshold value, currently set to  2^<E>Length(<A>fsr</A>)</E> + <E>Length(<A>fsr</A>)</E>, 
##  which is used by all versions without explicit <A>num</A> and enforced when <A>num</A> exceeds <A>threshold</A>. There is an optional printing switch <A>pr</A>,
##  with default set to <E>false</E>; if <E>true</E> then the state and the output sequence element(s) are printed in &GAP; shell on every step of the <A>fsr</A> (we call this output for <C>RunFSR</C>), and 
##  the given basis <A>B</A> is used for representation of elements. Note that having both a pint switch and a basis is redundant, however, the additional boolean helps the method selection to distinguish between 
##  calls with basis and calls with both initial state <A>ist</A> and the cvector of FFE elements <A>elmvec</A> to be used for nonlinear steps (because all three vectors return true for IsFFECollection). 
##  <List>
##  <Item> <C>RunFSR(<A> fsr[, B, num, pr] </A>)</C> - run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps with/without output</Item>
##  <Item> <C>RunFSR(<A> fsr, [B,] ist[, num, pr] </A>)</C> - load <A>fsr</A> with <A>ist</A>, then run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps with/without output (ie. <E>linear</E> version)</Item>
##  <Item> <C>RunFSR(<A> fsr, [B,] elm[, num, pr] </A>)</C> - run <A>fsr</A> for <A>num</A>/<A>threshold</A> steps, whereby the SAME element 
##  <A>elm</A> is added to the feedback at each step, with/without output (ie. <E>non-linear</E> version)</Item>
##  <Item> <C>RunFSR(<A> fsr, [B,] ist, elmvec[, pr] </A>)</C> - load <A>fsr</A> with <A>ist</A>, then run <A>fsr</A> for <E>Length(<A>elmvec</A>)</E> steps, whereby one element
##  of <A>elmvec</A> is added to the feedback at each step (starting with <A>elmvec[1]</A>), with/without output (ie. <E>non-linear</E> version). NOTE: the sequence returned has length <E>Length(elmvec)+1</E>,
##  because the zeroth sequence element is returned at the time of loading the <C>FSR</C>.</Item>
##  </List>
##  For the load and run versions, element seq<M>_0</M> is a part of the output sequence, hence the output sequence has the length <A>num+1</A>/<A>threshold+1</A>/<A>Length(elmvec)+1</A>. <P/>
##  For versions without the loading of <A>ist</A>, calling <C>RunFSR</C> returns an error if the <A>fsr</A> is not loaded!<P/> 
##  The ouput of <C>RunFSR</C> is: 
##  <List> 
##  <Item> sequence of <A>FFE</A>s : seq<M>_0</M>, seq<M>_1</M>, seq<M>_2</M>, <M>\dots ,</M>  for <E>Length</E>(<E>OutputTap</E>)=1</Item>
##  <Item> sequence of vectors, each of them with <M>t</M> <A>FFE</A>s : seq<M>_0</M>, seq<M>_1</M>, seq<M>_2</M>, <M>\dots ,</M>  where seq<M>_i=(</M> seq<M>_{i1}</M>, <M>\dots ,</M> seq<M>_{it}</M>) for <E>Length</E>(<E>OutputTap</E>)=t</Item>
##  </List>
##  Example of <C>RunFSR</C> called for an lfsr <E>test</E> over <M>F_{2^4}</M>, with initial state <E>ist</E>, print switch <E>true</E> for basis  <E>B</E>, with run length 5:
##  <Example>
##  <![CDATA[
##  gap> K := GF(2);; x := X(K, "x");;
##  gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
##  gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
##  gap> test := LFSR(K, f, l);;
##  < empty LFSR given by CharPoly = y^4+y+Z(2^4)>
##  gap> ist :=[0*Z(2), Z(2^4), Z(2^4)^5, Z(2)^0 ];;
##  gap> RunFSR(test, B, ist, 5, true);             
##  using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]	
##  elm 		[ 3,......,0 ]  with taps  [ 0 ]
##  		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
##  		[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
##  		[ [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
##  		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
##  		[ [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
##  		[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
##  [ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
##  ]]>
##  </Example> 
##  Example of <C>RunFSR</C> called for an lfsr <E>test</E> over <M>F_{2^4}</M>, with initial state <E>ist</E>, print switch <E>true</E> for basis  <E>B</E>, with 5 nonlinear inputs :
##  <Example>
##  <![CDATA[
##  gap> elmvec := [Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6];;                                
##  gap> RunFSR(test, B, ist, elmvec, true);                         
##  elm 		[ 3,......,0 ]  with taps  [ 0 ]
##   		[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
##  [ 1, 0, 1, 1 ]		[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
##  [ 1, 0, 1, 1 ]		[ [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
##  [ 1, 1, 0, 1 ]		[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
##  [ 0, 1, 0, 0 ]		[ [ 1, 1, 1, 1 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
##  [ 0, 0, 0, 1 ]		[ [ 0, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
##  [ Z(2^4)^2, 0*Z(2), 0*Z(2), 0*Z(2), Z(2^4)^2, Z(2^4)^2 ]
##  ]]>
##  </Example> 
##  In both examples above the there is a column <E>elm</E>, which is in first case empty, because we are not adding nonlinear inputs to the feedback, while in the second example,
##  this column shows the element being added at each step (empty in first row - the loading step). Also note that the two examples above use the call <C>LoadFSR</C>, which adds the elm  seq<M>{{_0}}</M> to the sequaence, 
##  so both sequences above are of length  <A>num+1</A>/<A>Length(elmvec)+1</A>, ie 6. The last row in both examples is the actual sequence obtained from this run, and is kept in Zechs logarithm representation. 
##  <Example>
##  <![CDATA[
##  gap> RunFSR(test,  ist); Length(last);
##  [ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11, Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, 
##    Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2)^2, Z(2^4)^2, Z(2^4), Z(2^4)^2, Z(2^4)^9 ]
##  21
##  ]]>
##  </Example> 
##  Last example above shows a sequence of length 21, ie <A>threshold+1</A>, getting first sequence element from LoadFSR followed by <A>threshold</A> iterations of StepFSR. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##



# although IsBool is only used with true when IsBasis is set (doesnt make sense to have basis if we dont print steps)
# it is left too add an argument so method selection doesnt get confused
# problem with method selection: a basis will also have IsFFECollection = true
# so basis might get mistaken for initial state 
# by having an extra parameter IsBool the number of arguments is different and this problem is avoided 


DeclareOperation("RunFSR", [IsFSR, IsBasis, IsPosInt, IsBool]);	 #Ib.   run for num steps with/without print to shell
#DeclareOperation("RunFSR", [IsFSR, IsPosInt, IsBool]);	 #I.  didnt make sense => removed 

# DeclareOperation("RunFSR", [IsFSR, IsBasis, IsPosInt]);				 #IIb.   didnt make sense => removed 
DeclareOperation("RunFSR", [IsFSR, IsPosInt]); 							 #II.  run for num steps without print to shell

DeclareOperation("RunFSR", [IsFSR, IsBasis, IsBool]);					 #IIIb. run with/without print to shell
#DeclareOperation("RunFSR", [IsFSR, IsBool]);								 #III.   didnt make sense => removed 

#DeclareOperation("RunFSR", [IsFSR, IsBasis ]);							 #IVb.    didnt make sense => removed 
DeclareOperation("RunFSR", [IsFSR ]);										 #IV.  run without print to shell

DeclareOperation("RunFSR", [IsFSR, IsBasis, IsFFECollection, IsPosInt, IsBool]);		 #Vb. load new initial state then run for num-1 steps with/without print to shell
#DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsPosInt, IsBool]);					 #V.   didnt make sense => removed 

#DeclareOperation("RunFSR", [IsFSR, IsBasis, IsFFECollection, IsPosInt]);         	 #VIb.    didnt make sense => removed 
DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsPosInt]);      				    #VI.  load new initial state then run for num-1 steps without print to shell

DeclareOperation("RunFSR", [IsFSR, IsBasis,  IsFFECollection, IsBool]);                   	 #VIIb. load new initial state then run without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection]);               					    #VII. load new initial state then run without print to shell

## nonlinear versions 
DeclareOperation("RunFSR", [IsFSR, IsBasis, IsFFE, IsPosInt, IsBool]);		  	#VIIIb. run for num steps with the same nonlinear input on each step and with/without print to shell
#DeclareOperation("RunFSR", [IsFSR, IsFFE, IsPosInt, IsBool]);		  				#VIII.   didnt make sense => removed 

#DeclareOperation("RunFSR", [IsFSR, IsBasis, IsFFE, IsPosInt]);		  				#IXb.   didnt make sense => removed 
DeclareOperation("RunFSR", [IsFSR, IsFFE, IsPosInt]);		 							#IX. run for num steps with the same nonlinear input on each step without print to shell

DeclareOperation("RunFSR", [IsFSR, IsBasis, IsFFE, IsBool]);				  						#Xb.   run with the same nonlinear input on each step without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFE]);				  									#X.   run with the same nonlinear input on each step without print to shell

DeclareOperation("RunFSR", [IsFSR, IsBasis, IsFFECollection, IsFFECollection, IsBool]);	# XIb. run for num steps with the different nonlinear input on each step with/without print to shell
DeclareOperation("RunFSR", [IsFSR, IsFFECollection, IsFFECollection]);				# XI. run for num steps with the different nonlinear input on each step with/without print to shell

Print("fsr.gd OK,\t");