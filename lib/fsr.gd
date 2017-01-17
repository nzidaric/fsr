#############################################################################
##
#W  fsr.gd                   GAP Library                   nusa zidaric
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

Print("fsr.gd OK,\t");