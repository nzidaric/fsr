#############################################################################
##
#W  misc.gi                   GAP Library                   nusa zidaric
##
##

#############################################################################
##
#M  TrimLeadCoeff(<coefs>) 			Trim the leading coefficient
##
##

InstallMethod( TrimLeadCoeff, "Trim the leading coefficient off the list",  [IsFFECollection and IsRowVector], function(coefs)

local trimmed, i;

trimmed := [];
for i in [1..Length(coefs)-1] do
	trimmed[i] := coefs[i];
od;

return trimmed;
end);


InstallMethod( IdxNonzeroCoeffs, "Indeces of nonzero coefficients off the list",  [IsFFECollection and IsRowVector], function(coefs)
# doesnt work coz coefs not mutable !!!!
local t, tlist,len , c;

len := Length(coefs)+1;
tlist := [];
t := PositionNonZero(coefs);
if (t < len) then 
	Add(tlist,t); 
	coefs[t] := 0*Z(2); # doesnt work coz coefs not mutable !!!!
fi;

while (t < len) do 
	t := PositionNonZero(coefs);
	if (t < len) then 
		Add(tlist,t); 
		coefs[t] := 0*Z(2);
	fi;
od; 



return tlist;
end);

InstallMethod( IdxNonzeroCoeffs2, "Indeces of nonzero coefficients off the list",  [IsFFECollection and IsRowVector], function(coefs)

local t, tlist, len, i;
len := Length(coefs);
tlist := [];


for i in [1.. len] do 
	if not (coefs[i] = 0*Z(2)) then 
		Add(tlist,i); 
	fi;
od; 

return tlist;
end);

InstallMethod( NrNonzeroCoeffs, "Number of nonzero indeces",  [IsFFECollection and IsRowVector], function(coefs)
local tlist;

	tlist := IdxNonzeroCoeffs(coefs);

return Length(tlist);
end);


Print("misc.gi OK,\t");


