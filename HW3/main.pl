% Helper predicate to check if a number is prime
is_prime(2) :- !.
is_prime(3) :- !.
is_prime(N) :-
    N > 3,
    N mod 2 =\= 0,
    \+ has_factor(N, 3).

has_factor(N, Factor) :-
    N mod Factor =:= 0.
has_factor(N, Factor) :-
    Factor * Factor < N,
    NextFactor is Factor + 2,
    has_factor(N, NextFactor).

% Predicate to find the Goldbach composition of an even number
goldbach(N, [P1, P2]) :-
    N > 2,
    N mod 2 =:= 0,
    between(2, N, P1),
    is_prime(P1),
    P2 is N - P1,
    is_prime(P2).

% Predicate to find Goldbach compositions in a given range
goldbach_list(N1, N2) :-
    N1 =< N2,
    N1 mod 2 =:= 0,
    goldbach(N1, L),
    writef('%w = %w + %w\n', [N1, L]),
    NextN1 is N1 + 2,
    goldbach_list(NextN1, N2).
goldbach_list(N1, N2) :-
    N1 =< N2,
    NextN1 is N1 + 2,
    goldbach_list(NextN1, N2).
goldbach_list(_, _).

% Predicate to find Goldbach compositions within a range with a limit on prime numbers
goldbach_list_limit(N1, N2, Limit) :-
    N1 =< N2,
    N1 mod 2 =:= 0,
    goldbach(N1, [P1, P2]),
    P1 =< Limit,
    P2 =< Limit,
    writef('%w = %w + %w\n', [N1, P1, P2]),
    NextN1 is N1 + 2,
    goldbach_list_limit(NextN1, N2, Limit).
goldbach_list_limit(N1, N2, Limit) :-
    N1 =< N2,
    NextN1 is N1 + 2,
    goldbach_list_limit(NextN1, N2, Limit).
goldbach_list_limit(_, _, _).


