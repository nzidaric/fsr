gap> F := GF(2);; clist := [One(F), One(F)];; mlist := [x_0*x_1, x_2];;
gap> fil := FILFUN(F, clist, mlist);;   
gap> ist := [s_2,s_1,s_0];; 
gap> RunFSR(fil, ist);
[ s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, 
  s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0, s_1*s_2+s_0 ]
gap> K := GF(2);; x:= X(K, "x");; 
gap> h := x_1+x_4+x_0*x_3+x_2*x_3+x_3*x_4+x_0*x_1*x_2+x_0*x_2*x_3+x_0*x_2*x_4+x_1*x_2*x_4+x_2*x_3*x_4;;
gap> Hfil := FILFUN(K, h);;
gap> ist := [s_0, s_1,s_2,s_3,s_4];;
gap>  LoadStepFSR(Hfil, ist);
s_0*s_1*s_2+s_0*s_2*s_3+s_0*s_2*s_4+s_1*s_2*s_4+s_2*s_3*s_4+s_0*s_3+s_2*s_3+s_3*s_4+s_1+s_4
gap>  LoadStepFSR(Hfil, ist, s_10);
s_0*s_1*s_2+s_0*s_2*s_3+s_0*s_2*s_4+s_1*s_2*s_4+s_2*s_3*s_4+s_0*s_3+s_2*s_3+s_3*s_4+s_1+s_4+s_10
