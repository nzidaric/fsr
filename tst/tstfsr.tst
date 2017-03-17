
###############################
#F  LFSR( <K>, <charpol> ) 
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(t1);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_0
###############################
#F  LFSR( <F>, <charpol>)						# len 2
gap> F := FieldExtension(K, f);;B := Basis(F);;
gap> t1 := LFSR(F, l);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(t1);
Empty LFSR over GF(2^4) given by CharPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_0
###############################
#F  LFSR( <K>, <charpol>, <tap> ) 
gap> K := GF(2);; y := X(K, "y");; tap := 0;;
gap> l := y^3 + y + 1;; B := Basis(K);;
gap> t2:=  LFSR(K, l, tap);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(t2);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_0
# change taps
gap> tap := 2;;
gap> t3 :=  LFSR(K, l, tap);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(t3);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_2
gap> tap := 5;;
gap> t4 :=  LFSR(K, l, tap);
argument tap[1]=5 is out of range 0..2, or not given => im taking S_0 instead!
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(t4);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_0
gap> tap := [0,2];;
gap> t5 :=  LFSR(K, l, tap);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(t5);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stages S_[ 0, 2 ]
###############################
#F  LFSR( <K>, <fieldpol>, <charpol>, <tap>)
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(t6);
Empty LFSR over GF(2^4) given by CharPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_1
# change taps
gap> tap := [0,2,3];;
gap> t6 := LFSR(K, f, l, tap);;
gap> PrintAll(t6);
Empty LFSR over GF(2^4) given by CharPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stages S_[ 0, 2, 3 ]
gap> tap := 9;;
gap> t6 := LFSR(K, f, l, tap);
argument tap[1]=9 is out of range 0..3, or not given => im taking S_0 instead!
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(t6);
Empty LFSR over GF(2^4) given by CharPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_0
gap> WhichBasis(t6);
CanonicalBasis( GF(2^4) )
gap> B := Basis(F, Conjugates(Z(2^4)^3));;
gap> ChangeBasis(t6,B);                  
true
gap> WhichBasis(t6);                     
Basis( GF(2^4), [ Z(2^4)^3, Z(2^4)^6, Z(2^4)^12, Z(2^4)^9 ] )
###############################
#F  LFSR( <F>, <charpol>, <tap>)
gap> F := FieldExtension(K, f);;
gap> B := Basis(F, Conjugates(Z(2^4)^3));; tap := 1;;
gap> t7 := LFSR(F, l, B, tap);
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(t7);                                                             
Empty LFSR over GF(2^4) given by CharPoly = y^4+y+Z(2^4)
with basis =[ Z(2^4)^3, Z(2^4)^6, Z(2^4)^12, Z(2^4)^9 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stage S_1
gap> B := Basis(GF(2^2), [Z(2^2), Z(2^2)^2]);;
gap> t7 := LFSR(F, l, B, tap);            
Basis does not match field F!!! using canonical basis instead
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
###############################
#F  LFSR( <p>, <m>, <n>, <tap>  )
gap> p := 2;; m:= 2;; n := 5;;  B := Basis(GF(p^m));; taps := [0,3,9];;
gap> t8 := LFSR(p, m, n,taps);
argument tap[3]=9 is out of range 0..4, or not given => im taking S_0 instead!
< empty LFSR given by CharPoly = x^5+Z(2^2)*x^4+Z(2^2)>
gap> PrintAll(t8);
Empty LFSR over GF(2^2) given by CharPoly = x^5+Z(2^2)*x^4+Z(2^2)
with basis =[ Z(2)^0, Z(2^2) ]
with feedback coeff =[ Z(2^2), 0*Z(2), 0*Z(2), 0*Z(2), Z(2^2) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization 
with output from stages S_[ 0, 3, 0 ]

