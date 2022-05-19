nod(A,0,A):- !.
nod(A,B,X):- C is A mod B, nod(B,C,X).

read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).
%размещения с повторениями
build_all_razm_p:-
		read_str(A,N),write("ffff"),read(K),b_a_rp(A,K,[]).
		
b_a_rp(A,0,Perm1):-write_str(Perm1),nl,!,fail.
b_a_rp(A,N,Perm):-in_list(A,El),N1 is N-1,b_a_rp(A,N1,[El|Perm]).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

in_list1([El|_],El):-!.
in_list1([_|T],El):-in_list1(T,El).

in_list_exclude([El|T],El,T).
in_list_exclude([H|T],El,[H|Tail]):-in_list_exclude(T,El,Tail).

%все перестановки без повторений
build_all_perm:-
		read_str(A,N),b_a_r(A,[]).

%перестановки без повторений
b_a_r([],Perm1):-write_str(Perm1),nl,!,fail.
b_a_r(A,Perm):-in_list_exlude(A,El,A1),b_a_r(A1,[El|Perm]).

%размещения с повт
k_perms_rep(_, 0, Result, Result) :- !. 
k_perms_rep(List, K, CurList, Result) :- in_list(List, X), K1 is K - 1, k_perms_rep(List, K1, [X|CurList], Result). 
k_perms_rep(List, K, Result) :- k_perms_rep(List, K, [], Result).
k_perms_rep(List, K) :- k_perms_rep(List, K, Perm), write("\t"), write(Perm), nl, fail.

% Размещения по K без повторений
k_perms(_, 0, Result, Result):-!.
k_perms(List, K, CurPerm, Result) :- in_list_exclude(List, X, Tail), K1 is K - 1, k_perms(Tail, K1, [X|CurPerm], Result).
k_perms(List, K, Result) :- k_perms(List, K, [], Result).
k_perms(List, K) :- k_perms(List, K, Perm), write("\t"), write(Perm), nl, fail.

%подмножества
sub_set([],[]).
sub_set([H|Sub_set],[H|Set]):-sub_set(Sub_set,Set).
sub_set(Sub_set,[H|Set]):-sub_set(Sub_set,Set).

% Все сочетания по k без повторений
combs([], _, 0) :- !.
combs([H|Sub_set], [H|SetTail], K) :- K1 is K-1, combs(Sub_set, SetTail, K1).
combs(Sub_set, [_|SetTail], K) :- combs(Sub_set, SetTail, K).
combs(Set, K) :- combs(A, Set, K), write("\t"), write(A), nl, fail.

% Все сочетания по k с повторениями
combs_rep([], _, 0) :- !.
combs_rep([H|Sub_set], [H|SetTail], K):- K1 is K-1, combs_rep(Sub_set, [H|SetTail], K1).
combs_rep(Sub_set, [_|SetTail], K) :- combs_rep(Sub_set, SetTail, K).
combs_rep(Set, K) :- combs_rep(A, Set, K), write("\t"), write(A), nl, fail.

get_by_idx(L,I,El):-get_by_idx(L,I,El,0).
get_by_idx([H|_],K,H,K):-!.
get_by_idx([_|Tail],I,El,Cou):- Cou1 is Cou + 1, get_by_idx(Tail,I,El,Cou1).

%Построить предикат, который выводит на экран все слова длины 6
%над алфавитом [a,b,c,d,e,f], в которых три буквы a, две буквы b.
task:-
	Word=[_,_,_,_,_,_], combs([Ia1,Ia2,Ia3],[0,1,2,3,4,5],3),
	in_list_exlude([0,1,2,3,4,5],Ia1,T),in_list_exlude(T,Ia2,T1), in_list_exlude(T1,Ia3,T2),
	combs([Ib1,Ib2],T2,2), in_list_exlude(T2,Ib1,T3),in_list_exlude(T3,Ib2,[T4]),
	get_by_idx(Word,Ia1,a),get_by_idx(Word,Ia2,a),get_by_idx(Word,Ia3,a),
	get_by_idx(Word,Ib1,b),get_by_idx(Word,Ib2,b),
	in_list([c,d,e,f],L),get_by_idx(Word,T4,L),
	write(Word),nl,fail.

%Построить предикат, который выводит на экран все слова длины 6, в
%которых первые три буквы любые из [a,b,c,d,e] без повторов,
%остальные буквы [v,w,x,y,z] возможно с повторами.

