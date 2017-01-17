#############################################################################
##
#W  fsr.gi                   GAP Library                   nusa zidaric
##
##



#############################################################################
##
#F  FSRFamily( <p> ) 
##  copied from FFEFamily
##
InstallGlobalFunction( FSRFamily, function( p )
    local fam;
    if MAXSIZE_GF_INTERNAL < p then
       fam:= NewFamily( "FSRFamily", IsFSR );
       SetCharacteristic( fam, p );
    else
      # small characteristic
      fam:= FamilyType( TYPE_FFE( p ) );
    fi;
 #   fam!.FSRType:= NewType( fam, IsFSR );
    return fam;
end );

Print("fsr.gi OK,\t");