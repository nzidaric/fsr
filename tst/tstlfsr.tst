gap> LFSR(2,5,7);;
gap> LFSR(2,5,7,0);;
gap> LFSR(2,5,7,[0,2]);;
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2)  given by FeedbackPoly = y+Z(2)^0 >
gap> Length(t1);
1
gap> LoadFSR(t1, [One(K)]);
Z(2)^0
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t1);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> x := X(K, "x");; f := x^4 + x^3 + 1;;
gap> F := FieldExtension(K, f);;B := Basis(F);;
gap> t1 := LFSR(F, l);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t1);
empty LFSR over GF(2^4) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> K := GF(2);; y := X(K, "y");; tap := 0;;
gap> l := y^3 + y + 1;; B := Basis(K);;
gap> t2:=  LFSR(K, l, tap);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t2);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> tap := 2;;
gap> t3 :=  LFSR(K, l, tap);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t3);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_2
gap> tap := 5;;
gap> t4 :=  LFSR(K, l, tap);
argument tap[1]=5 is out of range 0..2, or not given => im taking S_0 instead!
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t4);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> tap := [0,2];;
gap> t5 :=  LFSR(K, l, tap);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t5);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stages S_[ 0, 2 ]
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> PrintAll(t6);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_1
gap> tap := [0,2,3];;
gap> t6 := LFSR(K, f, l, tap);;
gap> PrintAll(t6);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stages S_[ 0, 2, 3 ]
gap> tap := 9;;
gap> t6 := LFSR(K, f, l, tap);
argument tap[1]=9 is out of range 0..3, or not given => im taking S_0 instead!
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> PrintAll(t6);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
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
gap> F := FieldExtension(K, f);;
gap> B := Basis(F, Conjugates(Z(2^4)^3));; tap := 1;;
gap> t7 := LFSR(F, l, B, tap);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> PrintAll(t7);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
with basis =[ Z(2^4)^3, Z(2^4)^6, Z(2^4)^12, Z(2^4)^9 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_1
gap> B := Basis(GF(2^2), [Z(2^2), Z(2^2)^2]);;
gap> t7 := LFSR(F, l, B, tap);
Basis does not match field F!!! using canonical basis instead
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> t9 := LFSR(K, f, l);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> ist := [  Z(2^4) ,  0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
gap> LoadFSR(t9,ist);
Z(2^4)^8
gap> sequence :=[];; K := GF(2);; y := X(K, "y");; l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);; ist1 :=[0*Z(2), 0*Z(2), Z(2)^0 ];;
gap> Add(sequence,LoadFSR(t1,ist1));; sequence;
[ Z(2)^0 ]
gap> for i in [1..9] do Add(sequence,StepFSR(t1)); od; sequence;
[ Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2) ]
gap> sequence :=[];; Add(sequence,LoadFSR(t1,ist1));;
gap> for i in [1..10] do  Add(sequence,StepFSR(t1,Z(2)^0)); od;  sequence;
[ Z(2)^0, 0*Z(2), 0*Z(2), 0*Z(2), Z(2)^0, Z(2)^0, 0*Z(2), Z(2)^0, 0*Z(2), 0*Z(2), 0*Z(2) ]
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> t10 := LFSR(K, f, l);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> FieldPoly(t10); UnderlyingField(t10); FeedbackVec(t10); OutputTap(t10);
x^4+x^3+Z(2)^0
GF(2^4)
[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
[ 0 ]
gap> Length(t10); InternalStateSize(t10);
4
16
gap> ist :=[0*Z(2), Z(2^4), Z(2^4)^5, Z(2)^0 ];;
gap> RunFSR(t10,ist, 200);
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11, Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2)^2, Z(2^4)^2,
  Z(2^4), Z(2^4)^2, Z(2^4)^9, Z(2^4)^9, 0*Z(2), Z(2^4), Z(2^4)^13, Z(2^2)^2, Z(2^4), Z(2^4)^14, Z(2^4)^11, Z(2^4)^6, Z(2^4)^13, Z(2^4)^12, Z(2^4)^4, Z(2^2), Z(2^2), Z(2^4)^11,
  0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^12, Z(2^4)^9, Z(2^4)^8, Z(2^4)^7, Z(2^2)^2, Z(2^4), Z(2)^0, Z(2^4), Z(2^4)^6, Z(2^4)^8, 0*Z(2), Z(2^4)^3, Z(2^4)^11, Z(2^4)^9, Z(2^4)^3,
  Z(2^4)^13, Z(2^4)^8, Z(2^4)^12, Z(2^4)^11, Z(2^4)^6, Z(2^4)^8, Z(2^4)^4, Z(2^4)^4, Z(2^4)^11, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2), Z(2^4)^2, Z(2^4), Z(2^4)^8, Z(2^4)^3,
  Z(2^4)^9, Z(2)^0, Z(2^4), Z(2^4)^14, Z(2^2), 0*Z(2), Z(2^4)^13, Z(2^2)^2, Z(2^4)^6, Z(2^4)^13, Z(2^4)^11, Z(2^4), Z(2^2), Z(2^2)^2, Z(2^4)^13, Z(2^4), Z(2^4)^7, Z(2^4)^4,
  Z(2^4)^7, Z(2^4)^12, Z(2^2), Z(2^4)^13, Z(2^4)^9, Z(2^4)^7, Z(2)^0, Z(2^4)^4, Z(2^4)^6, Z(2^4)^2, Z(2)^0, Z(2^4)^9, Z(2^4)^12, Z(2^4)^14, Z(2^4)^3, Z(2^4)^3, Z(2^4)^2,
  Z(2^4)^14, Z(2^4)^7, Z(2^2)^2, Z(2)^0, Z(2^4)^9, Z(2^4), Z(2^4)^12, Z(2^4)^3, Z(2^4)^8, Z(2^4)^7, Z(2^4)^8, Z(2^2), Z(2)^0, 0*Z(2), Z(2^4)^6, Z(2^4)^13, Z(2^4), Z(2^4)^6,
  Z(2^2), Z(2^4)^7, Z(2^4)^3, Z(2^4)^13, Z(2^2)^2, Z(2^4)^13, Z(2^4)^11, Z(2^4)^11, Z(2^4)^4, Z(2^2)^2, Z(2)^0, Z(2^4)^6, Z(2)^0, Z(2^4)^12, Z(2^4)^11, Z(2^4)^9, Z(2^4)^13,
  Z(2^4)^4, Z(2^4)^8, Z(2^4)^9, Z(2^4)^9, Z(2^4)^4, 0*Z(2), Z(2^4)^13, Z(2^4)^2, Z(2^2), Z(2^4)^13, Z(2^4)^13, Z(2^4)^11, Z(2)^0, Z(2^4)^2, Z(2^2)^2, Z(2^4)^11, Z(2^2),
  Z(2^4)^12, 0*Z(2), Z(2^4)^14, Z(2^4)^4, Z(2^4)^13, Z(2^4)^14, Z(2^4), Z(2^4)^7, 0*Z(2), Z(2^4)^4, Z(2^4)^12, Z(2^4)^8, Z(2^4)^4, Z(2^4)^14, Z(2^4)^3, Z(2^4)^14, Z(2^4)^12,
  Z(2^4)^14, Z(2^4)^9, Z(2^4)^11, Z(2^4)^2, Z(2^4)^7, Z(2^4)^14, Z(2^4)^7, Z(2^4)^4, Z(2^4)^6, Z(2^4)^9, Z(2^2), Z(2^4)^9, Z(2)^0, Z(2)^0, Z(2^2), Z(2^2), Z(2^4)^4, Z(2^4)^2,
  Z(2^4)^9, Z(2^4)^12, Z(2^4), Z(2^4), Z(2^4)^3, Z(2^4)^12, Z(2^2), Z(2^4)^6 ]
