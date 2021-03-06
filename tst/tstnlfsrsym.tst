gap> F := GF(2);; clist := [One(F), One(F)];; mlist := [x_0*x_1, x_2];;
gap> nl := NLFSR(F, clist, mlist, 3);
< empty NLFSR of length 3 over GF(2),
  given by MultivarPoly = x_0*x_1+x_2> 
gap> ist := [s_2,s_1,s_0];; LoadFSR(nl,ist);;
gap> PrintAll(nl);
NLFSR of length 3 over GF(2),
  given by MultivarPoly = x_0*x_1+x_2
with basis =[ Z(2)^0 ]
with initial state  =[ s_2, s_1, s_0 ]
with current state  =[ s_2, s_1, s_0 ]
after loading
with output from stage S_0
gap> RunFSR(nl);
[ s_1, s_2, s_0*s_1+s_2, s_0*s_1+s_1*s_2+s_2, s_0*s_1*s_2+s_0*s_1+s_1*s_2, s_2,
s_0*s_1+s_2, s_0*s_1+s_1*s_2+s_2, s_0*s_1*s_2+s_0*s_1+s_1*s_2, s_2, s_0*s_1+s_2, 
s_0*s_1+s_1*s_2+s_2, s_0*s_1*s_2+s_0*s_1+s_1*s_2, s_2, s_0*s_1+s_2, 
s_0*s_1+s_1*s_2+s_2, s_0*s_1*s_2+s_0*s_1+s_1*s_2, s_2, s_0*s_1+s_2 ]
gap> K := GF(2);; x := X(K, "x");; f:= x^3+x+Z(2)^0 ;;                              
gap> F := FieldExtension(K, f);;    B:= Basis(F);; 
gap> clist := [ One(F), One(F)];;
gap> mlist := [x_0, x_0*x_1*x_2];;
gap> nl := NLFSR(F, clist, mlist, 3);
< empty NLFSR of length 3 over GF(2^3),
  given by MultivarPoly = x_0*x_1*x_2+x_0> 
