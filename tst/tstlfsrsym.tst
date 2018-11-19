gap> K :=  GF(2);; x:= X(K, "x");;
gap> test1 := LFSR(K, x^7+x+1);;
gap> ist := [x_6, x_5, x_4, x_3, x_2, x_1, x_0];;
gap> LoadFSR(test1,ist);      
x_0
gap> Print(test1);        
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ x_6, x_5, x_4, x_3, x_2, x_1, x_0 ]
after  0 steps
gap> StepFSR(test1);   
x_1
gap> Print(test1);  
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ x_0+x_1, x_6, x_5, x_4, x_3, x_2, x_1 ]
after  1 steps
gap> StepFSR(test1);
x_2
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> Print(test1);   
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ x_0+x_1+x_6, x_5+x_6, x_4+x_5, x_3+x_4, x_2+x_3, x_1+x_2, x_0+x_1 ]
after  7 steps
gap> seq:=  RunFSR(test1,ist,10);; Print(test1);
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ x_2+x_4, x_1+x_3, x_0+x_2, x_0+x_1+x_6, x_5+x_6, x_4+x_5, x_3+x_4 ]
after  10 steps
gap> seq;
[ x_0, x_1, x_2, x_3, x_4, x_5, x_6, x_0+x_1, x_1+x_2, x_2+x_3, x_3+x_4 ]
gap> x := X(K, "x");; f := x^4 + x^3 + 1;;
gap> F := FieldExtension(K, f);;B := Basis(F);;
gap> y := X(F, "y");; l := y^3 + y + 1;;
gap> test2 := LFSR(F, l);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> ist := [x_2, x_1, x_0];;                  
gap> LoadFSR(test2, ist);                      
x_0
gap> seq:=  RunFSR(test2,ist,10);; Print(test2);   
LFSR over GF(2^4) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with current state =[ x_0+x_1+x_2, x_1+x_2, x_0+x_1 ]
after  10 steps
gap> seq;                                          
[ x_0, x_1, x_2, x_0+x_1, x_1+x_2, x_0+x_1+x_2, x_0+x_2, x_0, x_1, x_2, x_0+x_1 ]
