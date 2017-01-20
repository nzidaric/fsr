#############################################################################
##
#W    init.g                      The FSR package              
#W                                                                
##


#############################################################################
##
#R  Read the declaration files.
##
##
ReadPackage( "FSR", "lib/misc.gd" ); #misc

ReadPackage( "FSR", "lib/outputs.gd" ); # the output formatting functions

ReadPackage( "FSR", "lib/fsr.gd" ); # the top-level functions

ReadPackage( "FSR", "lib/lfsr.gd" ); # the top-level functions

ReadPackage( "FSR", "lib/nlfsr.gd" ); # the top-level functions

#ReadPackage( "FSR", "lib/outlfsr.gd" ); # the output formatting functions - LFSR specific

#ReadPackage( "FSR", "lib/drawlfsr.gd" ); # LFSR drawing functions - outputs a *.tex file

Print("init.g done!!!\n");
#E  init.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here