gap>  ist := [s_2,s_1,s_0];; RunFSR(nl,ist, 10);   
[ s_0, s_1, s_2, s_0*s_1*s_2+s_0, s_0*s_1^2*s_2^2+s_0*s_1*s_2+s_1, 
s_0^2*s_1^3*s_2^4+s_0^2*s_1*s_2^2+s_0*s_1^2*s_2^2+s_0*s_1*s_2+s_2, 
  s_0^4*s_1^6+s_0^4*s_1^2*s_2^3+s_0^2*s_1^4*s_2^3+s_0^2*s_1^3*s_2^4+s_0^2*s_1^2*s_2+s_0^2*s_1*s_2^2+s_0*s_1^2*s_2^2+s_0, 
  s_0^3*s_1^6*s_2^4+s_0^3*s_1^4*s_2^6+s_0^3*s_1^5*s_2^3+s_0^3*s_1^3*s_2^5+s_0^4*s_1^6+s_0^4*s_1^2*s_2^3+s_0^3*s_1^4*s_2^2+s_0^3*s_1^2*s_2^4+s_0^2*s_1^4*s_2^3+s_0^2*s_1^3*s_2^4+s_0^3*s_1^5+s_0^3*s_2^5+\
s_1^3*s_2^5+s_0*s_1^3*s_2^3+s_1^6*s_2+s_1^2*s_2^4+s_0^2*s_1^2*s_2+s_0^2*s_1*s_2^2+s_0*s_1^2*s_2^2+s_1^5+s_1*s_2^3+s_2^2+s_1, 
  s_0^6*s_1^5*s_2^6+s_0^4*s_1^4*s_2^6+s_0^6*s_1^3*s_2^4+s_0^5*s_1^4*s_2^4+s_0^4*s_1^3*s_2^6+s_0^3*s_1^6*s_2^4+s_0^3*s_1^4*s_2^6+s_0^2*s_1^5*s_2^6+s_0^6*s_1^2*s_2^3+s_0^5*s_1^5*s_2+s_0^5*s_1^3*s_2^3+s_\
0^5*s_1*s_2^5+s_0^3*s_1^5*s_2^3+s_0^3*s_1^3*s_2^5+s_0^5*s_1^4*s_2+s_0^5*s_1*s_2^4+s_0^4*s_1^6+s_0^4*s_2^6+s_0^3*s_1^6*s_2+s_0^3*s_1^3*s_2^4+s_1^6*s_2^4+s_1^4*s_2^6+s_0^5*s_1^4+s_0^5*s_2^4+s_0^4*s_1^3*\
s_2^2+s_0^4*s_1^2*s_2^3+s_0^3*s_1^4*s_2^2+s_0^2*s_1^4*s_2^3+s_0^5*s_1^3+s_0^5*s_2^3+s_0^3*s_1^2*s_2^3+s_0^3*s_2^5+s_1^5*s_2^3+s_1^3*s_2^5+s_0^6*s_2+s_0^5*s_1*s_2+s_0^4*s_2^3+s_0^3*s_1*s_2^3+s_0*s_1^3*\
s_2^3+s_0*s_2^6+s_1*s_2^6+s_0^4*s_2^2+s_0^3*s_1*s_2^2+s_0^2*s_1^2*s_2^2+s_1^4*s_2^2+s_0^5+s_0^2*s_1^2*s_2+s_0^2*s_1*s_2^2+s_0*s_1^2*s_2^2+s_0^3*s_2+s_1^3*s_2+s_0^2+s_0*s_1+s_1^2+s_2, 
  s_0^6*s_1^6*s_2^6+s_0^6*s_1^5*s_2^6+s_0^6*s_1^6*s_2^3+s_0^6*s_1^4*s_2^5+s_0^6*s_1^3*s_2^6+s_0^6*s_1^4*s_2^4+s_0^6*s_1^2*s_2^6+s_0^5*s_1^3*s_2^6+s_0^3*s_1^6*s_2^5+s_0^6*s_1^4*s_2^3+s_0^6*s_1^3*s_2^4+\
s_0^6*s_1^2*s_2^5+s_0^5*s_1^6*s_2^2+s_0^5*s_1^4*s_2^4+s_0^4*s_1^6*s_2^3+s_0^4*s_1^5*s_2^4+s_0^4*s_1^3*s_2^6+s_0^3*s_1^6*s_2^4+s_0^3*s_1^4*s_2^6+s_0^2*s_1^6*s_2^5+s_0^2*s_1^5*s_2^6+s_0*s_1^6*s_2^6+s_0^\
6*s_1^6+s_0^6*s_1^3*s_2^3+s_0^6*s_2^6+s_0^5*s_1^2*s_2^5+s_0^3*s_1^5*s_2^4+s_0*s_1^6*s_2^5+s_1^6*s_2^6+s_0^6*s_1^4*s_2+s_0^6*s_1^3*s_2^2+s_0^5*s_1^3*s_2^3+s_0^5*s_1*s_2^5+s_0^4*s_1^4*s_2^3+s_0^4*s_1^2*\
s_2^5+s_0^3*s_1^5*s_2^3+s_0^3*s_1^3*s_2^5+s_0*s_1^5*s_2^5+s_1^6*s_2^5+s_0^6*s_2^4+s_0^5*s_1^4*s_2+s_0^5*s_1*s_2^4+s_0^4*s_1^5*s_2+s_0^4*s_1^3*s_2^3+s_0^4*s_1^2*s_2^4+s_0^4*s_2^6+s_0^3*s_1^4*s_2^3+s_0^\
3*s_1^2*s_2^5+s_0^2*s_1^6*s_2^2+s_0^2*s_1^5*s_2^3+s_0^2*s_1^4*s_2^4+s_0^2*s_1^2*s_2^6+s_0*s_1^5*s_2^4+s_0*s_1^3*s_2^6+s_1^5*s_2^5+s_0^5*s_1^4+s_0^5*s_2^4+s_0^4*s_1^5+s_0^3*s_1^5*s_2+s_0*s_1^6*s_2^2+s_\
0^6*s_1*s_2+s_0^5*s_1^3+s_0^5*s_2^3+s_0^3*s_1^5+s_0^3*s_1^3*s_2^2+s_0^3*s_1*s_2^4+s_0^3*s_2^5+s_1^5*s_2^3+s_1^4*s_2^4+s_1^3*s_2^5+s_0^6*s_1+s_0^5*s_1*s_2+s_0^4*s_1^3+s_0^4*s_1^2*s_2+s_0^4*s_2^3+s_0^3*\
s_1^4+s_0*s_1^6+s_0*s_1^5*s_2+s_0*s_1^3*s_2^3+s_1^6*s_2+s_1^4*s_2^3+s_0^2*s_1^4+s_0^2*s_1^3*s_2+s_0^2*s_1^2*s_2^2+s_0^2*s_2^4+s_0*s_1^4*s_2+s_0*s_1*s_2^4+s_1^3*s_2^3+s_1^2*s_2^4+s_2^6+s_0^5+s_0^3*s_1^\
2+s_0^3*s_2^2+s_0^2*s_1^2*s_2+s_0^2*s_1*s_2^2+s_0*s_1^4+s_0*s_1^2*s_2^2+s_1^3*s_2^2+s_0^4+s_0*s_1^3+s_0*s_2^3+s_1^2*s_2^2+s_1*s_2^3+s_0*s_1*s_2+s_1^2*s_2+s_0*s_2+s_1^2+s_0+s_1+Z(2)^0, 
  s_0^6*s_1^6*s_2^6+s_0^6*s_1^6*s_2^5+s_0^6*s_1^5*s_2^5+s_0^6*s_1^6*s_2^3+s_0^6*s_1^5*s_2^4+s_0^6*s_1^6*s_2^2+s_0^6*s_1^3*s_2^5+s_0^5*s_1^6*s_2^3+s_0^5*s_1^5*s_2^4+s_0^5*s_1^3*s_2^6+s_0^4*s_1^5*s_2^5+\
s_0^4*s_1^4*s_2^6+s_0^3*s_1^6*s_2^5+s_0^3*s_1^5*s_2^6+s_0^6*s_1^5*s_2^2+s_0^6*s_1^2*s_2^5+s_0^6*s_1*s_2^6+s_0^5*s_1^5*s_2^3+s_0^5*s_1^4*s_2^4+s_0^5*s_1^2*s_2^6+s_0^4*s_1^6*s_2^3+s_0^4*s_1^5*s_2^4+s_0^\
4*s_1^4*s_2^5+s_0^4*s_1^3*s_2^6+s_0^3*s_1^5*s_2^5+s_0^3*s_1^4*s_2^6+s_0^2*s_1^5*s_2^6+s_0^6*s_1^6+s_0^6*s_1^5*s_2+s_0^6*s_1^4*s_2^2+s_0^6*s_1^3*s_2^3+s_0^6*s_1*s_2^5+s_0^6*s_2^6+s_0^5*s_1^2*s_2^5+s_0^\
5*s_1*s_2^6+s_0^4*s_1^3*s_2^5+s_0^3*s_1^6*s_2^3+s_0^3*s_1^5*s_2^4+s_0^3*s_1^4*s_2^5+s_0^2*s_1^5*s_2^5+s_0*s_1^6*s_2^5+s_0*s_1^5*s_2^6+s_1^6*s_2^6+s_0^6*s_1^5+s_0^6*s_1^2*s_2^3+s_0^6*s_1*s_2^4+s_0^5*s_\
1^4*s_2^2+s_0^5*s_1^3*s_2^3+s_0^4*s_1^6*s_2+s_0^4*s_1^5*s_2^2+s_0^4*s_1^3*s_2^4+s_0^4*s_1^2*s_2^5+s_0^4*s_1*s_2^6+s_0^3*s_1^6*s_2^2+s_0^3*s_1^5*s_2^3+s_0^3*s_1^4*s_2^4+s_0^2*s_1^6*s_2^3+s_0*s_1^6*s_2^\
4+s_0*s_1^4*s_2^6+s_1^6*s_2^5+s_1^5*s_2^6+s_0^6*s_1^3*s_2+s_0^6*s_1*s_2^3+s_0^5*s_1^4*s_2+s_0^5*s_1^3*s_2^2+s_0^4*s_1^6+s_0^4*s_1^5*s_2+s_0^4*s_1^4*s_2^2+s_0^4*s_1*s_2^5+s_0^3*s_1^6*s_2+s_0^3*s_1*s_2^\
6+s_0^2*s_1^4*s_2^4+s_0^2*s_1^2*s_2^6+s_0*s_1^5*s_2^4+s_0*s_1^4*s_2^5+s_0^6*s_1^3+s_0^6*s_1^2*s_2+s_0^6*s_1*s_2^2+s_0^5*s_1^4+s_0^5*s_1^3*s_2+s_0^4*s_1^5+s_0^4*s_1^4*s_2+s_0^4*s_2^5+s_0^3*s_1^6+s_0^3*\
s_1^2*s_2^4+s_0^3*s_2^6+s_0^2*s_1^5*s_2^2+s_0^2*s_1^4*s_2^3+s_0^2*s_1^3*s_2^4+s_0^2*s_1^2*s_2^5+s_0^2*s_1*s_2^6+s_0*s_1^6*s_2^2+s_0*s_1^5*s_2^3+s_0*s_1^3*s_2^5+s_0*s_1^2*s_2^6+s_0^6*s_1^2+s_0^6*s_2^2+\
s_0^5*s_1^3+s_0^5*s_2^3+s_0^4*s_2^4+s_0^3*s_1^5+s_0^3*s_1^3*s_2^2+s_0^3*s_1^2*s_2^3+s_0^3*s_1*s_2^4+s_0^3*s_2^5+s_0^2*s_1^3*s_2^3+s_0^2*s_1^2*s_2^4+s_0^2*s_1*s_2^5+s_0*s_1^6*s_2+s_0*s_1^3*s_2^4+s_0*s_\
1^2*s_2^5+s_1^5*s_2^3+s_1^3*s_2^5+s_0^6*s_2+s_0^5*s_1*s_2+s_0^4*s_1^3+s_0^4*s_1^2*s_2+s_0^4*s_1*s_2^2+s_0^4*s_2^3+s_0^3*s_1^3*s_2+s_0^3*s_1^2*s_2^2+s_0^2*s_1^4*s_2+s_0*s_1^5*s_2+s_0*s_1^4*s_2^2+s_0*s_\
1^3*s_2^3+s_0*s_1*s_2^5+s_0*s_2^6+s_1^6*s_2+s_1*s_2^6+s_0^6+s_0^4*s_1^2+s_0^4*s_1*s_2+s_0^3*s_1^3+s_0^3*s_1^2*s_2+s_0^3*s_1*s_2^2+s_0^2*s_1^3*s_2+s_0^2*s_1^2*s_2^2+s_0*s_1^2*s_2^3+s_0*s_1*s_2^4+s_0*s_\
2^5+s_1^6+s_1^2*s_2^4+s_2^6+s_0^5+s_0^3*s_1*s_2+s_0^2*s_1^3+s_0^2*s_1^2*s_2+s_0^2*s_1*s_2^2+s_0^2*s_2^3+s_0*s_1*s_2^3+s_1^5+s_1^2*s_2^3+s_1*s_2^4+s_0^3*s_1+s_0^3*s_2+s_0^2*s_2^2+s_0*s_1^2*s_2+s_1^4+s_\
1*s_2^3+s_0^2*s_2+s_0*s_1*s_2+s_1^2*s_2+s_1*s_2^2+s_2^2+Z(2)^0 ]
gap> F := GF(2);; clist := [One(F), One(F)];; mlist := [x_0 , x_1*x_2];;
gap> nl := NLFSR(F, clist, mlist, 3);;  ist := [s_2,s_1,s_0];;  
gap> seq1 := RunFSR(nl, ist);
[ s_0, s_1, s_2, s_1*s_2+s_0, s_0*s_2+s_1*s_2+s_1, s_0*s_1+s_0*s_2+s_2, s_0*s_1+s_1*s_2+s_0, s_0*s_2+s_1, s_0*s_1+s_1*s_2+s_2, s_0*s_2+s_1*s_2+s_0, s_0*s_1+s_0*s_2+s_1, s_0*s_1+s_2, s_0, s_1, s_2,      
  s_1*s_2+s_0, s_0*s_2+s_1*s_2+s_1, s_0*s_1+s_0*s_2+s_2, s_0*s_1+s_1*s_2+s_0, s_0*s_2+s_1 ]  
