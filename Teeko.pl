/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/*---------------------------- Player vs Player/AI -------------------------------------*/
:- consult('AI.pl'). % inclusion du fichier AI.pl
:- dynamic pawnPosition/3.

%Definition of players. predicat player(-X, ?Y). with X, Y are elements.
player('B', 'Black player').
player('R', 'Red player').

%Check I, J between 1 and 5. 
checkBetween(_, I, J):- MIN is 1, MAX is 5, between(MIN, MAX, I), between(MIN, MAX, J).

%Pawn coordinates I, J. Predicat dynamic up grade each move.
pawnPosition('B1', I, J).
pawnPosition('B2', I, J).
pawnPosition('B3', I, J).
pawnPosition('B4', I, J).
pawnPosition('R1', I, J).
pawnPosition('R2', I, J).
pawnPosition('R3', I, J).
pawnPosition('R4', I, J).

%Definition of list of players' pawn. predicat pawn(-X, ?PawnList). with X is element, L is List.
pawnList('B', ['B1', 'B2', 'B3', 'B4']).
pawnList('R', ['R1', 'R2', 'R3', 'R4']).

%Return the next player who will play. predicat nextPlayer(+X, -Y), X and Y elements.
nextPlayer(X, Y):- player(Y, _), not(Y = X).

%Return if combo of pawn is win combo
winner().

%Return last element of PawnList
lastPawn(Player, Pawn) :- pawn(Player, PawnList), haveNoCoord(PawnList, Pawn).

%Return the pawn of pawnlist haven't got yet coordonates
haveNoCoord([P|_], P) :- not(pawnPosition(P,_,_)), !.
haveNoCoord([T|R], P) :- pawnPosition(T,_,_), haveNoCoord(R, P).

%Set marker on board
setOnBoard(Pawn, I, J) :- nonvar(Pawn), nonvar(I), nonvar(J), calcSet(Pawn, I, J), assertz(pawnPosition(Pawn, I, J)), !.

%Unset marker off board
unsetOffBoard(Pawn) :- nonvar(Pawn), pawnPosition(Pawn, I, J), retract(pawnPosition(Pawn, I, J)), !.




