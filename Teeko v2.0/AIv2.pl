/* AI.pl - Barbara SCHIAVI - IA41 UTBM 2015*/
%:- module(minimax, [minimax/3]).
:- consult('TEEKOv2.pl'). % inclusion of file teeko.pl

/* Prolog function use */
%findall(+Template, :Goal, -Bag)
%not(:Goal)
%length(?List, ?Int)
%setof(+Template, +Goal, -Set)
%random(-R:float)
%round(+Expr) : Evaluate Expr and round the result to the nearest integer.
%nth1(?Index, ?List, ?Elem) : Is true when Elem is the Index'th element of List. Counting starts at 1.
%min_list(+List:list(number), -Min:number) : True if Min is the smallest number in List. Fails if List is empty.
%max_list(+List:list(number), -Max:number) : True if Max is the biggest number in List. Fails if List is empty.

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


-------------------------------- Algo MinMax with AlphaBeta -------------------------------------------------*/

%return a random pos on the board if the random case is free
randPosOnBoard(RandPos):- board(BoardList), length(BoardList, Length), random(0, Length, Index), checkAvailblePos(Index), !, RandPos == Index.
randPosOnBoard(_).

%detect player win change depending on difficulty
detectPlayerWinChange(1):- random(X), X < 0.75.
detectPlayerWinChange(2):- random(X), X < 0.9.
detectPlayerWinChange(3).

%detect opponent win change depending on difficulty
detectNextPlayerWinChange(1):- random(X), X < 0.2.
detectNextPlayerWinChange(2):- random(X), X < 0.5.
detectNextPlayerWinChange(3):- random(X), X < 0.8.

/*Set the first ai pawn*/
%bestChange(Player, TreeDepth, AiLevel, Pos).
%if nb pawn on board of ai player = 0 and nopawn on middle case, put panw on pos13
bestChange(Player, _, _, 13):- pawnPlayerOnBoard(Player, 0), checkAvailblePos(13), !.
%if nb pawn on board of ai player = 0, put pawn on a rand case
bestChange(Player, _, _, RandPos):- pawnPlayerOnBoard(Player, 0), randPosOnBoard(RandPos),!.
/*bestChange : return the best change (move or set for a player)*/
%bestChange(Player, TreeDepth, IAL, RE, MINMAX, ALPHA, BETA, ADD)
%seek best change for next pawn, return Pos
bestChange(Player, TreeDepth, AiLevel, Pos):- bestChange(Player, TreeDepth, AiLevel, _, 1, -200, 200, Pos).
%evaluation of NextPlayer's score apart current pawn on board
bestChange(Player, 0, AiLevel, RE, _, _, _, _):- nextPlayer(Player, NextPlayer), evaluation(AiLevel, NextPlayer, RE). %condition d'arret : prondeur arbre = 0
%qu'importe profondeur d'arbre, on retroune RE en fonction de : si joueur gagne et de la détection du changement gagnant de l'adversaire en fonction de la difficulté de l'IA
bestChange(Player, _, AiLevel, RE, MINMAX, _, _, _):- winner(Player), detectNextPlayerWinChange(AiLevel), RE is (MINMAX * 100).
%qu'importe profondeur d'arbre, on retroune RE en fonction de : si joueur adverse gagne et de la détection du changement gagnant de l'ia en fonction de la difficulté de l'IA
bestChange(Player, _, AiLevel, RE, MINMAX, _, _, _):- nextPlayer(Player, NextPlayer), winner(NextPlayer), detectPlayerWinChange(AiLevel), RE is (-MINMAX * 90).
%tant que V \= 0, 
bestChange(Player, V, AiLevel, RE, MINMAX, ALPHA, BETA, ADD):- V \= 0, findall([Player, A], setOrMoveSearch(Player, A), L),
					VAL is -(1 * MINMAX * 200), change(L, V, AiLevel, LR, MINMAX, ALPHA, BETA, VAL), extractScore(LR, LV), min_or_max(MINMAX, LV, RE), nth1(_, LR, [RE|ADD]), !.			

%setOrMoveSearch : search all moves/set depending on phase
setOrMoveSearch(Player, A):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 2, !, allSetSearch(_, A).
setOrMoveSearch(Player, A):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 3, !, allSetSearch(_, A).
setOrMoveSearch(Player, A):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 4, allMoveSearch(Player, A).

%check position 0 in board
allSetSearch(_, _):- board(BoardList), allSetSearch(_, 1, BoardList).
allSetSearch(_, _, [0|_]).
allSetSearch(_, A, [_|R]):- A1 is A + 1, allSetSearch(_, A1, R).

%allMoveSearch : search all moves available for all markers of a color
allMoveSearch(Player, ToA):- playerPawnList(Player, PawnPlayerList), member(FromA, PawnPlayerList), retournPossibleMove(FromA, ToA).

