gap> K := GF(2);;  y := X(K, "y");; B := Basis(K);;
gap> l := y^3 + y + 1;;
gap> t1 :=  LFSR(K, l);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(B,t1);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with feedback coeff =[ [ 0 ], [ 1 ], [ 1 ] ]
with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
after initialization
with output from stage S_0
gap> F := FieldExtension(K, f);;B := Basis(F);;
gap> t3 := LFSR(F, l);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(B,t3);
Empty LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0 given by CharPoly = y^3+y+Z(2)^0
with feedback coeff =[ [ 0, 0, 0, 0 ], [ 1, 0, 0, 0 ], [ 1, 0, 0, 0 ] ]
with initial state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
with current state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
after initialization
with output from stage S_0
gap> K := GF(2);; y := X(K, "y");; tap := 0;;
gap> l := y^3 + y + 1;; B := Basis(K);;
gap> t5 :=  LFSR(K, l, tap);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(B,t5);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with feedback coeff =[ [ 0 ], [ 1 ], [ 1 ] ]
with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
after initialization
with output from stage S_0
gap> tap := 2;;
gap> t5 :=  LFSR(K, l, tap);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(B,t5);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with feedback coeff =[ [ 0 ], [ 1 ], [ 1 ] ]
with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
after initialization
with output from stage S_2
gap> tap := 5;;
gap> t5 :=  LFSR(K, l, tap);
argument tap[1]=5 is out of range 0..2, or not given => im taking S_0 instead!
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(B,t5);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with feedback coeff =[ [ 0 ], [ 1 ], [ 1 ] ]
with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
after initialization
with output from stage S_0
gap> tap := [0,2];;
gap> t5 :=  LFSR(K, l, tap);
< empty LFSR given by CharPoly = y^3+y+Z(2)^0>
gap> PrintAll(B,t5);
Empty LFSR over GF(2) given by CharPoly = y^3+y+Z(2)^0
with feedback coeff =[ [ 0 ], [ 1 ], [ 1 ] ]
with initial state  =[ [ 0 ], [ 0 ], [ 0 ] ]
with current state  =[ [ 0 ], [ 0 ], [ 0 ] ]
after initialization
with output from stages S_[ 0, 2 ]
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^4 + x^3 + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l := y^4+ y+ Z(2^4);;
gap> tap := 1;;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(B,t6);
Empty LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0 given by CharPoly = y^4+y+Z(2^4)
with feedback coeff =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]
with initial state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
with current state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
after initialization
with output from stage S_1
gap> tap := [0,2,3];;
gap> t6 := LFSR(K, f, l, tap);
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(B,t6);
Empty LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0 given by CharPoly = y^4+y+Z(2^4)
with feedback coeff =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]
with initial state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
with current state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
after initialization
with output from stages S_[ 0, 2, 3 ]
gap> tap := 9;;
gap> t6 := LFSR(K, f, l, tap);
argument tap[1]=9 is out of range 0..3, or not given => im taking S_0 instead!
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(B,t6);
Empty LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0 given by CharPoly = y^4+y+Z(2^4)
with feedback coeff =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]
with initial state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
with current state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
after initialization
with output from stage S_0
gap> F := FieldExtension(K, f);; B := Basis(F);; tap := 1;;
gap> t7 := LFSR(F, l, tap);
< empty LFSR given by CharPoly = y^4+y+Z(2^4)>
gap> PrintAll(B,t7);
Empty LFSR over GF(2^4) defined by FieldPoly=x^4+x^3+Z(2)^0 given by CharPoly = y^4+y+Z(2^4)
with feedback coeff =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ] ]
with initial state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
with current state  =[ [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ], [ 0, 0, 0, 0 ] ]
after initialization
with output from stage S_1