my_times(X, [], Z):-Z==0.

my_times(X, [Y|Ys], Z) :-
    X\=Y, write(Z), nl, Z>=0, my_times(X, Ys, Z).
my_times(X, [Y|Ys], Z) :-
    X==Y, Zn is Z-1, Zn>=0, write(Zn), nl, my_times(X, Ys, Zn).