gap>  nl := NLFSR(F, clist, mlist, 4);;  ist := [s_3,s_2,s_1,s_0];; 
gap> seq1 := RunFSR(nl, ist);
[ s_0, s_1, s_2, s_3, s_1*s_2+s_0, s_2*s_3+s_1, s_1*s_2*s_3+s_0*s_3+s_2, s_0*s_2*s_3+s_1*s_2*s_3+s_0*s_1+s_1*s_2+s_3, s_0*s_1*s_3+s_0*s_2*s_3+s_2*s_3+s_0, s_0*s_1*s_2+s_0*s_1*s_3+s_0*s_3+s_1*s_2+s_1,   
  s_0*s_1*s_2+s_1*s_2*s_3+s_0*s_1+s_2*s_3+s_2, s_0*s_2*s_3+s_1*s_2*s_3+s_0*s_3+s_1*s_2+s_3, s_0*s_1*s_3+s_0*s_2*s_3+s_0*s_1+s_2*s_3+s_0, s_0*s_1*s_2+s_0*s_1*s_3+s_0*s_3+s_1,                             
  s_0*s_1*s_2+s_1*s_2*s_3+s_0*s_1+s_2, s_0*s_2*s_3+s_1*s_2+s_3, s_0*s_1*s_3+s_1*s_2*s_3+s_1*s_2+s_2*s_3+s_0, s_0*s_1*s_2+s_0*s_2*s_3+s_0*s_3+s_1*s_2+s_2*s_3+s_1,                                         
  s_0*s_1*s_3+s_1*s_2*s_3+s_0*s_1+s_0*s_3+s_1*s_2+s_2*s_3+s_2, s_0*s_1*s_2+s_0*s_2*s_3+s_0*s_1+s_0*s_3+s_1*s_2+s_2*s_3+s_3, s_0*s_1*s_3+s_1*s_2*s_3+s_0*s_1+s_0*s_3+s_1*s_2+s_2*s_3+s_0,                  
  s_0*s_1*s_2+s_0*s_2*s_3+s_0*s_1+s_0*s_3+s_1*s_2+s_2*s_3+s_1, s_0*s_1*s_3+s_1*s_2*s_3+s_0*s_1+s_0*s_3+s_2*s_3+s_2, s_0*s_1*s_2+s_0*s_2*s_3+s_0*s_1+s_0*s_3+s_1*s_2+s_3,                                  
  s_0*s_1*s_3+s_0*s_1+s_1*s_2+s_2*s_3+s_0, s_0*s_1*s_2+s_1*s_2*s_3+s_0*s_3+s_2*s_3+s_1, s_0*s_2*s_3+s_1*s_2*s_3+s_0*s_1+s_0*s_3+s_1*s_2+s_2, s_0*s_1*s_3+s_0*s_2*s_3+s_0*s_1+s_2*s_3+s_3,                 
  s_0*s_1*s_2+s_0*s_1*s_3+s_0*s_3+s_1*s_2+s_0, s_0*s_1*s_2+s_1*s_2*s_3+s_0*s_1+s_2*s_3+s_1, s_0*s_2*s_3+s_1*s_2*s_3+s_0*s_3+s_1*s_2+s_2, s_0*s_1*s_3+s_0*s_2*s_3+s_0*s_1+s_1*s_2+s_2*s_3+s_3,             
  s_0*s_1*s_2+s_0*s_1*s_3+s_0*s_3+s_1*s_2+s_2*s_3+s_0, s_0*s_1*s_2+s_0*s_1+s_0*s_3+s_2*s_3+s_1, s_0*s_1+s_0*s_3+s_2, s_0*s_1+s_3, s_0 ]  
gap> F := GF(2);; clist := [One(F), One(F)];; mlist := [x_0 , x_1*x_2];;
gap> nl := NLFSR(F, clist, mlist, 3);;  ist := [s_2,s_1,s_0];;  
gap> LoadFSR(nl,ist);; StepFSR(nl,s_10);                                
s_1
gap> Print(nl);                                                         
NLFSR of length 3 over GF(2),
  given by MultivarPoly = x_1*x_2+x_0
with basis =[ Z(2)^0 ]
with current state =[ s_1*s_2+s_0+s_10, s_2, s_1 ]
after  1 steps







