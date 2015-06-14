/* Teeko.pl - Barbara SCHIAVI - IA41 UTBM 2015*/
%:- consult('AI.pl'). % inclusion of file AI.pl
:- consult('WinListv2.pl'). % inclusion of file AI.pl
:- dynamic board/1.
:- dynamic playerPawnList/2.

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

%AI player pawn list
playerPawnList('B', [0, 0, 0, 0]).
playerPawnList('R', [0, 0, 0, 0]).

parcoursPawnList(Player, NbElemZero):- playerPawnList(Player, List), parcoursPawnList(Player, NbElemZero, List, 0).
parcoursPawnList(_, NbElemZero, [], Compter):- NbElemZero is Compter.
parcoursPawnList(Player, NbElemZero, [0|R], Compter):- Compter1 is Compter + 1, parcoursPawnList(Player, NbElemZero, R, Compter1).
parcoursPawnList(Player, NbElemZero, [_|R], Compter):- parcoursPawnList(Player, NbElemZero, R, Compter).

%return nb player pawn on board
pawnPlayerOnBoard(Player, _):- writeln('pawnPlayerOnBoard'), board(L), pawnPlayerOnBoard(Player, 0, L).
pawnPlayerOnBoard(_, _, []).
pawnPlayerOnBoard(Player, NbPawnOnBoard, [Val|R]):- player(Player, Val), NbPawnOnBoard1 is NbPawnOnBoard + 1, pawnPlayerOnBoard(Player, NbPawnOnBoard1, R).
pawnPlayerOnBoard(Player, NbPawnOnBoard, [_|R]):- pawnPlayerOnBoard(Player, NbPawnOnBoard, R).

%Add position on List
addOnList(Player, Pos):- writeln('je suis dans addOnList'), parcoursPawnList(Player, 4), assertz(playerPawnList(Player, [Pos, _, _, _])).
addOnList(Player, Pos):- parcoursPawnList(Player, 4), assertz(playerPawnList(Player, [_, Pos, _, _])).
addOnList(Player, Pos):- parcoursPawnList(Player, 4), assertz(playerPawnList(Player, [_, _, Pos, _])).
addOnList(Player, Pos):- parcoursPawnList(Player, 4), assertz(playerPawnList(Player, [_, _, _, Pos])).

%Return if combo of pawn is win combo
winner(Player):- writeln('winner'), board(L), playerVal(Player, Val), win(_, L, Val), !.

%check if case is free
checkAvailblePos(A):- writeln('Je check si la place est fruiiiiiit'), between(1, 25, A), board(L), checkAvailblePos(A, L, 0).
checkAvailblePos(A, [0|_], A).
checkAvailblePos(A, [_|R], N):- N1 is N + 1, checkAvailblePos(A, R, N1).

%Set Pawn on board
setOnBoard(Player, 1):- playerVal(Player, V), assertz(board([V|_])).
setOnBoard(Player, 2):- playerVal(Player, V), assertz(board([_, V|_])).
setOnBoard(Player, 3):- playerVal(Player, V), assertz(board([_, _, V|_])).
setOnBoard(Player, 4):- playerVal(Player, V), assertz(board([_, _, _, V|_])).
setOnBoard(Player, 5):- playerVal(Player, V), assertz(board([_, _, _, _, V|_])).
setOnBoard(Player, 6):- playerVal(Player, V), assertz(board([_, _, _, _, _, V|_])).
setOnBoard(Player, 7):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, V|_])).
setOnBoard(Player, 8):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 9):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 10):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 11):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 12):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 13):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 14):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 15):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 16):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 17):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 18):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 19):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 20):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 21):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 22):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 23):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 24):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
setOnBoard(Player, 25):- playerVal(Player, V), assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V])).

%Unset Pawn off board
unsetOnBoard(_, 1):- V is 0, assertz(board([V|_])).
unsetOnBoard(_, 2):- V is 0, assertz(board([_, V|_])).
unsetOnBoard(_, 3):- V is 0, assertz(board([_, _, V|_])).
unsetOnBoard(_, 4):- V is 0, assertz(board([_, _, _, V|_])).
unsetOnBoard(_, 5):- V is 0, assertz(board([_, _, _, _, V|_])).
unsetOnBoard(_, 6):- V is 0, assertz(board([_, _, _, _, _, V|_])).
unsetOnBoard(_, 7):- V is 0, assertz(board([_, _, _, _, _, _, V|_])).
unsetOnBoard(_, 8):- V is 0, assertz(board([_, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 9):- V is 0, assertz(board([_, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 10):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 11):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 12):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 13):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 14):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 15):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 16):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 17):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 18):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 19):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 20):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 21):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 22):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 23):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 24):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V|_])).
unsetOnBoard(_, 25):- V is 0, assertz(board([_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, V])).

%verfi nombre de pion sur board
fullBoard(NbPawnOnBoard):- board(List), sublist(\=(0), List, L), length(L, NbPawnOnBoard).

% verif si ca appartient au bon player
checkPawnPlayer(Player, A):- board(List), checkPawnPlayer(Player, A, List).
checkPawnPlayer(Player, 1, board([Val|_])):- player(Player, Val).
checkPawnPlayer(Player, A, board([_|R])):- A > 0, A1 is A - 1, checkPawnPlayer(Player, A1, R).

% checkPossibleMove : check if its a correct move of the pawn and if the case is free.
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn - 6, ToA == NewA, !, not(member(Pawn, [1, 2, 3, 4, 5, 6, 11, 16, 21])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn - 5, ToA == NewA, !, not(member(Pawn, [1, 2, 3, 4, 5])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn - 4, ToA == NewA, !, not(member(Pawn, [1, 2, 3, 4, 5, 10, 15, 20, 25])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn - 1, ToA == NewA, !, not(member(Pawn, [1, 6, 11, 16, 21])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn + 1, ToA == NewA, !, not(member(Pawn, [5, 10, 15, 20, 25])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn + 4, ToA == NewA, !, not(member(Pawn, [1, 6, 11, 16, 21, 22, 23, 24, 25])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn + 5, ToA == NewA, !, not(member(Pawn, [21, 22, 23, 24, 25])), !, checkAvailblePos(NewA).
checkPossibleMove(_, Pawn, ToA, NewA):- NewA is Pawn + 6, ToA == NewA, !, not(member(Pawn, [5, 10, 15, 20, 25, 21, 22, 23, 24])), !, checkAvailblePos(NewA).

%move pawn : assert new et retract old
moveOnBoard(Player, Pawn, ToA):- setOnBoard(Player, ToA), unsetOnBoard(Player, Pawn).