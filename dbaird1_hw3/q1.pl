my_member(X, [X|Xs]).
my_member(X, [Y|Ys]) :-
    my_member(X, Ys).
