# tstfsroutputs.tst: testing outputs.gd/gi
# variants of IntFFExt, IntMatFFExt, IntVecFFExt, VecToString basis and non basis versions
gap> elm := Z(2^2);;
gap> IntFFExt(elm);
[ 0, 1 ]
gap> VecToString(elm);
"01"
gap> vec :=[0*Z(2), 0*Z(2), Z(2)^0 ];
[ 0*Z(2), 0*Z(2), Z(2)^0 ]
gap> IntVecFFExt(vec);
[ 0, 0, 1 ]
gap> VecToString(vec);
"001"
gap> vec :=[ Z(2^4)^9, Z(2^4), Z(2^4)^11];;
gap> IntVecFFExt(vec);
[ [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 1, 1, 1 ] ]
gap> VecToString(vec);
[ "0101", "0100", "0111" ]
gap> K := GF(2);; M := IdentityMat(3,K);;
gap> IntMatFFExt(M);
[ [ 1, 0, 0 ], [ 0, 1, 0 ], [ 0, 0, 1 ] ]
gap> VecToString(M);
[ "100", "010", "001" ]
gap> M := [[Z(2^4), Z(2)^0], [Z(2^4), Z(2^4)^3]];;
gap> IntMatFFExt(M);
[ [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ] ], [ [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ] ] ]
gap> VecToString(M);
[ [ "0100", "1000" ], [ "0100", "0001" ] ]
gap> K :=GF(2);; x :=X(K,"x");; f :=x^4+x^3+x^2+x+1;; F :=FieldExtension(K,f);; w := RootOfDefiningPolynomial(F);;
gap> B := Basis(GF(2^4));;
gap> B1 := Basis(F);;
gap> B2 := Basis(F, [w,w^2,w^4,w^8]);;
gap> for i in [1..Length(B)] do Print(IntFFExt(B[i]),"\t"); od;
1       [ 0, 1, 0, 0 ]  [ 0, 0, 1, 0 ]  [ 0, 0, 0, 1 ]
gap> for i in [1..Length(B)] do Print(IntFFExt(B, B[i]),"\t"); od;
[ 1, 0, 0, 0 ]  [ 0, 1, 0, 0 ]  [ 0, 0, 1, 0 ]  [ 0, 0, 0, 1 ]
gap> for i in [1..Length(B)] do Print(IntFFExt(B, B1[i]),"\t"); od;
[ 1, 0, 0, 0 ]  [ 0, 0, 0, 1 ]  [ 0, 0, 1, 1 ]  [ 0, 1, 0, 1 ]
gap> for i in [1..Length(B)] do Print(IntFFExt(B, B2[i]),"\t"); od;
[ 0, 0, 0, 1 ]  [ 0, 0, 1, 1 ]  [ 1, 1, 1, 1 ]  [ 0, 1, 0, 1 ]
gap> vec :=[ Z(2^4)^9, Z(2^4), Z(2^4)^11];;
gap> IntVecFFExt(B,vec);
[ [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 1, 1, 1 ] ]
gap> IntVecFFExt(B1,vec);
[ [ 0, 0, 0, 1 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ] ]
gap> IntVecFFExt(B2,vec);
[ [ 0, 0, 0, 1 ], [ 1, 0, 0, 1 ], [ 1, 1, 0, 1 ] ]
gap> VecToString(B,vec);
[ "0101", "0100", "0111" ]
gap> VecToString(B1,vec);
[ "0001", "0101", "0111" ]
gap> VecToString(B2,vec);
[ "0001", "1001", "1101" ]
gap> M := [ [ Z(2^4)^2, Z(2^4)^4 ], [ Z(2^4)^12, Z(2^4)^7 ], [ Z(2^4)^11, Z(2^4)^3 ] ];;
gap> IntMatFFExt(B,M);
[ [ [ 0, 0, 1, 0 ], [ 1, 1, 0, 0 ] ], [ [ 1, 1, 1, 1 ], [ 1, 1, 0, 1 ] ], [ [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ] ] ]
gap> IntMatFFExt(B1,M);
[ [ [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ], [ [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ] ], [ [ 0, 1, 1, 1 ], [ 0, 1, 0, 0 ] ] ]
gap> IntMatFFExt(B2,M);
[ [ [ 1, 1, 0, 0 ], [ 0, 1, 1, 0 ] ], [ [ 0, 0, 1, 0 ], [ 1, 1, 1, 0 ] ], [ [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ] ]
gap> VecToString(B,M);
[ [ "0010", "1100" ], [ "1111", "1101" ], [ "0111", "0001" ] ]
gap> VecToString(B1,M);
[ [ "0110", "1101" ], [ "1111", "1001" ], [ "0111", "0100" ] ]
gap> VecToString(B2,M);
[ [ "1100", "0110" ], [ "0010", "1110" ], [ "1101", "1000" ] ]
gap> elm := Z(2^2);;
gap> IntFFExt(B,elm);
[ 0, 1, 1, 0 ]
gap> IntFFExt(B1,elm);
[ 0, 0, 1, 1 ]
gap> IntFFExt(B2,elm);
[ 0, 1, 0, 1 ]
gap> elm := Z(2^4)^4;;
gap> IntFFExt(B,elm);
[ 1, 1, 0, 0 ]
gap> IntFFExt(B1,elm);
[ 1, 1, 0, 1 ]
gap> IntFFExt(B2,elm);
[ 0, 1, 1, 0 ]