gap>  LoadFSR(t10, ist);; RunFSR(t10, 5);
[ Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
gap> LoadFSR(t10, ist);; RunFSR(t10,5,true);
		[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
[ Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
gap> RunFSR(t10,10,true);
		[ [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
		[ [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ] ]		[ 0, 0, 0, 1 ]
		[ [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ] ]		[ 0, 0, 1, 1 ]
		[ [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] ]		[ 1, 0, 1, 0 ]
[ Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3 ]
gap>  sequence := RunFSR(t10, ist);; Length(sequence);
131077
gap>  RunFSR(t10, ist, 40, true);
using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
elm				[ 3,	...	...,0 ]  with taps  [ 0 ]
		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
		[ [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ] ]		[ 0, 0, 0, 1 ]
		[ [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ] ]		[ 0, 0, 1, 1 ]
		[ [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] ]		[ 1, 0, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 1, 1, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 1, 1, 0 ], [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
		[ [ 1, 0, 0, 1 ], [ 0, 1, 1, 0 ], [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
		[ [ 0, 1, 0, 1 ], [ 1, 0, 0, 1 ], [ 0, 1, 1, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 0, 1 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 0, 0, 1, 0 ], [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 0, 1 ] ]		[ 1, 0, 0, 1 ]
		[ [ 0, 1, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 0, 0, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 1, 0, 0, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
		[ [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 1, 1, 0 ], [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ], [ 0, 0, 0, 1 ] ]		[ 0, 0, 0, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 1, 1, 0 ], [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ] ]		[ 1, 0, 0, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 1, 0 ], [ 1, 1, 1, 1 ] ]		[ 1, 1, 1, 1 ]
		[ [ 0, 1, 1, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 1, 0 ] ]		[ 1, 1, 1, 0 ]
		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 1, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 1, 1, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
		[ [ 0, 0, 1, 1 ], [ 1, 1, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 0, 1, 0, 0 ], [ 0, 0, 1, 1 ], [ 1, 1, 0, 0 ], [ 1, 1, 1, 1 ] ]		[ 1, 1, 1, 1 ]
		[ [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 1 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11, Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2)^2, Z(2^4)^2,
  Z(2^4), Z(2^4)^2, Z(2^4)^9, Z(2^4)^9, 0*Z(2), Z(2^4), Z(2^4)^13, Z(2^2)^2, Z(2^4), Z(2^4)^14, Z(2^4)^11, Z(2^4)^6, Z(2^4)^13, Z(2^4)^12, Z(2^4)^4, Z(2^2), Z(2^2), Z(2^4)^11,
  0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^12, Z(2^4)^9 ]
gap> elmvec := [Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14];;
gap> sequence := RunFSR(t10, ist, elmvec, true);
using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
elm				[ 3,	...	...,0 ]  with taps  [ 0 ]
[ 0, 0, 0, 0 ]		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
[ 1, 0, 1, 1 ]		[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
[ 1, 0, 1, 1 ]		[ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
[ 1, 1, 0, 1 ]		[ [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
[ 0, 1, 0, 0 ]		[ [ 0, 1, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
[ 0, 0, 0, 1 ]		[ [ 1, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
[ 0, 1, 1, 1 ]		[ [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
[ 0, 1, 0, 1 ]		[ [ 1, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
[ 0, 0, 1, 0 ]		[ [ 1, 1, 0, 0 ], [ 1, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^7, Z(2^2) ]
gap> RunFSR(t10,  ist, elmvec, false);
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^7, Z(2^2) ]
gap> RunFSR(t10, ist, elmvec);
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^7, Z(2^2) ]
gap>  RunFSR(t10, 0 , elmvec);
[ Z(2^4)^7, Z(2^4)^3, Z(2^4)^9, Z(2^4)^4, Z(2^4)^14, Z(2^4)^12, Z(2^4)^12, Z(2^4)^4 ]
gap>  RunFSR(t10, 0 , elmvec, true);
using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
elm				[ 3,	...	...,0 ]  with taps  [ 0 ]
[ 0, 0, 0, 0 ]		[ [ 0, 1, 0, 1 ], [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ],
  [ 1, 1, 1, 0 ] ]
[ 1, 0, 1, 1 ]		[ [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 0, 1, 1 ],
  [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
[ 1, 0, 1, 1 ]		[ [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ],
  [ 0, 0, 1, 1 ] ]		[ 0, 0, 1, 1 ]
[ 1, 1, 0, 1 ]		[ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ],
  [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
[ 0, 1, 0, 0 ]		[ [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ],
  [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
[ 0, 0, 0, 1 ]		[ [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ],
  [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
[ 0, 1, 1, 1 ]		[ [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ],
  [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
[ 0, 1, 0, 1 ]		[ [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ],
  [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
[ 0, 0, 1, 0 ]		[ [ 0, 1, 1, 1 ], [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ],
  [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
[ 0*Z(2), Z(2^4)^8, Z(2^2)^2, Z(2^4), Z(2)^0, Z(2^4)^7, Z(2^2)^2,
  Z(2^4)^14 ]
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2)  given by FeedbackPoly = y+Z(2)^0 >
gap> Length(t1);
1
gap> LoadFSR(t1, [One(K)]);
Z(2)^0
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t1);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> x := X(K, "x");; f := x^4 + x^3 + 1;;
gap> F := FieldExtension(K, f);;B := Basis(F);;
gap> t1 := LFSR(F, l);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t1);
empty LFSR over GF(2^4) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> K := GF(2);; y := X(K, "y");; tap := 0;;
gap> l := y^3 + y + 1;; B := Basis(K);;
gap> t2:=  LFSR(K, l, tap);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t2);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> tap := 2;;
gap> t3 :=  LFSR(K, l, tap);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t3);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_2
gap> tap := 5;;
gap> t4 :=  LFSR(K, l, tap);
argument tap[1]=5 is out of range 0..2, or not given => im taking S_0 instead!
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t4);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_0
gap> tap := [0,2];;
gap> t5 :=  LFSR(K, l, tap);
< empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t5);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stages S_[ 0, 2 ]
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> PrintAll(t6);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_1
gap> tap := [0,2,3];;
gap> t6 := LFSR(K, f, l, tap);;
gap> PrintAll(t6);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stages S_[ 0, 2, 3 ]
gap> tap := 9;;
gap> t6 := LFSR(K, f, l, tap);
argument tap[1]=9 is out of range 0..3, or not given => im taking S_0 instead!
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> PrintAll(t6);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
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
gap> F := FieldExtension(K, f);;
gap> B := Basis(F, Conjugates(Z(2^4)^3));; tap := 1;;
gap> t7 := LFSR(F, l, B, tap);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> PrintAll(t7);
empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4)
with basis =[ Z(2^4)^3, Z(2^4)^6, Z(2^4)^12, Z(2^4)^9 ]
with feedback coeff =[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_1
gap> B := Basis(GF(2^2), [Z(2^2), Z(2^2)^2]);;
gap> t7 := LFSR(F, l, B, tap);
Basis does not match field F!!! using canonical basis instead
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> t9 := LFSR(K, f, l);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> ist := [  Z(2^4) ,  0*Z(2) ,  Z(2^4)^3 ,  Z(2^4)^8  ];;
gap> LoadFSR(t9,ist);
Z(2^4)^8
gap> sequence :=[];; K := GF(2);; y := X(K, "y");; l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);; ist1 :=[0*Z(2), 0*Z(2), Z(2)^0 ];;
gap> Add(sequence,LoadFSR(t1,ist1));; sequence;
[ Z(2)^0 ]
gap> for i in [1..9] do Add(sequence,StepFSR(t1)); od; sequence;
[ Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2) ]
gap> sequence :=[];; Add(sequence,LoadFSR(t1,ist1));;
gap> for i in [1..10] do  Add(sequence,StepFSR(t1,Z(2)^0)); od;  sequence;
[ Z(2)^0, 0*Z(2), 0*Z(2), 0*Z(2), Z(2)^0, Z(2)^0, 0*Z(2), Z(2)^0, 0*Z(2), 0*Z(2), 0*Z(2) ]
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> t10 := LFSR(K, f, l);
< empty LFSR over GF(2^4) given by FeedbackPoly = y^4+y+Z(2^4) >
gap> FieldPoly(t10); UnderlyingField(t10); FeedbackVec(t10); OutputTap(t10);
x^4+x^3+Z(2)^0
GF(2^4)
[ 0*Z(2), 0*Z(2), Z(2)^0, Z(2^4) ]
[ 0 ]
gap> Length(t10); InternalStateSize(t10);
4
16
gap> ist :=[0*Z(2), Z(2^4), Z(2^4)^5, Z(2)^0 ];;
gap> RunFSR(t10,ist, 200, false);
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11, Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2)^2, Z(2^4)^2,
  Z(2^4), Z(2^4)^2, Z(2^4)^9, Z(2^4)^9, 0*Z(2), Z(2^4), Z(2^4)^13, Z(2^2)^2, Z(2^4), Z(2^4)^14, Z(2^4)^11, Z(2^4)^6, Z(2^4)^13, Z(2^4)^12, Z(2^4)^4, Z(2^2), Z(2^2), Z(2^4)^11,
  0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^12, Z(2^4)^9, Z(2^4)^8, Z(2^4)^7, Z(2^2)^2, Z(2^4), Z(2)^0, Z(2^4), Z(2^4)^6, Z(2^4)^8, 0*Z(2), Z(2^4)^3, Z(2^4)^11, Z(2^4)^9, Z(2^4)^3,
  Z(2^4)^13, Z(2^4)^8, Z(2^4)^12, Z(2^4)^11, Z(2^4)^6, Z(2^4)^8, Z(2^4)^4, Z(2^4)^4, Z(2^4)^11, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2), Z(2^4)^2, Z(2^4), Z(2^4)^8, Z(2^4)^3,
  Z(2^4)^9, Z(2)^0, Z(2^4), Z(2^4)^14, Z(2^2), 0*Z(2), Z(2^4)^13, Z(2^2)^2, Z(2^4)^6, Z(2^4)^13, Z(2^4)^11, Z(2^4), Z(2^2), Z(2^2)^2, Z(2^4)^13, Z(2^4), Z(2^4)^7, Z(2^4)^4,
  Z(2^4)^7, Z(2^4)^12, Z(2^2), Z(2^4)^13, Z(2^4)^9, Z(2^4)^7, Z(2)^0, Z(2^4)^4, Z(2^4)^6, Z(2^4)^2, Z(2)^0, Z(2^4)^9, Z(2^4)^12, Z(2^4)^14, Z(2^4)^3, Z(2^4)^3, Z(2^4)^2,
  Z(2^4)^14, Z(2^4)^7, Z(2^2)^2, Z(2)^0, Z(2^4)^9, Z(2^4), Z(2^4)^12, Z(2^4)^3, Z(2^4)^8, Z(2^4)^7, Z(2^4)^8, Z(2^2), Z(2)^0, 0*Z(2), Z(2^4)^6, Z(2^4)^13, Z(2^4), Z(2^4)^6,
  Z(2^2), Z(2^4)^7, Z(2^4)^3, Z(2^4)^13, Z(2^2)^2, Z(2^4)^13, Z(2^4)^11, Z(2^4)^11, Z(2^4)^4, Z(2^2)^2, Z(2)^0, Z(2^4)^6, Z(2)^0, Z(2^4)^12, Z(2^4)^11, Z(2^4)^9, Z(2^4)^13,
  Z(2^4)^4, Z(2^4)^8, Z(2^4)^9, Z(2^4)^9, Z(2^4)^4, 0*Z(2), Z(2^4)^13, Z(2^4)^2, Z(2^2), Z(2^4)^13, Z(2^4)^13, Z(2^4)^11, Z(2)^0, Z(2^4)^2, Z(2^2)^2, Z(2^4)^11, Z(2^2),
  Z(2^4)^12, 0*Z(2), Z(2^4)^14, Z(2^4)^4, Z(2^4)^13, Z(2^4)^14, Z(2^4), Z(2^4)^7, 0*Z(2), Z(2^4)^4, Z(2^4)^12, Z(2^4)^8, Z(2^4)^4, Z(2^4)^14, Z(2^4)^3, Z(2^4)^14, Z(2^4)^12,
  Z(2^4)^14, Z(2^4)^9, Z(2^4)^11, Z(2^4)^2, Z(2^4)^7, Z(2^4)^14, Z(2^4)^7, Z(2^4)^4, Z(2^4)^6, Z(2^4)^9, Z(2^2), Z(2^4)^9, Z(2)^0, Z(2)^0, Z(2^2), Z(2^2), Z(2^4)^4, Z(2^4)^2,
  Z(2^4)^9, Z(2^4)^12, Z(2^4), Z(2^4), Z(2^4)^3, Z(2^4)^12, Z(2^2), Z(2^4)^6 ]
gap>  LoadFSR(t10, ist);; RunFSR(t10, 5);
[ Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
gap> LoadFSR(t10, ist);; RunFSR(t10, 5, true);
		[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
[ Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11 ]
gap> RunFSR(t10, 10,true);
		[ [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
		[ [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ] ]		[ 0, 0, 0, 1 ]
		[ [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ] ]		[ 0, 0, 1, 1 ]
		[ [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] ]		[ 1, 0, 1, 0 ]
[ Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3 ]
gap>  RunFSR(t10, ist, 40, true);
using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
elm				[ 3,	...	...,0 ]  with taps  [ 0 ]
		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
		[ [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 0, 1 ] ]		[ 0, 0, 0, 1 ]
		[ [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ], [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ], [ 0, 0, 1, 1 ] ]		[ 0, 0, 1, 1 ]
		[ [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 1, 0, 1, 0 ] ]		[ 1, 0, 1, 0 ]
		[ [ 1, 0, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 1, 1, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 0, 1, 1 ] ]		[ 1, 0, 1, 1 ]
		[ [ 0, 1, 1, 0 ], [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
		[ [ 1, 0, 0, 1 ], [ 0, 1, 1, 0 ], [ 0, 0, 0, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
		[ [ 0, 1, 0, 1 ], [ 1, 0, 0, 1 ], [ 0, 1, 1, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 0, 1 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 0, 0, 1, 0 ], [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ], [ 1, 0, 0, 1 ] ]		[ 1, 0, 0, 1 ]
		[ [ 0, 1, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
		[ [ 0, 0, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 1, 0, 0, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 1, 1 ], [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
		[ [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ], [ 0, 0, 0, 1 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 1, 1, 0 ], [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ], [ 0, 0, 0, 1 ] ]		[ 0, 0, 0, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 1, 1, 0 ], [ 1, 1, 1, 1 ], [ 1, 0, 0, 1 ] ]		[ 1, 0, 0, 1 ]
		[ [ 1, 1, 0, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 1, 0 ], [ 1, 1, 1, 1 ] ]		[ 1, 1, 1, 1 ]
		[ [ 0, 1, 1, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 1, 0 ] ]		[ 1, 1, 1, 0 ]
		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 1, 0, 1 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
		[ [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 1 ] ]		[ 0, 1, 1, 1 ]
		[ [ 1, 1, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
		[ [ 1, 1, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
		[ [ 0, 0, 1, 1 ], [ 1, 1, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
		[ [ 0, 1, 0, 0 ], [ 0, 0, 1, 1 ], [ 1, 1, 0, 0 ], [ 1, 1, 1, 1 ] ]		[ 1, 1, 1, 1 ]
		[ [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 1 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), Z(2^4)^2, Z(2^4)^11, Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14, Z(2^4)^8, Z(2^4)^3, Z(2^2)^2, Z(2^4)^2,
  Z(2^4), Z(2^4)^2, Z(2^4)^9, Z(2^4)^9, 0*Z(2), Z(2^4), Z(2^4)^13, Z(2^2)^2, Z(2^4), Z(2^4)^14, Z(2^4)^11, Z(2^4)^6, Z(2^4)^13, Z(2^4)^12, Z(2^4)^4, Z(2^2), Z(2^2), Z(2^4)^11,
  0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^12, Z(2^4)^9 ]
gap> elmvec := [Z(2^4)^2, Z(2^4)^2, Z(2^2), Z(2^4)^7, Z(2^4)^6, Z(2^4)^11, Z(2^2)^2, Z(2^4)^14];;
gap> sequence := RunFSR(t10, ist, elmvec, true);
using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
elm				[ 3,	...	...,0 ]  with taps  [ 0 ]
[ 0, 0, 0, 0 ]		[ [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ], [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
[ 1, 0, 1, 1 ]		[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
[ 1, 0, 1, 1 ]		[ [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
[ 1, 1, 0, 1 ]		[ [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
[ 0, 1, 0, 0 ]		[ [ 0, 1, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ], [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
[ 0, 0, 0, 1 ]		[ [ 1, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 1, 1, 0 ], [ 1, 1, 0, 0 ] ]		[ 1, 1, 0, 0 ]
[ 0, 1, 1, 1 ]		[ [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
[ 0, 1, 0, 1 ]		[ [ 1, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ], [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
[ 0, 0, 1, 0 ]		[ [ 1, 1, 0, 0 ], [ 1, 0, 1, 0 ], [ 0, 1, 0, 0 ], [ 1, 1, 0, 1 ] ]		[ 1, 1, 0, 1 ]
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^7, Z(2^2) ]
gap> RunFSR(t10,  ist, elmvec, false);
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^7, Z(2^2) ]
gap> RunFSR(t10, ist, elmvec);
[ Z(2)^0, Z(2^2), Z(2^4), 0*Z(2), 0*Z(2), Z(2^4)^9, Z(2^4), Z(2^4)^7, Z(2^2) ]
gap>  RunFSR(t10, 0 , elmvec);
[ Z(2^4)^7, Z(2^4)^3, Z(2^4)^9, Z(2^4)^4, Z(2^4)^14, Z(2^4)^12, Z(2^4)^12, Z(2^4)^4 ]
gap>  RunFSR(t10, 0 , elmvec, true);
using basis B := [ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
elm				[ 3,	...	...,0 ]  with taps  [ 0 ]
[ 0, 0, 0, 0 ]		[ [ 0, 1, 0, 1 ], [ 0, 0, 1, 1 ], [ 0, 0, 0, 0 ],
  [ 1, 1, 1, 0 ] ]
[ 1, 0, 1, 1 ]		[ [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 0, 1, 1 ],
  [ 0, 0, 0, 0 ] ]		[ 0, 0, 0, 0 ]
[ 1, 0, 1, 1 ]		[ [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 0, 1, 0, 1 ],
  [ 0, 0, 1, 1 ] ]		[ 0, 0, 1, 1 ]
[ 1, 1, 0, 1 ]		[ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ],
  [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
[ 0, 1, 0, 0 ]		[ [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ],
  [ 0, 1, 1, 0 ] ]		[ 0, 1, 1, 0 ]
[ 0, 0, 0, 1 ]		[ [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ], [ 0, 1, 0, 0 ],
  [ 1, 0, 0, 0 ] ]		[ 1, 0, 0, 0 ]
[ 0, 1, 1, 1 ]		[ [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ], [ 0, 1, 0, 1 ],
  [ 0, 1, 0, 0 ] ]		[ 0, 1, 0, 0 ]
[ 0, 1, 0, 1 ]		[ [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ], [ 0, 0, 1, 0 ],
  [ 0, 1, 0, 1 ] ]		[ 0, 1, 0, 1 ]
[ 0, 0, 1, 0 ]		[ [ 0, 1, 1, 1 ], [ 0, 0, 1, 1 ], [ 0, 1, 0, 1 ],
  [ 0, 0, 1, 0 ] ]		[ 0, 0, 1, 0 ]
[ 0*Z(2), Z(2^4)^8, Z(2^2)^2, Z(2^4), Z(2)^0, Z(2^4)^7, Z(2^2)^2,
  Z(2^4)^14 ]
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> ist := [One(K), Zero(K), One(K)];;
gap> LoadFSR(t1, ist); RunFSR(t1, Threshold(t1), true);
Z(2)^0
                [ [ 1 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 0 ], [ 0 ] ]         [ 0 ]
                [ [ 0 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 0 ], [ 0 ] ]         [ 0 ]
                [ [ 0 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 0 ], [ 0 ] ]         [ 0 ]
[ 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0,
  Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0,
  0*Z(2) ]
gap> LoadFSR(t1, ist); RunFSR(t1);
Z(2)^0
[ 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0,
  Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0,
  0*Z(2) ]
gap> LoadFSR(t1, ist); RunFSR(t1, 40, true);
Z(2)^0
                [ [ 1 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 0 ], [ 0 ] ]         [ 0 ]
                [ [ 0 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 0 ], [ 0 ] ]         [ 0 ]
                [ [ 0 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 1 ], [ 0 ] ]         [ 0 ]
                [ [ 1 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 1 ], [ 1 ] ]         [ 1 ]
                [ [ 0 ], [ 0 ], [ 1 ] ]         [ 1 ]
                [ [ 1 ], [ 0 ], [ 0 ] ]         [ 0 ]
over the threshold, will only output the first 19 elements of the sequence
[ 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0,
  Z(2)^0, Z(2)^0, 0*Z(2), 0*Z(2), Z(2)^0, 0*Z(2), Z(2)^0, Z(2)^0, Z(2)^0,
  0*Z(2) ]
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> t1 :=  LFSR(K, l, Basis(K));
< empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> t1 :=  LFSR(K, l, 2);
< empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t1);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_2
gap> t1 :=  LFSR(K, l, Basis(K), 2);
< empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> PrintAll(t1);
empty LFSR over GF(2) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0 ]
with feedback coeff =[ 0*Z(2), Z(2)^0, Z(2)^0 ]
with initial state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
with current state  =[ 0*Z(2), 0*Z(2), 0*Z(2) ]
after initialization
with output from stage S_2
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(K, f, l, B, tap);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(K, f, l, B);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(K, f, l);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(F, l);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(F, l, B, tap);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(F, l, B);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> IsPeriodic(t6);
true
gap> PeriodOfLFSR(t6);
warning: the polynomial is reducible !!!
255
gap> K := GF(2);; x := X(K, "x");; f := x^4 + x^3 + 1;;
gap> F := FieldExtension(K, f);; B := Basis(F);;
gap> gen := Z(2^4);; strGen := "alpha";;
gap> y := X(F, "y");; l := y^4 + y + gen;;
gap> test := LFSR(K, f, l);;
gap> PeriodOfLFSR(test);
warning: the polynomial is reducible !!!
255
gap> IsMaxSeqLFSR(test);
false
gap> K := GF(2);; x := X(K, "x");;test := LFSR(K, x^3 + 1);
< empty LFSR over GF(2)  given by FeedbackPoly = x^3+Z(2)^0 >
gap> PeriodOfLFSR(test);
warning: the polynomial is reducible !!!
3
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(F, l, tap);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(F, l, 8);
argument tap[1]=8 is out of range 0..3, or not given => im taking S_0 instead!
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(F, l, tap);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> t6 := LFSR(F, l, 8);
argument tap[1]=8 is out of range 0..3, or not given => im taking S_0 instead!
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^4+y+Z(2^4) >
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4 + y^3 + y + Z(2^4);;
gap> test := LFSR(K, f, l);;
gap> PeriodOfLFSR(test);
65535
gap> test  := LFSR (F, x^13+x^12+x^10+x^9+Z(2)^0);;
gap> PeriodOfLFSR(test);
warning: the polynomial is irreducible !!!
8191
gap> K := GF(2);; x := X(K, "x");;
gap> test  := LFSR (K, x^14+x^11+x^10+x^9+x^7+x^5+x^4+x+Z(2)^0);;
gap> PeriodOfLFSR(test);
warning: the polynomial is irreducible !!!
5461
gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR over GF(2)  given by FeedbackPoly = y+Z(2)^0 >
gap> IsMaxSeqLFSR(t1);
true
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> ReciprocalPolynomial(F,l);
Z(2^4)*x^4+x^3+Z(2)^0
gap> IdxNonzeroCoeffs(CoefficientsOfUnivariatePolynomial(l));
[ 1, 2, 5 ]
gap> NrNonzeroCoeffs(CoefficientsOfUnivariatePolynomial(l));
3
