man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

%является ли Х отцом Y
father(X,Y) :-  parent(X,Y), man(X),!.
%выводит отца Х
father(X):- parent(Y,X), man(Y), write(Y), nl, fail.

%12.1 предикат проверяет, является ли Х сестрой Y
sister(X,Y):- parent(Z,X), parent(Z,Y), woman(X).
%12.2 выводит всех сестер для Х
sister(X):-sister(Y,X), write(Y), nl, fail.

%13.1 является ли Х бабушкой Y
grand_ma(X,Y):-woman(X),parent(X,Z), parent(Z,Y),!.
%13.2 вывод всех бабушек Х
grand_ma(X):- parent(Y,Z), parent(Z,X), woman(Y), write(Y), nl, fail.