task2:-
	Word=[_,_,_,_,_,_],k_perms([a,b,c,d,e],3,[L1,L2,L3]),
	get_by_idx(Word,0,L1),get_by_idx(Word,1,L2),get_by_idx(Word,2,L3),
	k_perms_rep([v,w,x,y,z], 3,[L4,L5,L6]),
	get_by_idx(Word,3,L4),get_by_idx(Word,4,L5),get_by_idx(Word,5,L6),
	write(Word), nl,fail.


%4 задание 

%С помощью предиката из предыдущих задач построить предикат с
%одним обязательным аргументом – список, который выводит на экран
%все сочетания взаимно-простых пар чисел.
vz_prost(A,B):-nod(A,B,X), X is 1.
task4(List):-combs([X1,X2],List,2), vz_prost(X1,X2), write("pair: "), write(X1), write("\t"), write(X2), nl,fail.

%С помощью предиката из предыдущих задач построить предикат с
%одним обязательным аргументом – список, который выводит на экран
%все размещения по k элементов, которые содержат только элементы
%последовательности Фибоначчи в возрастающем порядке.

fibDown(N,X):-fibDown(N,1,0,X).
fibDown(1,Result,_,Result):-!.
fibDown(N,X1,X2,Result):-X is X1+X2, N1 is N-1,
    fibDown(N1,X,X1,Result).

ff([H]):-fibDown(_,H),!.
ff([H,H1|Tail]):-H<H1,fibDown(_,H), fibDown(_,H1),ff([H1|Tail]). 
%[1,4,3,5,6,2,2,8]
%[1,2,3,5] -- [5,13] - 
task42(List):-razm(List,Perm), ff(Perm).

%%%ГРАФЫЫЫЫЫ
append1([],X,X):-!.
append1([H|T],X,[H |Z]):-append1(T,X,Z).


lenList([H|T],Res):-lenList([H|T],Res,0).
lenList([],Res,Res):-!.
lenList([_|T], Res,NowRes):-NewRes is NowRes+1, lenList(T,Res,NewRes).

razm(List,ResL):-lenList(List,Len),razm(List,Len,1,[],ResL).
razm(_,Len,Len1,Res,Res):-Len1 is Len +1,!.
razm(List,Len,K,[P|LL],Res):-K1 is K+1,not(k_perms(List, K,P)),razm(List,Len,K1,[P|LL],Res).

get_graph_edges(V,E):-get_V(V),write(V),nl,write("Edges"),get_edges(V,E),write(E).
	
	get_V(V):-read(N),write("Vertexes"),nl,N1 is N+1,get_V(V1,N1),del_1st(V1,V).
	get_V([],0):-!.
	get_V([H|T],N):-read_str(X),name(H,X),N1 is N-1,get_V(T,N1).

	get_edges(V,E):-read(M),get0(X),get_edges(V,E,[],M,0).
	get_edges(V,E,E,M,M):-!.
	get_edges(V,E,Edges,M,Count):-get_edge(V,Edge),append(Edges,[Edge],E1),
								Count1 is Count+1,get_edges(V,E,E1,M,Count1).


check_vertex([V1|_],V1):-!.
check_vertex([_|T],V1):-check_vertex(T,V1).

get_edge(V,[V1,V2]):-write("Edge"),nl,read_str(X),name(V1,X),check_vertex(V,V1),
						read_str(Y),name(V2,Y),check_vertex(V,V2).

%V = [1,2,3,4], E = [[1,2],[2,3],[2,4],[1,3],[3,1],[4,1]]
%гамильтонов цикл
gamilton:-get_graph_edges(V,E),gamilton(V,E).
gamilton(V,E):-b_a_r(V,W,Way),write("razm"), write(Way),way_check_o(Way,E),write(Way).
%для ориентированного
way_check_o([H|T],E):-append1([H|T],[H],Way),w_c_o(Way,E).
w_c_o([_],_):-!.
w_c_o([V1,V2|T],E):-in_list1(E,[V1,V2]),w_c_o([V2|T],E).
%для неор
way_check_n([H|T],E):-append1([H|T],[H],Way),w_c_n(Way,E).
w_c_n([_],_):-!.
w_c_n([V1,V2|T],E):-in_list1(E,[V1,V2]),in_list1(E,[V2,V1]),w_c_n([V2|T],E).


%gamilton2(V,E):-