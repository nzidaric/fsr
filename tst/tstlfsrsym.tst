gap> K := GF(2);;  y := X(K, "y");;  l := y^3 + y + 1;;
gap> test :=  LFSR(K, l);
< empty LFSR over GF(2)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> ist := [One(K), One(K), One(K)];; LoadFSR(test,ist);
Z(2)^0
gap> SymbolicFSR(test);
false
gap> ist := [s_2, s_1, s_0];; LoadFSR(test,ist);
s_0
gap> SymbolicFSR(test);
true
gap> K :=  GF(2);; x:= X(K, "x");;
gap> test1 := LFSR(K, x^7+x+1);;
gap> ist := [s_6, s_5, s_4, s_3, s_2, s_1, s_0];;
gap> LoadFSR(test1,ist);
s_0
gap> Print(test1);
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ s_6, s_5, s_4, s_3, s_2, s_1, s_0 ]
after  0 steps
gap> StepFSR(test1);
s_1
gap> Print(test1);
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ s_0+s_1, s_6, s_5, s_4, s_3, s_2, s_1 ]
after  1 steps
gap> StepFSR(test1);
s_2
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> StepFSR(test1);;
gap> Print(test1);
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ s_0+s_1+s_6, s_5+s_6, s_4+s_5, s_3+s_4, s_2+s_3, s_1+s_2, s_0+s_1 ]
after  7 steps
gap> seq:=  RunFSR(test1,ist,10);; Print(test1);
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ s_2+s_4, s_1+s_3, s_0+s_2, s_0+s_1+s_6, s_5+s_6, s_4+s_5, s_3+s_4 ]
after  10 steps
gap> seq;
[ s_0, s_1, s_2, s_3, s_4, s_5, s_6, s_0+s_1, s_1+s_2, s_2+s_3, s_3+s_4 ]
gap> x := X(K, "x");; f := x^4 + x^3 + 1;;
gap> F := FieldExtension(K, f);;B := Basis(F);;
gap> y := X(F, "y");; l := y^3 + y + 1;;
gap> test2 := LFSR(F, l);
< empty LFSR over GF(2^4)  given by FeedbackPoly = y^3+y+Z(2)^0 >
gap> ist := [s_2, s_1, s_0];;
gap> LoadFSR(test2, ist);
s_0
gap> seq:=  RunFSR(test2,ist,10);; Print(test2);
LFSR over GF(2^4) given by FeedbackPoly = y^3+y+Z(2)^0
with basis =[ Z(2)^0, Z(2^4)^7, Z(2^4)^14, Z(2^4)^6 ]
with current state =[ s_0+s_1+s_2, s_1+s_2, s_0+s_1 ]
after  10 steps
gap> seq;
[ s_0, s_1, s_2, s_0+s_1, s_1+s_2, s_0+s_1+s_2, s_0+s_2, s_0, s_1, s_2, s_0+s_1 ]
gap> K := GF(2);; x := X(K, "x");;
gap> f := x^2 + x + 1;; F := FieldExtension(K, f);; B := Basis(F);;
gap> y := X(F, "y");; l :=  y^4+y^3+y+Z(2^2) ;;
gap> t10 := LFSR(K, f, l);
< empty LFSR over GF(2^2)  given by FeedbackPoly = y^4+y^3+y+Z(2^2) >
gap> ist :=[s_3, s_2, s_1, s_0 ];; len := Period(t10);;
gap> seq := RunFSR(t10,ist, 2*len);;
gap> for i in [1.. len] do Print(i,": ",seq[i]," -> ",seq[i]=seq[i+len],"\n"); od;
1: s_0 -> true
2: s_1 -> true
3: s_2 -> true
4: s_3 -> true
5: Z(2^2)*s_0+s_1+s_3 -> true
6: Z(2^2)*s_0+Z(2^2)^2*s_1+s_2+s_3 -> true
7: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2 -> true
8: Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
9: s_0+Z(2^2)^2*s_1+Z(2^2)*s_2 -> true
10: s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
11: Z(2^2)^2*s_0+Z(2^2)*s_1+s_2+s_3 -> true
12: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)*s_2 -> true
13: Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
14: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)*s_2 -> true
15: Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
16: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2 -> true
17: Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
18: s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+s_3 -> true
19: Z(2^2)*s_0+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
20: Z(2^2)^2*s_0+s_3 -> true
21: Z(2^2)*s_0+Z(2^2)*s_1+s_3 -> true
22: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+s_3 -> true
23: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
24: s_0+s_1+Z(2^2)^2*s_2 -> true
25: s_1+s_2+Z(2^2)^2*s_3 -> true
26: s_0+Z(2^2)^2*s_1+s_2+Z(2^2)*s_3 -> true
27: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
28: s_0+Z(2^2)^2*s_2 -> true
29: s_1+Z(2^2)^2*s_3 -> true
30: s_0+Z(2^2)^2*s_1+s_2+Z(2^2)^2*s_3 -> true
31: s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
32: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+s_3 -> true
33: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
34: s_0+s_1+Z(2^2)*s_2 -> true
35: s_1+s_2+Z(2^2)*s_3 -> true
36: Z(2^2)^2*s_0+Z(2^2)*s_1+s_2+Z(2^2)^2*s_3 -> true
37: s_0+Z(2^2)*s_2+Z(2^2)*s_3 -> true
38: Z(2^2)^2*s_0+Z(2^2)^2*s_1 -> true
39: Z(2^2)^2*s_1+Z(2^2)^2*s_2 -> true
40: Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
41: s_0+Z(2^2)^2*s_1 -> true
42: s_1+Z(2^2)^2*s_2 -> true
43: s_2+Z(2^2)^2*s_3 -> true
44: s_0+Z(2^2)^2*s_1+Z(2^2)*s_3 -> true
45: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
46: Z(2^2)^2*s_0+s_1+Z(2^2)^2*s_2+s_3 -> true
47: Z(2^2)*s_0+Z(2^2)*s_1+s_2+Z(2^2)*s_3 -> true
48: Z(2^2)^2*s_0+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
49: s_0+s_3 -> true
50: Z(2^2)*s_0+s_3 -> true
51: Z(2^2)*s_0+Z(2^2)^2*s_1+s_3 -> true
52: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+s_3 -> true
53: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
54: Z(2^2)^2*s_0+Z(2^2)^2*s_2+s_3 -> true
55: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)*s_3 -> true
56: Z(2^2)^2*s_0+Z(2^2)*s_2+Z(2^2)*s_3 -> true
57: Z(2^2)^2*s_0+s_1 -> true
58: Z(2^2)^2*s_1+s_2 -> true
59: Z(2^2)^2*s_2+s_3 -> true
60: Z(2^2)*s_0+s_1+Z(2^2)*s_3 -> true
61: Z(2^2)^2*s_0+s_2+Z(2^2)*s_3 -> true
62: Z(2^2)^2*s_0+s_1+Z(2^2)^2*s_3 -> true
63: s_0+s_2+Z(2^2)^2*s_3 -> true
64: s_0+Z(2^2)*s_1+Z(2^2)*s_3 -> true
65: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
66: Z(2^2)^2*s_0+s_1+Z(2^2)^2*s_2 -> true
67: Z(2^2)^2*s_1+s_2+Z(2^2)^2*s_3 -> true
68: s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
69: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+s_3 -> true
70: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
71: Z(2^2)^2*s_0+Z(2^2)*s_2+s_3 -> true
72: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)^2*s_3 -> true
73: s_0+s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
74: s_0+Z(2^2)*s_1+s_2+s_3 -> true
75: Z(2^2)*s_0+Z(2^2)*s_2 -> true
76: Z(2^2)*s_1+Z(2^2)*s_3 -> true
77: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
78: Z(2^2)^2*s_0+s_1+Z(2^2)*s_2 -> true
79: Z(2^2)^2*s_1+s_2+Z(2^2)*s_3 -> true
80: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
81: s_0+Z(2^2)*s_2 -> true
82: s_1+Z(2^2)*s_3 -> true
83: Z(2^2)^2*s_0+Z(2^2)*s_1+s_2+Z(2^2)*s_3 -> true
84: Z(2^2)^2*s_0+s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
85: s_0+s_2+s_3 -> true
86: Z(2^2)*s_0 -> true
87: Z(2^2)*s_1 -> true
88: Z(2^2)*s_2 -> true
89: Z(2^2)*s_3 -> true
90: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)*s_3 -> true
91: Z(2^2)^2*s_0+s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
92: Z(2^2)^2*s_0+s_1+s_2 -> true
93: Z(2^2)^2*s_1+s_2+s_3 -> true
94: Z(2^2)*s_0+s_1+Z(2^2)^2*s_2 -> true
95: Z(2^2)*s_1+s_2+Z(2^2)^2*s_3 -> true
96: s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
97: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2 -> true
98: Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
99: s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2 -> true
100: s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
101: s_0+Z(2^2)^2*s_1+s_2 -> true
102: s_1+Z(2^2)^2*s_2+s_3 -> true
103: Z(2^2)*s_0+s_1+s_2+Z(2^2)*s_3 -> true
104: Z(2^2)^2*s_0+s_2+Z(2^2)^2*s_3 -> true
105: s_0+Z(2^2)*s_3 -> true
106: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)*s_3 -> true
107: Z(2^2)^2*s_0+s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
108: Z(2^2)^2*s_0+s_1+s_2+s_3 -> true
109: Z(2^2)*s_0+Z(2^2)*s_1+s_2 -> true
110: Z(2^2)*s_1+Z(2^2)*s_2+s_3 -> true
111: Z(2^2)*s_0+s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
112: s_0+s_1+s_2+s_3 -> true
113: Z(2^2)*s_0+s_2 -> true
114: Z(2^2)*s_1+s_3 -> true
115: Z(2^2)*s_0+s_1+Z(2^2)*s_2+s_3 -> true
116: Z(2^2)*s_0+Z(2^2)^2*s_1+s_2+Z(2^2)^2*s_3 -> true
117: s_0+s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
118: Z(2^2)^2*s_0+Z(2^2)^2*s_1+s_2+s_3 -> true
119: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2 -> true
120: Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
121: s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+s_3 -> true
122: Z(2^2)*s_0+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
123: s_0+s_1 -> true
124: s_1+s_2 -> true
125: s_2+s_3 -> true
126: Z(2^2)*s_0+s_1 -> true
127: Z(2^2)*s_1+s_2 -> true
128: Z(2^2)*s_2+s_3 -> true
129: Z(2^2)*s_0+s_1+Z(2^2)^2*s_3 -> true
130: s_0+s_1+s_2+Z(2^2)^2*s_3 -> true
131: s_0+Z(2^2)*s_1+s_2+Z(2^2)*s_3 -> true
132: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
133: s_0+Z(2^2)^2*s_2+s_3 -> true
134: Z(2^2)*s_0+Z(2^2)*s_3 -> true
135: Z(2^2)^2*s_0+Z(2^2)*s_3 -> true
136: Z(2^2)^2*s_0+s_1+Z(2^2)*s_3 -> true
137: Z(2^2)^2*s_0+s_1+s_2+Z(2^2)*s_3 -> true
138: Z(2^2)^2*s_0+s_1+s_2+Z(2^2)^2*s_3 -> true
139: s_0+s_2+Z(2^2)*s_3 -> true
140: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_3 -> true
141: s_0+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
142: s_0+Z(2^2)*s_1 -> true
143: s_1+Z(2^2)*s_2 -> true
144: s_2+Z(2^2)*s_3 -> true
145: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)^2*s_3 -> true
146: s_0+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
147: s_0+Z(2^2)*s_1+s_3 -> true
148: Z(2^2)*s_0+Z(2^2)*s_2+s_3 -> true
149: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_3 -> true
150: s_0+s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
151: s_0+Z(2^2)*s_1+s_2 -> true
152: s_1+Z(2^2)*s_2+s_3 -> true
153: Z(2^2)*s_0+s_1+s_2+Z(2^2)^2*s_3 -> true
154: s_0+s_1+s_2+Z(2^2)*s_3 -> true
155: Z(2^2)^2*s_0+Z(2^2)^2*s_1+s_2+Z(2^2)^2*s_3 -> true
156: s_0+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
157: Z(2^2)^2*s_0+Z(2^2)^2*s_1+s_3 -> true
158: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+s_3 -> true
159: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
160: Z(2^2)^2*s_0+Z(2^2)^2*s_2 -> true
161: Z(2^2)^2*s_1+Z(2^2)^2*s_3 -> true
162: s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
163: s_0+Z(2^2)*s_1+Z(2^2)^2*s_2 -> true
164: s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
165: s_0+Z(2^2)^2*s_1+s_2+s_3 -> true
166: Z(2^2)*s_0+Z(2^2)^2*s_2 -> true
167: Z(2^2)*s_1+Z(2^2)^2*s_3 -> true
168: s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
169: s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+s_3 -> true
170: Z(2^2)*s_0+Z(2^2)*s_2+Z(2^2)*s_3 -> true
171: Z(2^2)^2*s_0 -> true
172: Z(2^2)^2*s_1 -> true
173: Z(2^2)^2*s_2 -> true
174: Z(2^2)^2*s_3 -> true
175: s_0+Z(2^2)^2*s_1+Z(2^2)^2*s_3 -> true
176: s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
177: s_0+Z(2^2)*s_1+Z(2^2)*s_2 -> true
178: s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
179: Z(2^2)^2*s_0+Z(2^2)*s_1+s_2 -> true
180: Z(2^2)^2*s_1+Z(2^2)*s_2+s_3 -> true
181: Z(2^2)*s_0+s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
182: s_0+s_1+s_2 -> true
183: s_1+s_2+s_3 -> true
184: Z(2^2)*s_0+s_1+s_2 -> true
185: Z(2^2)*s_1+s_2+s_3 -> true
186: Z(2^2)*s_0+s_1+Z(2^2)*s_2 -> true
187: Z(2^2)*s_1+s_2+Z(2^2)*s_3 -> true
188: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
189: s_0+Z(2^2)*s_2+s_3 -> true
190: Z(2^2)*s_0+Z(2^2)^2*s_3 -> true
191: s_0+s_1+Z(2^2)^2*s_3 -> true
192: s_0+Z(2^2)*s_1+s_2+Z(2^2)^2*s_3 -> true
193: s_0+Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
194: Z(2^2)^2*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2 -> true
195: Z(2^2)^2*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
196: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+s_3 -> true
197: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
198: Z(2^2)^2*s_0+Z(2^2)*s_2 -> true
199: Z(2^2)^2*s_1+Z(2^2)*s_3 -> true
200: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
201: Z(2^2)^2*s_0+s_1+Z(2^2)*s_2+s_3 -> true
202: Z(2^2)*s_0+Z(2^2)*s_1+s_2+Z(2^2)^2*s_3 -> true
203: s_0+s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
204: Z(2^2)^2*s_0+Z(2^2)^2*s_1+s_2 -> true
205: Z(2^2)^2*s_1+Z(2^2)^2*s_2+s_3 -> true
206: Z(2^2)*s_0+s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
207: Z(2^2)^2*s_0+s_2+s_3 -> true
208: Z(2^2)*s_0+Z(2^2)*s_1 -> true
209: Z(2^2)*s_1+Z(2^2)*s_2 -> true
210: Z(2^2)*s_2+Z(2^2)*s_3 -> true
211: Z(2^2)^2*s_0+Z(2^2)*s_1 -> true
212: Z(2^2)^2*s_1+Z(2^2)*s_2 -> true
213: Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
214: Z(2^2)^2*s_0+Z(2^2)*s_1+s_3 -> true
215: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)*s_2+s_3 -> true
216: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
217: s_0+s_1+Z(2^2)^2*s_2+s_3 -> true
218: Z(2^2)*s_0+s_2+Z(2^2)*s_3 -> true
219: Z(2^2)^2*s_0+Z(2^2)^2*s_3 -> true
220: s_0+Z(2^2)^2*s_3 -> true
221: s_0+Z(2^2)*s_1+Z(2^2)^2*s_3 -> true
222: s_0+Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
223: s_0+Z(2^2)*s_1+Z(2^2)*s_2+s_3 -> true
224: Z(2^2)*s_0+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
225: s_0+s_1+s_3 -> true
226: Z(2^2)*s_0+s_2+s_3 -> true
227: Z(2^2)*s_0+Z(2^2)^2*s_1 -> true
228: Z(2^2)*s_1+Z(2^2)^2*s_2 -> true
229: Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
230: s_0+Z(2^2)^2*s_1+s_3 -> true
231: Z(2^2)*s_0+Z(2^2)^2*s_2+s_3 -> true
232: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)*s_3 -> true
233: Z(2^2)^2*s_0+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
234: Z(2^2)^2*s_0+s_1+s_3 -> true
235: Z(2^2)*s_0+Z(2^2)*s_1+s_2+s_3 -> true
236: Z(2^2)*s_0+Z(2^2)^2*s_1+Z(2^2)*s_2 -> true
237: Z(2^2)*s_1+Z(2^2)^2*s_2+Z(2^2)*s_3 -> true
238: Z(2^2)^2*s_0+Z(2^2)*s_1+Z(2^2)*s_2+s_3 -> true
239: Z(2^2)*s_0+Z(2^2)*s_1+Z(2^2)*s_2+Z(2^2)^2*s_3 -> true
240: s_0+s_1+Z(2^2)*s_2+s_3 -> true
241: Z(2^2)*s_0+s_2+Z(2^2)^2*s_3 -> true
242: s_0+s_1+Z(2^2)*s_3 -> true
243: Z(2^2)^2*s_0+Z(2^2)^2*s_1+s_2+Z(2^2)*s_3 -> true
244: Z(2^2)^2*s_0+s_1+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
245: s_0+s_2 -> true
246: s_1+s_3 -> true
247: Z(2^2)*s_0+s_1+s_2+s_3 -> true
248: Z(2^2)*s_0+Z(2^2)^2*s_1+s_2 -> true
249: Z(2^2)*s_1+Z(2^2)^2*s_2+s_3 -> true
250: Z(2^2)*s_0+s_1+Z(2^2)*s_2+Z(2^2)*s_3 -> true
251: Z(2^2)^2*s_0+s_2 -> true
252: Z(2^2)^2*s_1+s_3 -> true
253: Z(2^2)*s_0+s_1+Z(2^2)^2*s_2+s_3 -> true
254: Z(2^2)*s_0+Z(2^2)^2*s_1+s_2+Z(2^2)*s_3 -> true
255: Z(2^2)^2*s_0+Z(2^2)^2*s_2+Z(2^2)^2*s_3 -> true
gap> flag := true;; for i in [1.. len] do if seq[i]<>seq[i+len] then flag := false; fi; od;
gap> Print(flag);
true
gap> K :=  GF(2);; x:= X(K, "x");;
gap> test1 := LFSR(K, x^7+x+1);;
gap> ist := [s_6, s_5, s_4, s_3, s_2, s_1, s_0];;
gap> LoadFSR(test1,ist);; StepFSR(test1,s_10);
s_1
gap> Print(test1);
LFSR over GF(2) given by FeedbackPoly = x^7+x+Z(2)^0
with basis =[ Z(2)^0 ]
with current state =[ s_0+s_1+s_10, s_6, s_5, s_4, s_3, s_2, s_1 ]
after  1 steps
