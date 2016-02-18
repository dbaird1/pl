my_times(X, [], Z).
my_times(X, [Y|Ys], Z) :-
    =(X,Y), write("AFSF"), Z is Z-1, Z>=0, write(Z), nl, my_times(X, Ys, Z).
my_times(X, [Y|Ys], Z) :-
    X\=Y, nl, Z>=0, my_times(X, Ys, Z).
