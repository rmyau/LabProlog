read_str(A,N):-get0(X),r_str(X,A,[],N,0).
r_str(10,A,A,N,N):-!.
r_str(X,A,B,N,K):-K1 is K+1,append(B,[X],B1),get0(X1),r_str(X1,A,B1,N,K1).

write_str([]):-!.
write_str([H|T]):-put(H),write_str(T).

in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

lenList([H|T],Res):-lenList([H|T],Res,0).
lenList([],Res,Res):-!.
lenList([_|T], Res,NowRes):-NewRes is NowRes+1, 
    lenList(T,Res,NewRes).

write_list([]) :- !.
write_list([X|T]) :- write(X), nl, write_list(T).
%Дана строка. Вывести ее три раза через запятую и показать количество символов в ней.
task11 :- read_str(A,N),write_str(A),write(', '),write_str(A),write(', '),
		write_str(A),write(', '),write(N).

count_words(A,K):-count_words(A,0,K).
count_words([],K,K):-!.
count_words(A,I,K):-skip_space(A,A1),get_word(A1,Word,A2),Word \=[],I1 is I+1,count_words(A2,I1,K),!.
count_words(_,K,K).

skip_space([32|T],A1):-skip_space(T,A1),!.
skip_space(A1,A1).

get_word([],[],[]):-!.
get_word(A,Word,A2):-get_word(A,[],Word,A2).
get_word([],Word,Word,[]).
get_word([32|T],Word,Word,T):-!.
get_word([H|T],W,Word,A2):-append(W,[H],W1),get_word(T,W1,Word,A2).

%Дана строка. Найти количество слов.
task12 :- read_str(A,_), count_words(A,K), write(K).

get_words(A,Words,K):-get_words(A,[],Words,0,K).
get_words([],B,B,K,K):-!.
get_words(A,Temp_words,B,I,K):-
	skip_space(A,A1),get_word(A1,Word,A2),Word \=[],
	I1 is I+1,append(Temp_words,[Word],T_w),get_words(A2,T_w,B,I1,K),!.
get_words(_,B,B,K,K).

unicList(List,List2):- unicList(List,List2,[]).
unicList([],List,List):-!.
unicList([H|T],List2,ListNow) :- in_list(ListNow,H), unicList(T,List2,ListNow),!;
    append(ListNow,[H],NewList), unicList(T,List2,NewList).

count_elems(_,[],[]):-!.
count_elems(A,[H|T],[Cur|Tail]):-count_el(H,A,Cur),count_elems(A,T,Tail).

count_el(El,List,Count):-count_el(El,List,Count,0).
count_el(_,[],Count,Count):-!.
count_el(El,[El|T],Count,Cur):-Cur1 is Cur+1, count_el(El,T,Count,Cur1),!.
count_el(El,[_|T],Count,Cur):-count_el(El,T,Count,Cur).

mostOftenWord(List,Word):- unicList(List,[H|T]), count_elems(List,[H|T],[Cur|Tail]),
    mostOftenWord(T, Tail,Word,H,Cur).
mostOftenWord([],[],Word,Word,_):-!.
mostOftenWord([H|T],[Cur|Tail],Word,W,MaxCount):- Cur>MaxCount, W1 is H,Max1 is Cur, mostOftenWord(T,Tail,Word,W1,Max1),!;
    mostOftenWord(T,Tail,Word,W,MaxCount).

%Дана строка, определить самое частое слово
task13 :- read_str(A,_), get_words(A,Words,_),mostOftenWord(Words,Word),write_str(Word).

%Вывести первые три символа и последний три символа,
%если длина строки больше 5 Иначе вывести первый символ столько
%раз, какова длина строки.
writeN(_,0):-!.
writeN([El],N):-put(El),nl,N1 is N-1, writeN([El],N1). 

last3Letters([H1|[H2|[H3|[]]]]):-write_str([H1]),nl,write_str([H2]),nl,
    write_str([H3]),!.
last3Letters([_|T]):-last3Letters(T).
first3Letters([H1,H2,H3|_]):-write_str([H1]),nl,write_str([H2]),nl,
    write_str([H3]),nl.
task14 :- read_str([H|T],N),
    (N>5,first3Letters([H|T]),last3Letters(T),!; writeN([H],N)).

%Показать номера символов, совпадающих с последним,символом строки.
lastSimbol([L|[]],L):-!.
lastSimbol([_|T],L):- lastSimbol(T,L).

outIndSimbol([S],List,CountSimb):- outIndSimbol([S],List,CountSimb,0,0).
outIndSimbol(_,[],Count,Count,_):-!.
outIndSimbol([S],[S|T],C,Count,Ind):-I1 is Ind+1,C1 is Count+1,
    outIndSimbol([S],T,C,C1,I1),!.
outIndSimbol([S],[_|T],C,Count,Ind):- I1 is Ind+1, outIndSimbol([S],T,C,Count,I1).

task15:- read_str(A,_), lastSimbol(A,L),outIndSimbol([L],A,_). 

%2 задание

