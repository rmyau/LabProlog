readList(0, []) :- !.
readList(I, [X|T]) :- write("input - "),read(X), I1 is I - 1, readList(I1, T).

write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).

concat([], List2, List2).
concat([H|T], List2, [H|NewList]) :- concat(T, List2, NewList).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

unicList(List,List2):- unicList(List,List2,[]).
unicList([],List,List):-!.
unicList([H|T],List2,ListNow) :- in_list(ListNow,H), unicList(T,List2,ListNow),!;
    concat(ListNow,[H],NewList), unicList(T,List2,NewList).

%11.37 вывести индексы элементов, которые меньше своего левого соседа и их количество

lessLeft([H|Tail],Count):-lessLeft(H,Tail,0, Count,1).
lessLeft(_,[],Count,Count,_):-!.
lessLeft(LeftEl,[H|Tail],CountNow,Count, Ind):- 
    (H<LeftEl, NewCount is CountNow+1, write(Ind),nl,!; NewCount is CountNow),
    NextInd is Ind+1, lessLeft(H,Tail,NewCount,Count,NextInd).

task11:-write("Input lenght of list: "), read(Count),readList(Count,List),
    lessLeft(List,X), write("Number of elements that are less than the left: "),write(X), nl.

%12.43 найти количество минимальных элементов 
minEl([H|Tail],Min):- minEl(Tail,H,Min).
minEl([],Min,Min):-!.
minEl([H|Tail],MinNow,Min):- 
    (H<MinNow, NewMin is H,!; NewMin is MinNow),
    minEl(Tail,NewMin,Min).

countMin(List,Count):- minEl(List,Min),countMin(List,Min,0,Count).
countMin([],_,Count,Count):-!.
countMin([H|Tail],Min,CountNow,Count):- 
    (H is Min, CountMin is CountNow+1,!;CountMin is CountNow),
    countMin(Tail,Min,CountMin,Count).

task12:-write("Input lenght of list: "), read(Count),readList(Count,List),
    countMin(List,C),write("Number of min: "), write(C), nl.

%13.59 построить список из квадратов неотрицательных чисел меньших 100,  встречающихся больше 2 раз
numEl(List,El,Count):- numEl(List,El,0,Count).
numEl([],_,Count,Count):-!.
numEl([El|T],El,CNow,Count):- NewCount is CNow +1, numEl(T,El,NewCount,Count),!.
numEl([_|Tail],El,C,Count):- numEl(Tail,El,C,Count).

newList13(List,NewL):-unicList(List,UnicL),newList13(List,UnicL,NewL,[]).
newList13(_,[],List,List):-!.
newList13(List,[H|T],List2,NewList):- 
   H<100, H>0, numEl(List,H,C),C >2, K is H*H, concat(NewList,[K],NextList),newList13(List,T,List2,NextList),!;
   newList13(List,T,List2,NewList).

task13:-write("Input lenght of list: "), read(Count),readList(Count,List),
    newList13(List,NewList), write("New List: "), nl, write_list(NewList).

%14
task14:-
    Color = [_,_,_],
    in_list(Color,[belokurov,_]),
    in_list(Color,[chernov,_]),
    in_list(Color,[ryzhov,_]),
    in_list(Color,[_,blond]),
    in_list(Color,[_,black]),
    in_list(Color,[_,ginger]),
    not(in_list(Color,[belokurov,blond])),
    not(in_list(Color,[chernov,black])),
    not(in_list(Color,[ryzhov,ginger])),
    write(Color),!.

%15 
task15:- 
    Girls = [_,_,_], %Имя, платье, туфли
    in_list(Girls,[anya,_,_]),
    in_list(Girls,[valya,_,_]),
    in_list(Girls,[natasha,_,_]),
    in_list(Girls,[_,white,_]),
    in_list(Girls,[_,blue,_]),
    in_list(Girls,[_,green,_]),
    in_list(Girls,[_,_,white]),
    in_list(Girls,[_,_,blue]),
    in_list(Girls,[_,_,green]),
    in_list(Girls,[anya,Same,Same]),
    not(in_list(Girls,[valya,Same2,Same2])),
    not(in_list(Girls,[natasha,Same3,Same3])),
    not(in_list(Girls,[valya,_,white])),
    not(in_list(Girls,[valya,white,_])),
    in_list(Girls,[natasha,_,green]),
    write(Girls),!.

%16
task16:-
    %Возраст 0 - 1 - 2
    %имя - должность - возраст - братья/сестры                      
    Friends = [_,_,_],
    in_list(Friends,[_,slesar,0,0]),
    in_list(Friends,[_,tokar,1,_]),
    in_list(Friends,[_,svarshik,_,_]),
    in_list(Friends,[borisov,_,_,1]),
    in_list(Friends,[ivanov,_,_,_]),
    in_list(Friends,[semenov,_,2,_]),
    not(in_list(Friends,[semenov,tokar,_,_])),
    in_list(Friends,[Name1,slesar,_,_]),
    in_list(Friends,[Name2,tokar,_,_]),
    in_list(Friends,[Name3,svarshik,_,_]),
    write("result Name:"), nl, write("slesar - "), write(Name1),nl,
    write("tokar  - "), write(Name2), nl,
    write("svarshik - "),write(Name3),!.

%17

between(List,X,Y,Z):-leftInList(List,X,Y),rightInList(List,Z,Y);
    leftInList(List,Z,Y),rightInList(List,X,Y).
 
%X слева от Y
leftInList([_],_,_):-fail.
leftInList([X,Y|_],X,Y).
leftInList([_|List],X,Y):- leftInList(List,X,Y).
%X справа от Y
rightInList([_],_,_):-fail.
rightInList([Y,X|_],X,Y).
rightInList([_|List],X,Y):- rightInList(List,X,Y).

near(List,X,Y):-rightInList(List,Y,X).
near(List,X,Y):-leftInList(List,Y,X).
task17:-
    Jar = [_,_,_,_],
    in_list(Jar,[bottle,_]),
    in_list(Jar,[cup,_]),
    in_list(Jar,[kuvshin,_]),
    in_list(Jar,[banka,_]),
    in_list(Jar,[_,milk]),
    in_list(Jar,[_,water]),
    in_list(Jar,[_,limonad]),
    in_list(Jar,[_,kvas]),
    not(in_list(Jar,[bottle,milk])),
    not(in_list(Jar,[bottle,water])),
    between(Jar,[kuvshin,_],[_,limonad],[_,kvas]),
    not(in_list(Jar,[banka,water])),
    not(in_list(Jar,[banka,limonad])),
    near(Jar,[cup,_],[banka,_]),
    near(Jar,[cup,_],[_,milk]),
    write(Jar),!.

task18:-
    Guys=[_,_,_,_],
    in_list(Guys,[voronov,_]),
    in_list(Guys,[levitskiy,_]),
    in_list(Guys,[pavlov,_]),
    in_list(Guys,[saharov,_]),
    in_list(Guys,[_,dancer]),
    in_list(Guys,[_,artist]),
    in_list(Guys,[_,singer]),
    in_list(Guys,[_,writer]),
    not(in_list(Guys,[voronov,singer])),
    not(in_list(Guys,[levitskiy,singer])),
    not(in_list(Guys,[pavlov,writer])),
    not(in_list(Guys,[pavlov,artist])),
    not(in_list(Guys,[voronov,writer])),
    not(in_list(Guys,[saharov,writer])),
    not(in_list(Guys,[voronov,artist])),
    write(Guys),!.


    
    

    

