/* Teeko.pl - Barbara SCHIAVI - IA41 UTBM 2015*/
%:- consult('AI.pl'). % inclusion of file AI.pl
:- consult('WinListv2.pl'). % inclusion of file AI.pl

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

parcoursPawnList(Player, _):- playerPawnList(Player, List), parcoursPawnList(Player, 0, List).
parcoursPawnList(_, NbElemZero, []).
parcoursPawnList(Player, NbElemZero, [0|R]):- NbElemZero1 is NbElemZero + 1, parcoursPawnList(Player, NbElemZero1, R).
parcoursPawnList(Player, NbElemZero, [_|R]):- parcoursPawnList(Player, NbElemZero, R).

%Add position on List
addOnList(Player, Pos):- writeln('addOnList'), playerPawnList(Player, L), addOnList(Player, Pos, L).
addOnList(Player, Pos, [Pos|_]):- parcoursPawnList(Player, NbElemZero), NbElemZero == 4.
addOnList(Player, Pos, [_, Pos|_]):- parcoursPawnList(Player, NbElemZero), NbElemZero == 3.
addOnList(Player, Pos, [_, _, Pos|_]):- parcoursPawnList(Player, NbElemZero), NbElemZero == 2.
addOnList(Player, Pos, [_, _, _, Pos]):- parcoursPawnList(Player, NbElemZero), NbElemZero == 1.

%Return if combo of pawn is win combo
winner(Player):- writeln('winner'), board(L), playerVal(Player, Val), win(_, L, Val).

%check if case is free
checkAvailblePos(A):- writeln('Je check si la place est fruiiiiiit'), between(1, 25, A), board(L), checkAvailblePos(A, L, 0).
checkAvailblePos(A, [0|_], A).
checkAvailblePos(A, [_|R], N):- N1 is N + 1, checkAvailblePos(A, R, N1).

%Set Pawn on board
setOnBoard(_, N):- writeln('setOnBoard'), setOnBoard(_, N, board(_), 0).
setOnBoard(Player, N, board([Val|_]), N):- playerVal(Player, Val).
setOnBoard(_, N, board([_|R]), Compter):- Compter < N, Compter1 is Compter + 1, setOnBoard(_, N, board([_|R]), Compter1).


%Unset Pawn off board
unsetOnBoard(_, N):- unsetOnBoard(_, N, board(_), 0).
unsetOnBoard(_, N, board([0|_]), N).
unsetOnBoard(_, N, board([_|R]), Compter):- Compter < N, Compter1 is Compter + 1, unsetOnBoard(_, N, board([_|R]), Compter1).

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
moveOnBoard(Player, Pawn, ToA):- unsetOnBoard(Player, Pawn), setOnBoard(Player, ToA).