%дан файл, Прочитать из файла строки и вывести длину наибольшей строки.

%флаг - конец файла или enter
read_str_f(A,N,Flag):-get0(X),r_str_f(X,A,[],N,0,Flag).
r_str_f(-1,A,A,N,N,0):-!.
r_str_f(10,A,A,N,N,1):-!.
r_str_f(X,A,B,N,K,Flag):-K1 is K+1,append(B,[X],B1),get0(X1),r_str_f(X1,A,B1,N,K1,Flag).

read_list_str(List,List_len):-read_str_f(A,N,Flag),r_l_s(List,List_len,[A],[N],Flag).
r_l_s(List,List_len,List,List_len,0):-!.
r_l_s(List,List_len,Cur_list,Cur_list_len,_):-
	read_str_f(A,N,Flag),append(Cur_list,[A],C_l),append(Cur_list_len,[N],C_l_l),
	r_l_s(List,List_len,C_l,C_l_l,Flag).

maxLenStrInFile([H|ListLen],Max):-maxLenStrInFile(ListLen, Max,H).
maxLenStrInFile([],Max,Max):-!.
maxLenStrInFile([H|T],Max,M):- H>M, maxLenStrInFile(T,Max,H),!;
    maxLenStrInFile(T,Max,M).

task2_1:- see('c:/prolog/text.txt'),
    read_list_str(_,List_len), seen, maxLenStrInFile(List_len,Max),
    write("Max len = "), write(Max).

%Определить, сколько в файле строк, не содержащих пробелы.
findSpace([],0):-!.
findSpace([32|_],1):-!.
findSpace([_|T],Flag):-findSpace(T,Flag).

listWithoutSpace(List,N):- lws(List,N,0).
lws([],N,N):-!.
lws([H|T],N,CurN):-findSpace(H,Flag), 
    (Flag is 1, lws(T,N,CurN),!;
    N1 is CurN+1, lws(T,N,N1)).

task2_2:- see('c:/prolog/text.txt'),read_list_str(List,_), seen,
    listWithoutSpace(List,N), write(N).


%найти и вывести на экран только те строки, в которых букв
%А больше, чем в среднем на строку.

%общее количество символов в строке  
countSymbols(List,S,Res):- char_code(S, Code),
    countSymbols(List,[Code],Res,0).
countSymbols([],_,Res,Res):-!.
countSymbols([H|T],S,R,Res):- outIndSimbol(S,H,CountS),
    R1 is Res+CountS, countSymbols(T,S,R,R1).

moreAvgA([],_):-!.
moreAvgA([H|T],Avg):- char_code("A",A1), char_code("a",A2),
    outIndSimbol([A1],H,Res1), outIndSimbol([A2],H,Res2),
    Count is Res1+Res2,Count>Avg, write_str(H),nl,
    moreAvgA(T,Avg),!;moreAvgA(T,Avg).

task2_3:- see('c:/prolog/text2.txt'),read_list_str(List,_), seen,
    lenList(List,Len), countSymbols(List,"A",CountA),countSymbols(List,"a",Counta),
    CountSymbA is CountA+Counta, Average is CountSymbA/Len, write(Average),nl,
    moreAvgA(List,Average).

%вывести самое частое слово

concat([], List2, List2).
concat([H|T], List2, [H|NewList]) :- concat(T, List2, NewList).

listWords(List,BigList):-concatElList(List,BigList,[]).
concatElList([],BL,BL):-!.
concatElList([H|T],BL,List):-get_words(H,Words,_),
    concat(List,Words,NewList),concatElList(T,BL,NewList).

task2_4:-see('c:/prolog/text3.txt'),read_list_str(List,_), seen,
    listWords(List,Words), write(Words),mostOftenWord(Words,Word), write_str(Word),nl.

%вывести в отдельный файл строки, состоящие из слов, не
%повторяющихся в исходном файле.

%фуфуфу

%3.1 Необходимо найти общее количество русских символов.
countRus(A,Count):- countRus(A,Count,0).
countRus([],C,C):-!.
countRus([H|T],C,C1):- H>1039, H<1104, C2 is C1+1, countRus(T,C,C2),!;
    countRus(T,C,C1).
task3:- read_str(A,_),countRus(A,Count), write(Count).

%4.9 Необходимо проверить образуют ли строчные символы латиницы палиндром.
littleLet(A,List):- littleLet(A,List,[]).
littleLet([],List,List):-!.
littleLet([H|T],List,CurL):-H>96, H<123, concat(CurL,[H],NewL),littleLet(T,List,NewL),!; 
    littleLet(T,List,CurL).

rev([H|T],L):- rev([H|T],L,[]).
rev([],L,L):-!.
rev([H|T],L,CurL):- rev(T,L,[H|CurL]).

palindrom([H|T]):- rev([H|T],[H2|Tail]),pal([H|T],[H2|Tail]).
pal([],[]):-!.
pal([H|T],[H1|T1]):-H is H1, pal(T,T1),!.

task4:- read_str(A,_),  littleLet(A,List),palindrom(List).



