#############################################################################
##
#W    read.g                  The FSR package
#W
##

#############################################################################
##
#R  Read the install files.
##
ReadPackage( "FSR", "lib/misc.gi" ); #misc

ReadPackage( "FSR", "lib/outputs.gi" ); # the output formatting functions

ReadPackage( "FSR", "lib/fsr.gi" ); # the top-level functions

ReadPackage( "FSR", "lib/lfsr.gi" ); # the top-level functions

ReadPackage( "FSR", "lib/nlfsr.gi" ); # the top-level functions

ReadPackage( "FSR", "lib/filfun.gi" ); # the top-level functions

ReadPackage( "FSR", "lib/outfsr.gi" ); # the output formatting functions

ReadPackage( "FSR", "lib/drawlfsr.gi" ); # NLFSR drawing functions - outputs a *.tex file

ReadPackage( "FSR", "lib/drawnlfsr.gi" ); # NLFSR drawing functions - outputs a *.tex file

Print("read.g done!!!\n");

ChooseField(GF(2^16));


#E  read.g . . . . . . . . . . . . . . . . . . . . . . . . . . . .  ends here
