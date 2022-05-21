prost(X):-X1 is X-1, prost(X,X1).
prost(_,1):- !.
prost(X,D) :- 0 is X mod D,!, fail.
prost(X,D):- D1 is D-1, prost(X,D1).

%11 сумма простых делителей
%11.1 рекурсия вверх
sumDelUp(X,Sum):-sumDelUp(X,X,Sum),!.
sumDelUp(_,0,0):-!.
sumDelUp(X,Del,Sum):-D1 is Del-1, sumDelUp(X,D1,NewSum),
    (0 is X mod Del,prost(Del), Sum is NewSum+Del; Sum is NewSum).

%11.2 рекурсия вниз
sumDelDown(X,Sum):-sumDelDown(X,X,Sum,0),!.
sumDelDown(_,0,Sum,Sum):-!.
sumDelDown(X,Del,Sum,CurSum):-
    (0 is X mod Del,prost(Del), NewSum is CurSum+Del; NewSum is CurSum),
    D1 is Del-1, sumDelDown(X,D1,Sum,NewSum).

% 12 найти произведение таких делителей числа, сумма цифр которых
% меньше,чем сумма цифр исходного числа

%сумма цифр
sumCifr(X,Sum):- sumCifrDown(X,Sum,0).
sumCifrDown(0,Res,Res):-!.
sumCifrDown(X,Sum,CurSum):- X1 is X mod 10, NowSum is CurSum+X1,
    X2 is X div 10, sumCifrDown(X2,Sum,NowSum).

multDel(X,Res):- multDel(X,X,Res,1),!.
multDel(_,0,Res,Res):-!.
multDel(X,Del,Res,CurMult):-
    (0 is X mod Del,sumCifr(Del,Y),sumCifr(X,Z),Y<Z,
    NewMult is CurMult*Del; NewMult is CurMult),D1 is Del-1,
    multDel(X,D1,Res,NewMult).

%13Найти количество всех пар дружных чисел до 10000
sumDel(X,Sum):-X1 is X-1,sumDel(X,X1,Sum,0),!.
sumDel(_,0,Sum,Sum):-!.
sumDel(X,Del,Sum,CurSum):-
    (0 is X mod Del, NewSum is CurSum+Del; NewSum is CurSum),
     D1 is Del-1, sumDel(X,D1,Sum,NewSum).

countFriend(Res):-countFriend(1000,1000,Res,0).
countFriend(0,0,Res,Res):-!.
countFriend(X,0,Res,NowRes):-write(X),nl,X1 is X-1,countFriend(X1,X1,Res,NowRes).
countFriend(X,Y,Res,NowRes):-Y1 is Y-1, sumDel(X,DelX),sumDel(Y,DelY),
    (X is Y ,NewRes is NowRes,!;(DelX is Y,DelY is X, NewRes is NowRes+1;NewRes is NowRes)), countFriend(X,Y1,Res,NewRes).

countFriend2(Res):- countFriend2(10000,Res,0).
countFriend2(0,Res,R):-Res is R div 2.
countFriend2(X,Res,Count):-sumDel(X,Sum), X1 is X-1,
    (not(Sum is X),Sum<10000,Y is Sum,sumDel(Y,Sum2),X is Sum2,write(X),write(" "), write(Sum), nl,C1 is Count+1,!;C1 is Count),
    countFriend2(X1,Res,C1).   
%14 Найти длину списка
lenList([H|T],Res):-lenList([H|T],Res,0).
lenList([],Res,Res):-!.
lenList([_|T], Res,NowRes):-NewRes is NowRes+1, 
    lenList(T,Res,NewRes).


readList(0, []) :- !.
readList(I, [X|T]) :- write("input - "),read(X), I1 is I - 1, readList(I1, T).

write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).
%15.1 количество элементов после последнего максимального

%поиск индекса последнего максимального
indMax([H|T], Ind):-indMax(T,Ind,0,1,H).
indMax([],Ind,Ind,_,_):-!.
indMax([H|T],Ind,IndMax,NowInd,MaxEl):-
    (H>=MaxEl, NewIndMax is NowInd,NewMax is H,!;
    NewIndMax is IndMax,NewMax is MaxEl),
    NewNowInd is NowInd+1,
    indMax(T,Ind,NewIndMax,NewNowInd,NewMax). 

task15:-write("Input lenght of list: "), read(Count),readList(Count,List),
    write("Number of elements after max: "),
    lenList(List,Len),indMax(List,IndMax),
    X is Len-IndMax-1, write(X),!.

