/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/*---------------------------- Player vs Player/AI -------------------------------------*/
:- consult('AI.pl'). % inclusion du fichier AI.pl
:- dynamic pawnPosition/3.

%Definition of players. predicat player(-X, ?Y). with X, Y are elements.
player('B', 'Black player').
player('R', 'Red player').

%Check A is between 1 and 25. 
checkBetween(_, A):- MIN is 1, MAX is 25, between(MIN, MAX, A).

%Pawn coordinates I, J. Predicat dynamic up grade each move.
pawnPosition('B1', A1).
pawnPosition('B2', A2).
pawnPosition('B3', A3).
pawnPosition('B4', A4).
pawnPosition('R1', A1).
pawnPosition('R2', A2).
pawnPosition('R3', A3).
pawnPosition('R4', A4).

%Definition of list of players' pawn. predicat pawn(-X, ?PawnList). with X is element, L is List.
pawnList('B', ['B1', 'B2', 'B3', 'B4']).
pawnList('R', ['R1', 'R2', 'R3', 'R4']).

%Return the next player who will play. predicat nextPlayer(+X, -Y), X and Y elements.
nextPlayer(X, Y):- player(Y, _), not(Y = X).

%Return if combo of pawn is win combo
winner('B') :-pawnPosition('B1', BA1), pawnPosition('B2', BA2), pawnPosition('B3', BA3), pawnPosition('B4', BA4), winner(BA1, BA2, BA3, BA4), !.
winner('R') :-pawnPosition('R1', RA1), pawnPosition('R2', RA2), pawnPosition('R3', RA3), pawnPosition('B4', RA4), winner(RA1, RA2, RA3, RA4), !.

%Return last element of PawnList
lastPawn(Player, Pawn) :- pawn(Player, PawnList), haveNoPos(PawnList, Pawn).

%Return the pawn of pawnlist haven't got yet coordonates
haveNoPos([P|_], P) :- not(pawnPosition(P,_,_)), !.
haveNoPos([T|R], P) :- pawnPosition(T,_,_), haveNoPos(R, P).

%Set marker on board
setOnBoard(Pawn, A) :- nonvar(Pawn), nonvar(A), calcSet(Pawn, A), assertz(pawnPosition(Pawn, A)), !.

%Unset marker off board
unsetOffBoard(Pawn) :- nonvar(Pawn), pawnPosition(Pawn, A), retract(pawnPosition(Pawn, A)), !.

calcSet().


