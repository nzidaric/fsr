gap> M := [ [ 0*Z(2), 0*Z(2), 0*Z(2), Z(2)^0 ], [ Z(2)^0, 0*Z(2), 0*Z(2), 0*Z(2) ], [ 0*Z(2), Z(2)^0, 0*Z(2), 0*Z(2) ], [ 0*Z(2), 0*Z(2), Z(2)^0, Z(2)^0 ] ];
[ [ 0*Z(2), 0*Z(2), 0*Z(2), Z(2)^0 ], [ Z(2)^0, 0*Z(2), 0*Z(2), 0*Z(2) ], [ 0*Z(2), Z(2)^0, 0*Z(2), 0*Z(2) ], [ 0*Z(2), 0*Z(2), Z(2)^0, Z(2)^0 ] ]
gap> 
gap> gapshell :=  OutputTextUser();
OutputTextFile(*stdout*)
gap> WriteMatrix(gapshell, Basis(GF(2)), M);
0001
1000
0100
0011gap> 
gap> WriteVector(gapshell, Basis(GF(2)), M[1]);
0001gap> 