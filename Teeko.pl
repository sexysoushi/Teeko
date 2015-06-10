/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/
:- consult('AI.pl'). % inclusion of file AI.pl
:- dynamic vars/1.

/* Prolog function use */
%between(+Low, +High, ?Value)
%not(:Goal)
%nonvar(@Term) : True if Term currently is not a free variable.
%assertz(+Term)
%retract(+Term)
%member(?Elem, ?List)

/*------------------------------------------- BOARD design ---------------------------------------------

| A1  | A2  | A3  | A4  | A5  |
_______________________________
| A6  | A7  | A8  | A9  | A10 |
_______________________________
| A11 | A12 | A13 | A14 | A15 |
_______________________________
| A16 | A17 | A18 | A19 | A20 |
_______________________________
| A21 | A22 | A23 | A24 | A25 |

Move available on board:
Always between 1:25 (board side)
Pos - 6
Pos - 5
Pos - 4
Pos - 1
Pos + 1
Pos + 4
Pos + 5
Pos + 6

 -------------------------------------------------------------------------------------------------------*/
 
 /* Board def */
vars([A1, A2, A3, A4, A5,
		A6 , A7 , A8 , A9 , A10,
		A11, A12, A13, A14, A15,
		A16, A17, A18, A19, A20,
		A21, A22, A23, A24, A25
		]).
		
/* Win Line */
rowList([[A1, A2, A3, A4],
		[A2, A3, A4 ,A5],
		[A6, A7, A8, A9],
		[A7, A8, A9, A10],
		[A11, A12, A13, A14],
		[A12, A13, A14, A15],
		[A16, A17, A18, A19],
		[A17, A18, A19, A20],
		[A21, A22, A23, A24],
		[A22, A23, A24, A25]
		]).

/* Win Column */
columnList([[A1, A6, A11, A16],
		[A6, A11, A16, A21],
		[A2, A7, A12, A17],
		[A7, A12, A17, A22],
		[A3, A8, A13, A18],
		[A8, A13, A18, A23],
		[A4, A9, A14, A19],
		[A9, A14, A19, A24],
		[A5, A10, A15, A20],
		[A10, A15, A20, A25]
		]).
		
/* Win Diago */
diagoList([[A1, A7, A13, A19],
		[A7, A13, A19, A25],
		[A2, A8, A14, A20],
		[A6, A12, A18, A24],
		[A4, A8, A12, A16],
		[A5, A9, A13, A17],
		[A9, A13, A17, A21],
		[A10, A14, A18, A22]
		]).
		
/* Win Square */		
squareList([[A1, A2, A6, A7],
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
		[A17, A18, A22, A23],
		[A18, A19, A23, A24],
		[A19, A20, A24, A25]
		]).
		

/*--------------------------------------------- Player vs Player ------------------------------------------------------*/
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
nextPlayer(X, Y):- write('nextPlayer'), player(Y, _), not(Y = X).

%Return if combo of pawn is win combo
winner('B'):- write('winnerB'),pawnPosition('B1', BA1), pawnPosition('B2', BA2), pawnPosition('B3', BA3), pawnPosition('B4', BA4), winner(BA1, BA2, BA3, BA4), !.
winner('R'):- write('winnerR'),pawnPosition('R1', RA1), pawnPosition('R2', RA2), pawnPosition('R3', RA3), pawnPosition('B4', RA4), winner(RA1, RA2, RA3, RA4), !.
% by row
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborRaw(L, [PA1, PA2, PA3, PA4]), !.
% by column
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborColumn(L, [PA1, PA2, PA3, PA4]), !.
% by diagnal up
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborDiagonal(L, [PA1, PA2, PA3, PA4]), !.
% by diagonal down
winner(A1, A2, A3, A4):- permutation([A1, A2, A3, A4], [PA1, PA2, PA3, PA4]), checkBetween([PA1, PA2, PA3, PA4]), neighborSquare(L, [PA1, PA2, PA3, PA4]), !.