%16.2 найти индекс минимального элемента
indMin([H|T],Ind):-indMin(T,Ind,0,1,H).
indMin([],Ind,Ind,_,_):-!.
indMin([H|T],Ind,IndMin,NowInd,MinEl):-
    (H<MinEl, NewIndMin is NowInd, NewMin is H,!;
    NewIndMin is IndMin, NewMin is MinEl),
    NewNowInd is NowInd+1,
    indMin(T,Ind,NewIndMin,NewNowInd,NewMin).
task16:-write("Input lenght of list: "), read(Count),readList(Count,List),
    write("Index of min: "),indMin(List,Ind), write(Ind),!.

%17.13 разместить элементы до минимального в конце массива

%объединение списков
concat([], List2, List2).
concat([H|T], List2, [H|NewList]) :- concat(T, List2, NewList).
%List - итоговый список
moveBeforeMin([H|T],List):-indMin([H|T],IndMin),
    moveBeforeMin([H|T],List,IndMin,0,[]).
moveBeforeMin(L1,List,IndMin,IndMin,L2):- concat(L1,L2,List),!.
moveBeforeMin([H|T],List,IndMin,IndNow,NowList):- NewInd is IndNow+1, concat(NowList,[H],NewList),
    moveBeforeMin(T,List,IndMin,NewInd,NewList).

task17:- write("Input lenght of list: "), read(Count),readList(Count,List),moveBeforeMin(List,NewList),
    write("New List: "),write_list(NewList),!.

%18.15 даны индекс и массив. Определить, является ли
%элемент по указанному индексу локальным минимум
isLocalMin([F,S|_],0):-F<S,!.
isLocalMin([F,S|T],Ind):-localMin(F,S,T,Ind,1).
localMin(F,S,[],Ind,Ind):-S<F,!.
localMin(F,S,[Next|_],Ind,Ind):-S<F,S<Next,!.
localMin(_,S,[Next|Tail],Ind,IndNow):-NextInd is IndNow+1,
    localMin(S,Next,Tail,Ind,NextInd).
    
task18:-write("Input lenght of list: "), read(Count),readList(Count,List),
    write("Input index less then lenght: "),read(Index),
    write("This element is local min - "), isLocalMin(List,Index).

%19.25 дан массив и интервал a..b, найти макс из эл в этом интервале
maxInterval([H|T],(A,B),Res):-(H>A,H<B, maxInterval(T,(A,B),H,Res),!;maxInterval(T,(A,B),Res)).
maxInterval([],_,Max,Max):-!.
maxInterval([H|T],(A,B),Max,Res):-(H>Max,H<B,H>A,NewMax is H; NewMax is Max),
    maxInterval(T,(A,B),NewMax,Res).

task19:-write("Input lenght of list: "), read(Count),readList(Count,List),
    write("Input a: "),read(A),write("Input b: "),read(B),
    maxInterval(List,(A,B),Res),
    write("Max element in (a,b) is "), write(Res),!.

%20.28 найти элементы между первым и последним максимальным
%находит индексы для максимального элемента
indMaxPair([H|T],(IF,IL)):-indMaxPair(T,(IF,IL),(0,0),H,1).
indMaxPair([],(IF,IL),(IF,IL),_,_):-!.
indMaxPair([H|T],(First,Last),(I1,I2),El,IndNow):-
    (H>El,IF is IndNow,IL is IndNow,NewEl is H;
    H is El, IL is IndNow, IF is I1,NewEl is H;
    IF is I1, IL is I2,NewEl is El),
    NextInd is IndNow+1,
    indMaxPair(T,(First,Last),(IF,IL),NewEl,NextInd).
%List2 - искомые элементы
findBetwMax(List,List2):-indMaxPair(List,(I1,I2)),findBetwMax(List,(I1,I2),List2,0,[]),!.
findBetwMax(_,(_,I2),List2,I2,List2):-!.
findBetwMax([H|T],(I1,I2),List2,NowInd,NowList):- 
    NewInd is NowInd+1,
    (NowInd>I1,concat(NowList,[H],Res),findBetwMax(T,(I1,I2),List2,NewInd,Res);
    findBetwMax(T,(I1,I2),List2,NewInd,NowList)).

task20:-write("Input lenght of list: "), read(Count),readList(Count,List),
    write("Elements between max: "), findBetwMax(List,X),nl, write_list(X).    