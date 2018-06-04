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

ReadPackage( "FSR", "lib/filfun.gd" ); # the top-level functions

ReadPackage( "FSR", "lib/outfsr.gd" ); # the output formatting functions

ReadPackage( "FSR", "lib/drawlfsr.gd" ); # NLFSR drawing functions - outputs a *.tex file

ReadPackage( "FSR", "lib/drawnlfsr.gd" ); # NLFSR drawing functions - outputs a *.tex file

Print("init.g done!!!\n");
#E  init.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