retournPossibleMove(Pawn, ToA):- ToA is Pawn - 6, !, not(member(Pawn, [1, 2, 3, 4, 5, 6, 11, 16, 21])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn - 5, !, not(member(Pawn, [1, 2, 3, 4, 5])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn - 4, !, not(member(Pawn, [1, 2, 3, 4, 5, 10, 15, 20, 25])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn - 1, !, not(member(Pawn, [1, 6, 11, 16, 21])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn + 1, !, not(member(Pawn, [5, 10, 15, 20, 25])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn + 4, !, not(member(Pawn, [1, 6, 11, 16, 21, 22, 23, 24, 25])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn + 5, !, not(member(Pawn, [21, 22, 23, 24, 25])), !, checkAvailblePos(ToA).
retournPossibleMove(Pawn, ToA):- ToA is Pawn + 6, !, not(member(Pawn, [5, 10, 15, 20, 25, 21, 22, 23, 24])), !, checkAvailblePos(ToA).

% Set phase
change([[Player, A]|R], V, AiLevel, [TE|RE], MINMAX, ALPHA, BETA, VAL):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 2, !,
    setOnBoard(Player, A), nextplayer(Player, NextPlayer), V1 is V - 1, INVMINMAX is -MINMAX,
    bestChange(NextPlayer, V1, AiLevel, T, INVMINMAX, ALPHA, BETA, _), TE = [T, A], unsetOnBoard(NextPlayer, A),
	min_or_max(MINMAX, [VAL, T], NEWVAL), alphaBeta(MINMAX, NEWVAL, ALPHA, BETA, AiLevel, R, V, RE).

change([[Player, A]|R], V, AiLevel, [TE|RE], MINMAX, ALPHA, BETA, VAL):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 3, !,
    setOnBoard(Player, A), nextplayer(Player, NextPlayer), V1 is V - 1, INVMINMAX is -MINMAX,
    bestChange(NextPlayer, V1, AiLevel, T, INVMINMAX, ALPHA, BETA, _), TE = [T, A], unsetOnBoard(NextPlayer, A),
	min_or_max(MINMAX, [VAL, T], NEWVAL), alphaBeta(MINMAX, NEWVAL, ALPHA, BETA, AiLevel, R, V, RE).
	
% Move phase
change([[Player, ToA]|R], V, AiLevel, [TE|RE], MINMAX, ALPHA, BETA, VAL):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 4,
	playerPawnList(Player, PawnPlayerList), member(FromA, PawnPlayerList),
	retournPossibleMove(Player, FromA, ToA), move(FromA, ToA),
	nextplayer(Player, NextPlayer), V1 is V - 1, INVMINMAX is -MINMAX,
    bestChange(NextPlayer, V1, AiLevel, T, INVMINMAX, ALPHA, BETA, _), TE = [T, ToA],
	retournPossibleMove(Player, PreviousA, FromA), move(PreviousA, FromA),
    min_or_max(MINMAX, [VAL, T], NEWVAL), alphaBeta(MINMAX, NEWVAL, ALPHA, BETA, AiLevel, R, V, RE).
change([], _, _, [], _, _, _, _).

% check if there are a possible move and move pawn on board
move(FromA, ToA):- checkPossibleMove(Player, FromA, ToA, _), moveOnBoard(Player, FromA, ToA).

%Return min or max of the list depending on first argument
min_or_max(1, L, V) :- max_list(L, V).
min_or_max(-1, L, V) :- min_list(L, V).

%End of IA algorithm, check if an alpha or a Beta cut is possible
alphaBeta(-1, VAL, ALPHA, _, _, _, _, []) :- ALPHA >= VAL.
alphaBeta(-1, VAL, ALPHA, BETA, IAL, R, V, RE) :- min_list([BETA, VAL], BETA2), change(R, V, IAL, RE, -1, ALPHA, BETA2, VAL).
alphaBeta(1, VAL, _, BETA, _, _, _, []) :- VAL >= BETA.
alphaBeta(1, VAL, ALPHA, BETA, IAL, R, V, RE) :- max_list([ALPHA, VAL], ALPHA2), change(R, V, IAL, RE, 1, ALPHA2, BETA, VAL).

%Return all the first element of all element of first argument list
extractScore([], []):- !.
extractScore([[T|_]|R2], [T|R3]):- extractScore(R2, R3).
					
%Evaluation function when all 4 pawns of a player are on board
evaluation(_, Player, 100):- winner(Player),!.
evaluation(AiLevel, Player, -100):- AiLevel > 1, nextPlayer(Player, NextPlayer), winner(NextPlayer), !.  % only if AiLevel is not EASY.

%Evaluation function - EASY level
%if pawns player < 4 : calcNbWinSet and RE is 
evaluation(1, Player, RE):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard < 4, !,
							calcNbWinSet(Player, NbWinList, NbPawnOnBoard), RE is ((NbPawnOnBoard * NbWinList) / 2).
%calcAlignment if 4 pawns of a player are on board
evaluation(1, _, RE):- random_between(0.2, 1, NA), RE is 2 * NA.

%Evaluation function - MEDIUM level, if not 4 pawn player are on board
evaluation(2, Player, RE):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard < 4, nextPlayer(Player, NextPlayer), pawnPlayerOnBoard(NextPlayer, NbPawnOnBoard1), NbPawnOnBoard1 < 4, !,
				calcNbWinSet(Player, NbWinList, NbPawnOnBoard), calcNbWinSet(NextPlayer, NbWinList1, NbPawnOnBoard1), RE is (1.5 * NbPawnOnBoard * NbWinList - NbPawnOnBoard1 * NbWinList1).
%If each player have 4 pawns on board
evaluation(2, Player, RE):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 4, nextPlayer(Player, NextPlayer), pawnPlayerOnBoard(NextPlayer, NbPawnOnBoard), NbPawnOnBoard < 4, !,
				random_between(0.2, 1, NA), random_between(0.2, 1, NA1), RE is (6 * NA - 4 * NA1).
%else calcAlignment
evaluation(2, Player, RE):- random_between(0.2, 1, NA), nextPlayer(Player, NextPlayer), random_between(0.2, 1, NA1), pawnPlayerOnBoard(Player, NbPawnOnBoard), pawnPlayerOnBoard(NextPlayer, NbPawnOnBoard1),
				calcNbWinSet(Player, NbWinList, NbPawnOnBoard), calcNbWinSet(NextPlayer, NbWinList1, NbPawnOnBoard1), RE is (6 * NA - 4 * NA1 + NbPawnOnBoard * NbWinList - NbPawnOnBoard1 * NbWinList1).
				
%Evaluation function - HARD level, if not 4 pawn player are on board
evaluation(3, Player, RE):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 4, nextPlayer(Player, NextPlayer), pawnPlayerOnBoard(NextPlayer, NbPawnOnBoard), NbPawnOnBoard == 4, !,
				calcNbWinSet(Player, NbWinList, NbPawnOnBoard), calcNbWinSet(NextPlayer, NbWinList1, NbPawnOnBoard1), RE is (NbPawnOnBoard * NbWinList - 1.5 * NbWinList1 * NbPawnOnBoard1).
evaluation(3, Player, RE):- pawnPlayerOnBoard(Player, NbPawnOnBoard), NbPawnOnBoard == 4, nextPlayer(Player, NextPlayer), pawnPlayerOnBoard(NextPlayer, NbPawnOnBoard), NbPawnOnBoard == 4, !,
				random_between(0.2, 1, NA), random_between(0.2, 1, NA1), RE is (4 * NA - 7 * NA1).
evaluation(3, Player, RE):- random_between(0.2, 1, NA), nextPlayer(Player, NextPlayer), random_between(0.2, 1, NA2), pawnPlayerOnBoard(Player, NbPawnOnBoard), pawnPlayerOnBoard(NextPlayer, NbPawnOnBoard1),
				calcNbWinSet(Player, NbWinList, NbPawnOnBoard), calcNbWinSet(Player, NbWinList1, NbPawnOnBoard1), RE is (4 * NA - 7 * NA2 + NbPawnOnBoard * NbWinList - NbPawnOnBoard1 * NbWinList1).

%if multi pawn on one wincombo
winSearch(Player, N):- pawnPlayerOnBoard(Player, NbPawnOnBoard), playerVal(Player, Val), win(N, WinL, Val), winSearch(Player, NbPawnOnBoard, 0, WinL).
winSearch(Player, NbPawnOnBoard, CompterPawn, [Val|R]):- playerVal(Player, Val), !, CompterPawn1 is CompterPawn + 1, winSearch(Player, NbPawnOnBoard, CompterPawn1, R).
winSearch(Player, NbPawnOnBoard, CompterPawn, [_|R]):- winSearch(Player, NbPawnOnBoard, CompterPawn, R).

%return nb win set
calcNbWinSet(Player, NbWinList, _):- calcNbWinSet(Player, NbWinList, [], 44).
calcNbWinSet(_, NbWinList, WinList, 1):- length(WinList, NbWinList).
calcNbWinSet(Player, _, [N|R], N):- winSearch(Player, N),!, N1 is N - 1, calcNbWinSet(Player, R, N1).
calcNbWinSet(Player, _, [N|R], N):- N1 is N - 1, calcNbWinSet(Player,[N|R], N1).