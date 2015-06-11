/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/
%:- consult('AI.pl'). % inclusion of file AI.pl
:- consult('WinListv2.pl'). % inclusion of file AI.pl
:- dynamic board/2.

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
board([0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0
		]).

/*--------------------------------------------- Player vs Player ------------------------------------------------------*/
:- dynamic pawnPosition/3.

%Definition of players. predicat player(-X, ?Y). with X, Y are elements.
player('B', 'Black player').
player('R', 'Red player').

%retourne valeur du joueur
playerVal('B', 1).
playerVal('R', 2).

%Return the next player who will play. predicat nextPlayer(+X, -Y), X and Y elements.
%nextPlayer(X, Y):- writeln('nextPlayer'), player(Y, _), not(Y = X).
nextPlayer('R', 'B'):- writeln('nextPlayerR').
nextPlayer('B', 'R'):- writeln('nextPlayerB').

%Return if combo of pawn is win combo
winner(Player):- writeln('winner'), playerVal(Player, Val), winList(board, Val), !.

%check if case is free
checkAvailblePos(A):- checkAvailblePos(A, board).
checkAvailblePos(1, [0|_]).
checkAvailblePos(A, [_|R]):- A>0, A1 is A-1, checkAvailblePos(A1, R).

%Set Pawn on board
setOnBoard(Player, 1):- playerVal(Player, V), assertz(board([V|_])).
setOnBoard(Player, 2):- playerVal(Player, V), assertz(board([0, V|_])).
setOnBoard(Player, 3):- playerVal(Player, V), assertz(board([0, 0, V|_])).
setOnBoard(Player, 4):- playerVal(Player, V), assertz(board([0, 0, 0, V|_])).
setOnBoard(Player, 5):- playerVal(Player, V), assertz(board([0, 0, 0, 0, V|_])).
setOnBoard(Player, 6):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 7):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 8):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 9):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 10):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 11):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 12):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 13):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 14):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 15):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 16):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 17):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 18):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 19):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 20):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 21):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 22):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 23):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 24):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
setOnBoard(Player, 25):- playerVal(Player, V), assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V])).

%Unset Pawn off board
unsetOnBoard(Player, 1):- V is 0, assertz(board([V|_])).
unsetOnBoard(Player, 2):- V is 0, assertz(board([0, V|_])).
unsetOnBoard(Player, 3):- V is 0, assertz(board([0, 0, V|_])).
unsetOnBoard(Player, 4):- V is 0, assertz(board([0, 0, 0, V|_])).
unsetOnBoard(Player, 5):- V is 0, assertz(board([0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 6):- V is 0, assertz(board([0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 7):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 8):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 9):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 10):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 11):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 12):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 13):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 14):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 15):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 16):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 17):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 18):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 19):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 20):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 21):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 22):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 23):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 24):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V|_])).
unsetOnBoard(Player, 25):- V is 0, assertz(board([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, V])).

%verfi nombre de pion sur board
fullBoard(NbPawnOnBoard):- sublist(\=(0), board, L), length(L, NbPawnOnBoard).

% verif si ca appartient au bon player
checkPawnPlayer(Player, A):- checkAvailblePos(Player, A, board).
checkPawnPlayer(Player, 1, [Val|_]), player(Player, Val).
checkPawnPlayer(Player, A, [_|R]):- A>0, A1 is A-1, checkAvailblePos(Player, A1, R).

%move pawn : assert new et retract old
moveOnBoard(Player, Pawn, ToA).:- setOnBoard(Player, ToA), unsetOnBoard(Player, Pawn).









%moveOnBoard : Move pawn to next position and retract the last position
moveOnBoard(Pawn, ToA):- pawnPosition(Pawn, FromA), assert(pawnPosition(Pawn, ToA)), retract(pawnPosition(Pawn, FromA)), !.

%calcAllMove : calculate all moves available for all pawns
calcAllMove(Player, Pawn, ToA):- pawnList(Player, PawnList), member(Pawn, PawnList), calcMove(Pawn, ToA).
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
calcAll(Player, Pawn, A):- lastPawn(Player, Pawn), calcAllSet(Player, Pawn, A).
calcAll(Player, Pawn, A):- not(lastPawn(Player, Pawn)), calcAllMove(Player, Pawn, A).