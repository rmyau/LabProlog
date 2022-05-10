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

