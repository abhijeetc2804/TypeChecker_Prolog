:- use_module(library(lists)).

%Helper function
is_List([]).
is_List([X|R]):-is_List(R).

% Define the Base Cases of hastype relation
hastype(G, N, intT) :- integer(N).
hastype(G, X, boolT):-X=true;X=false.
hastype(G, F, floatT):- float(F).
hastype(G, L, listT):- is_List(L).

hastype(G,varT(V),T):-member((V,T), G).

% Operations of intT
hastype(G,add(E1,E2), intT) :- hastype(G, E1, intT), hastype(G, E2, intT).
hastype(G,mul(E1,E2), intT) :- hastype(G, E1, intT), hastype(G, E2, intT).


%Testcases for intT
%hastype([],add(5,mul(7,2)),intT).						True
%hastype([],mul(5,7.0),intT).							False
%hastype([],mul(5,add(varT(x),mul(152,varT(y)))),intT).	False
%hastype([(x,intT),(y,intT)],mul(5,add(varT(x),mul(152,varT(y)))),intT).	True
%hastype(G,mul(5,add(varT(x),mul(152,varT(y)))),intT).G = [(x,intT),(y,intT)|__1150]



% Operations of floatT
hastype(G,add(E1,E2), floatT) :- hastype(G, E1, floatT), hastype(G, E2, floatT).
hastype(G,mul(E1,E2), floatT) :- hastype(G, E1, floatT), hastype(G, E2, floatT).
/*
hastype([],add(5.2,mul(7.4,2.0)),floatT).						True
hastype([],mul(5,7.0),floatT).							False
hastype([],mul(5.0,add(varT(x),mul(152.0,varT(y)))),floatT).	False
hastype([(x,floatT),(y,floatT)],add(varT(x),mul(152.9,varT(y))),floatT).	True
hastype(G,mul(5.1,add(varT(x),mul(152.0,varT(y)))),floatT).		G = [(x,floatT),(y,floatT)|__1466]

*/


% Operations of boolT
hastype(G,and(E1,E2), boolT) :- hastype(G, E1, boolT), hastype(G, E2, boolT).
hastype(G,or(E1,E2), boolT) :- hastype(G, E1, boolT), hastype(G, E2, boolT).
hastype(G, not(E), boolT) :- hastype(G, E, boolT).
hastype(G, eq(E1,E2), boolT) :- (hastype(G, E1, intT), hastype(G, E2, intT));(hastype(G, E1, floatT), hastype(G, E2, floatT)).
hastype(G, grt(E1,E2), boolT) :- (hastype(G, E1, intT), hastype(G, E2, intT));(hastype(G, E1, floatT), hastype(G, E2, floatT)).
hastype(G, less(E1,E2), boolT) :- (hastype(G, E1, intT), hastype(G, E2, intT));(hastype(G, E1, floatT), hastype(G, E2, floatT)).
/*
hastype([],mul(32.2,71.32),boolT).			False
hastype([],grt(34.245,(-0.5)),boolT).		True
hastype([],true,boolT).					True
hastype([(x,floatT)],eq(5.12,mul(varT(x),8.23)),boolT).		True
hastype([(x,floatT),(y,floatT)],eq(varT(x),varT(y)),boolT).		  	True
*/

% Operations of listT
hastype(G,append(E1,E2), listT) :- hastype(G, E1, listT), hastype(G, E2, listT).
/*
hastype([],append([1,2,3],[2,4,5]),listT).		True
*/


 
