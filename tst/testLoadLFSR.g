#testing the loading of the LFSR


#############################################################################
#F  LFSR( <K>, <charpol> )  . . . . . . . . . .  create an LFSR object 	# len 2
Print("#F  LFSR( <K>, <charpol> )\n");
K := GF(2); 
y := X(K, "y");
l := y^3 + y + 1;
t1 :=  LFSR(K, l);
Print(t1);
ist0 :=[Z(2)^0, 0*Z(2), Z(2)^0 ];
LoadLFSR(t1,ist0);
PrintAll(t1);

ist1 :=[0*Z(2), 0*Z(2), Z(2)^0 ];
LoadLFSR(t1,ist1);
PrintAll(t1);

ist2 :=[Z(2)^0, Z(2)^0, Z(2)^0 ];
LoadLFSR(t1,ist2);
PrintAll(t1);

ist3 :=[Z(2)^0, 0*Z(2), Z(2)^0 ];
t1!.init := ist3;
PrintAll(t1);
# try to find a way for this third case to not be possible: ie to be only able to change the 
# lfsr!.init component with LoadLFSR call, coz i need it to also change the numsteps for that 
# note: cant make init an Attribute coz then i CANT change it again 
Print("All tests passed!!!");