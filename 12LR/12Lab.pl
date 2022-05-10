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
sumDel(X,Sum):-sumDel(X,X,Sum,0),!.
sumDel(_,0,Sum,Sum):-!.
sumDel(X,Del,Sum,CurSum):-
    (0 is X mod Del, NewSum is CurSum+Del; NewSum is CurSum),
     D1 is Del-1, sumDel(X,D1,Sum,NewSum).

countFriend(Res):-countFriend(1000,1000,Res,0).
countFriend(0,0,Res,Res):-!.
countFriend(X,0,Res,NowRes):-X1 is X-1,countFriend(X1,X1,Res,NowRes).
countFriend(X,Y,Res,NowRes):-Y1 is Y-1, sumDel(X,DelX),sumDel(Y,DelY),
    (X is Y ,NewRes is NowRes;(DelX is DelY, NewRes is NowRes+1;NewRes is NowRes)), countFriend(X,Y1,Res,NewRes).

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
    (H>=MaxEl, NewIndMax is NowInd,NewMax is H;
    NewIndMax is IndMax,NewMax is MaxEl),
    NewNowInd is NowInd+1,
    indMax(T,Ind,NewIndMax,NewNowInd,NewMax). 

task15:-write("Input lenght for list: "), read(Count),readList(Count,List),
    write("Number of elements after max: "),
    lenList(List,Len),indMax(List,IndMax),
    X is Len-IndMax-1, write(X),!.

%16.2 найти индекс минимального элемента
indMin([H|T],Ind):-indMin(T,Ind,0,1,H).
indMin([],Ind,Ind,_,_):-!.
indMin([H|T],Ind,IndMin,NowInd,MinEl):-
    (H<MinEl, NewIndMin is NowInd, NewMin is H;
    NewIndMin is IndMin, NewMin is MinEl),
    NewNowInd is NowInd+1,
    indMin(T,Ind,NewIndMin,NewNowInd,NewMin).
task16:-write("Input lenght for list: "), read(Count),readList(Count,List),
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

task17:- write("Input lenght for list: "), read(Count),readList(Count,List),moveBeforeMin(List,NewList),
    write("New List: "),write_list(NewList),!.



