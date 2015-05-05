/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

%Definition of players. predicat player(+X, +Y). with X, Y are elements.
player('R', 'red').
player('B', 'black').

%Definition of list of players' pawn. predicat pawn(+X, -L). with X is element, L is List.
pawn('R', [R1, R2, R3, R4]).
pawn('B', [B1, B2, B3, B4]).

%Return postion of a players pawn. predicat pawnPosition(+P, -X, -Y).
pawnPosition([| R]):-pawn(X, L)


