readList(0, []) :- !.
readList(I, [X|T]) :- write("input - "),read(X), I1 is I - 1, readList(I1, T).

write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).

%1.37 вывести индексы элементов, которые меньше своего левого соседа и их количество

lessLeft([H|Tail],Count):-lessLeft(H,Tail,0, Count,1).
lessLeft(_,[],Count,Count,_):-!.
lessLeft(LeftEl,[H|Tail],CountNow,Count, Ind):- 
    (H<LeftEl, NewCount is CountNow+1, write(Ind),nl,!; NewCount is CountNow),
    NextInd is Ind+1, lessLeft(H,Tail,NewCount,Count,NextInd).

task11:-write("Input lenght of list: "), read(Count),readList(Count,List),
    lessLeft(List,X), write("Number of elements that are less than the left: "),write(X).