%Check if pawns are on a same win row
neighborRaw([], []).
neighborRaw([L|R1], [T|R2]):- rowList([L|R1]), member(T, L), !, allInList(L, R2).
neighborRaw([L|R1], [T|R2]):- rowList([L|R1]), neighborRaw(R1, T).

%Check if pawns are on a same win column
neighborColumn([], []).
neighborColumn([L|R1], [T|R2]):- columnList([L|R1]), member(T, L), !, allInList(L, R2).
neighborColumn([L|R1], [T|R2]):- columnList([L|R1]), neighborColumn(R1, T).

%Check if pawns are on a same win diagonal up
neighborDiagonalUp([], []).
neighborDiagonalUp([L|R1], [T|R2]):- diagoList([L|R1]), member(T, L), !, allInList(L, R2).
neighborDiagonalUp([L|R1], [T|R2]):- diagoList([L|R1]), neighborDiagonal(R1, T).

%Check if pawns are on a same win diagonal down
neighborDiagonalDown([], []).
neighborDiagonalDown([L|R1], [T|R2]):- squareList([L|R1]), member(T, L), !, allInList(L, R2).
neighborDiagonalDown([L|R1], [T|R2]):- squareList([L|R1]), neighborSquare(R1, T).

%Check all pawn in a list
allInList(L, [T|R]):- member(T, L), allInList(L, R).

%Return last element of PawnList
lastPawn(Player, Pawn) :- pawnList(Player, PawnList), haveNoPos(PawnList, Pawn).

%Return the pawn of pawnlist haven't got yet position
haveNoPos([P|_], P) :- not(pawnPosition(P,_)), !.
haveNoPos([T|R], P) :- pawnPosition(T,_), haveNoPos(R, P).

%Set Pawn on board
setOnBoard(Pawn, A) :- nonvar(Pawn), nonvar(A), calcSet(Pawn, A), assertz(pawnPosition(Pawn, A)), !.

%Unset Pawn off board
unsetOffBoard(Pawn) :- nonvar(Pawn), pawnPosition(Pawn, A), retract(pawnPosition(Pawn, A)), !.

% if position is available
calcSet(Pawn, A) :- between(1, 25, A), not(pawnPosition(_, A)), not(pawnPosition(Pawn, _)).

%calcAllSet : calculate all positions available to set a Pawn and check if the Pawn is the first which can be set
calcAllSet(Player, Pawn, A) :- lastPawn(Player, Pawn), calcSet('NE', Pawn).

%moveOnBoard : Move pawn to next position and retract the last position
moveOnBoard(Pawn, ToA) :- pawnPosition(Pawn, FromA), assert(pawnPosition(Pawn, ToA)), retract(pawnPosition(Pawn, FromA)), !.

%calcAllMove : calculate all moves available for all pawns
calcAllMove(Player, Pawn, ToA) :- pawnList(Player, PawnList), member(Pawn, PawnList), calcMove(Pawn, ToA).
/*
%calcMove for M
calcMove(Pawn, ToA):- pawnPosition(Pawn, FromA),
				between(1, 25, ToA),
				between(4, 6, Val)

inRange([TOX, TOY], 1, 5),
    MAXX is FROMX + 1, MINX is FROMX - 1, inRange([TOX], MINX, MAXX),
    MAXY is FROMY + 1, MINY is FROMY - 1, inRange([TOY], MINY, MAXY),
    sdif(TOX, FROMX, TOY, FROMY),
    not(pawnPosition(_, ToA)).
*/
%calcAll : calculate all moves/set depending on phase
calcAll(Player, Pawn, A) :- lastPawn(Player, Pawn), calcAllSet(Player, Pawn, A).
calcAll(Player, Pawn, A) :- not(lastPawn(Player, Pawn)), calcAllMove(Player, Pawn, A).