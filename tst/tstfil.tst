gap> F := GF(2);; clist := [One(F), One(F)];; mlist := [x_0*x_1, x_2];;
gap> fil := FILFUN(F, clist, mlist);   
< FILFUN of length 3 over GF(2),
  with the MultivarPoly = x_0*x_1+x_2> 
gap> mpoly := clist * mlist;
x_0*x_1+x_2
gap> fil := FILFUN(F, mpoly);       
< FILFUN of length 3 over GF(2),
  with the MultivarPoly = x_0*x_1+x_2> 
gap> ist := [One(F),Zero(F),Zero(F)];; LoadStepFSR(fil,ist); 
0*Z(2)
gap> ist := [[One(F),Zero(F),Zero(F)], [One(F),One(F),Zero(F)], [One(F),Zero(F),One(F)]];;
gap> RunFSR(fil, ist);
[ 0*Z(2), Z(2)^0, Z(2)^0 ]
gap> RunFSR(fil, ist, true);
using basis B := [ Z(2)^0 ]
elm     input   ...              with output   
                [ [ 1 ], [ 0 ], [ 0 ] ]  ->                     [ 0 ]
                [ [ 1 ], [ 1 ], [ 0 ] ]  ->                     [ 1 ]
                [ [ 1 ], [ 0 ], [ 1 ] ]  ->                     [ 1 ]
[ 0*Z(2), Z(2)^0, Z(2)^0 ]
gap> PrintAll(fil);
FILFUN of length 3 over GF(2),
  with the MultivarPoly = x_0*x_1+x_2
with basis =[ Z(2)^0 ]
with current state  =[ Z(2)^0, 0*Z(2), Z(2)^0 ]
gap> ist := [[One(F),Zero(F),Zero(F)], [One(F),One(F),Zero(F)], [One(F),Zero(F),One(F)]];;
gap> elmvec := [ Z(2)^0, 0*Z(2), 0*Z(2) ];;
gap> RunFSR(fil, ist, elmvec, true);       
using basis B := [ Z(2)^0 ]
elm     input   ...              with output   
                [ [ 1 ], [ 0 ], [ 0 ] ]  ->                     [ 1 ]
                [ [ 1 ], [ 1 ], [ 0 ] ]  ->                     [ 1 ]
                [ [ 1 ], [ 0 ], [ 1 ] ]  ->                     [ 1 ]
[ Z(2)^0, Z(2)^0, Z(2)^0 ]
gap> RunFSR(fil, ist);              
[ 0*Z(2), Z(2)^0, Z(2)^0 ]
gap> RunFSR(fil, ist, elmvec);      
[ Z(2)^0, Z(2)^0, Z(2)^0 ]
gap> K := GF(2);; x := X(K, "x");; f:= x^3+x+Z(2)^0 ;;                              
gap> clist := [ One(F), One(F)];;
gap> mlist := [x_0, x_0*x_1*x_2];;
gap> fil := FILFUN(K, f, clist, mlist);;
gap> ist := [[Zero(K),Z(2^3),One(K)], [ Z(2^3)^3, Z(2^3)^4, 0*Z(2)], [Z(2^3)^2,Z(2^3)^4,One(K)]];;
gap> RunFSR(fil,ist);
[ 0*Z(2), Z(2^3)^3, Z(2)^0 ]
gap> F := GF(2);; mpoly := x_0*x_2 + 1;;
gap> fil := FILFUN(F, mpoly); 
< FILFUN of length 2 over GF(2),
  with the MultivarPoly = x_0*x_2+Z(2)^0> 
gap> ConstTermOfFSR(fil);
Z(2)^0
gap> F := GF(2^4);; mpoly := Z(2^4)*x_0^3+Z(2^4)^7;                      
Z(2^4)*x_0^3+Z(2^4)^7
gap> fil := FILFUN(F, mpoly);                                          
< FILFUN of length 1 over GF(2^4),
  with the MultivarPoly = Z(2^4)*x_0^3+Z(2^4)^7> 
gap> GeneratorOfUnderlyingField(fil);              
Z(2^4)
gap> FFExtCoefficients(fil);
[ [ Z(2^4), Z(2^4)^7 ], [ 0, -1 ] ]
gap> LoadStepFSR(fil, Z(2^4)^3);
Z(2^4)^6
gap> LoadStepFSR(fil, Z(2^4)^3, One(F));
Z(2^4)^13
gap> ConstTermOfFSR(fil);
Z(2^4)^7
gap> GeneratorOfField(F);
Z(2^4)
gap> GeneratorWRTDefiningPolynomial(F);
[ 0*Z(2), Z(2)^0, 0*Z(2), 0*Z(2) ]