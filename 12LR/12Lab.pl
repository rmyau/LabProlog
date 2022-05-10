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