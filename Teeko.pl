




/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/


/* -------------------------------  board Definition -----------------------------------*/
Vars = 	[
		A1 , A2,  A3 , A4 , A5 ,
		A6 , A7 , A8 , A9 , A10,
		A11, A12, A13, A14, A15,
		A16, A17, A18, A19, A20,
		A21, A22, A23, A24, A25}
		]
		
Line =  [
		[A1, A2, A3, A4],
		[A2, A3, A4 ,A5],
		[A6, A7, A8, A9],
		[A7, A8, A9, A10],
		[A11, A12, A13, A14],
		[A12, A13, A14, A15],
		[A16, A17, A18, A19],
		[A17, A18, A19, A20],
		[A21, A22, A23, A24],
		[A22, A23, A24, A25]
		]
		
Colum = [
		[A1, A6, A11, A16],
		[A6, A11, A16, A21],
		[A2, A7, A12, A17],
		[A7, A12, A17, A22],
		[A3, A8, A13, A18],
		[A8, A13, A18, A23],
		[A4, A9, A14, A19],
		[A9, A14, A19, A24],
		[A5, A10, A15, A20],
		[A10, A15, A20, A25]
		]
		
Diago = [
		[A1, A7, A13, A19],
		[A7, A13, A19, A25],
		[A2, A8, A14, A20],
		[A6, A12, A18, A24],
		[A4, A8, A12, A16],
		[A5, A9, A13, A17],
		[A9, A13, A17, A21],
		[A10, A14, A18, A22]
		]
Square= [
		[A1, A2, A6, A7],
		[A2, A3, A7, A8],
		[A3, A4, A8, A9],
		[A4, A5, A9, A10],
		
		[A6, A7, A11, A12],
		[A7, A8, A12, A13],
		[A8, A9, A13, A14],
		[A9, A10, A14, A15],
		
		[A11, A12, A16, A17],
		[A12, A13, A17, A18],
		[A13, A14, A18, A19],
		[A14, A15, A19, A20],
		
		[A16, A17, A21, A22],
		[A17, A18, A22, A23];
		[A18, A19, A23, A24],
		[A19, A20, A24, A25]
		]
		

/* -------------------------------  board Definition -----------------------------------*/
/*---------------------------- Player vs Player/AI -------------------------------------*/
:- consult('AI.pl'). % inclusion du fichier AI.pl
:- dynamic pawnPosition/3.

%Definition of players. predicat player(-X, ?Y). with X, Y are elements.
player('B', 'Black player').
player('R', 'Red player').

%Check elem of list are between 1 and 25. 
checkBetween([]).
checkBetween([T|R]):- between(1, 25, T), checkBetween(R).

%Pawn coordinates A. Predicat dynamic up grade each move.
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
% by raw
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborRaw(L, [PA1, PA2, PA3, PA4]), !.
% by column
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborColumn(L, [PA1, PA2, PA3, PA4]), !.
% by diagnal up
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborDiagonalUp(L, [PA1, PA2, PA3, PA4]), !.
% by diagonal down
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborDiagonalDown(L, [PA1, PA2, PA3, PA4]), !.

%Check if pawns are on a same win raw
neighborRaw().
neighborRaw([L|R1], [T|R2]):- rawList([L|R1]), member(T, L), !, allInList(L, R2).
neighborRaw([L|R1], [T|R2]):- rawList([L|R1]), neighborRaw(R1, T).

%Check if pawns are on a same win column
neighborColumn().
neighborColumn([L|R1], [T|R2]):- columnList([L|R1]), member(T, L), !, allInList(L, R2).
neighborColumn([L|R1], [T|R2]):- columnList([L|R1]), neighborColumn(R1, T).

%Check if pawns are on a same win diagonal up
neighborDiagonalUp().
neighborDiagonalUp([L|R1], [T|R2]):- diagUpList([L|R1]), member(T, L), !, allInList(L, R2).
neighborDiagonalUp([L|R1], [T|R2]):- diagUpList([L|R1]), neighborDiagonalUp(R1, T).

%Check if pawns are on a same win diagonal down
neighborDiagonalDown().
neighborDiagonalDown([L|R1], [T|R2]):- diagDownList([L|R1]), member(T, L), !, allInList(L, R2).
neighborDiagonalDown([L|R1], [T|R2]):- diagDownList([L|R1]), neighborDiagonalDown(R1, T).

%Check all pawn in a list
allInList(L, [T|R]):- member(T, L), allInList(L, R).

%Return last element of PawnList
lastPawn(Player, Pawn) :- pawn(Player, PawnList), haveNoPos(PawnList, Pawn).

%Return the pawn of pawnlist haven't got yet position
haveNoPos([P|_], P) :- not(pawnPosition(P,_,_)), !.
haveNoPos([T|R], P) :- pawnPosition(T,_,_), haveNoPos(R, P).

%Set marker on board
setOnBoard(Pawn, A) :- nonvar(Pawn), nonvar(A), calcSet(Pawn, A), assertz(pawnPosition(Pawn, A)), !.

%Unset marker off board
unsetOffBoard(Pawn) :- nonvar(Pawn), pawnPosition(Pawn, A), retract(pawnPosition(Pawn, A)), !.

% if position is available
calcSet(Pawn, A) :- between(1, 25, A), not(pawnPosition(_, A)), not(pawnPosition(Pawn, _)).