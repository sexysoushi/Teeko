/* Teeko.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/*-------------------- BOARD ------------------------------------------------------------------------*/

I : raw
J : column

I\J| 1 | 2 | 3 | 4 | 5 |
  1|
  2|
  3|
  4|
  5|


/*------------------- Player vs Player -----------------------------------------------------------------------------*/
%Definition of players. predicat player(-X, ?Y). with X, Y are elements.
player('R', 'red').
player('B', 'black').

%Definition of list of players' pawn. predicat pawn(-X, ?PawnList). with X is element, L is List.
pawn('R', [R1, R2, R3, R4]).
pawn('B', [B1, B2, B3, B4]).

%Return postion of a pawn. predicat pawnPosition(+Pawn, ?PawnList, -I, -J)
pawnPosition(_, [], _, _). %condition d'arret
pawnPosition(Pawn, [Pawn|R] I, J).
pawnPosition(Pawn, [_|R] I, J):- pawnPosition(Pawn, R, I, J).

%Return postion of all pawn of a player. predicat pawnPositionPlayer(+P, -I, -J).
%pawnsPositionPlayer([| R]):-pawn(X, L).

%Return the next player who will play. predicat nextPlayer(+X, -Y), X and Y elements.
nextPlayer(X, Y):- player(Y, _), not(Y = X).

%Ajoute pion dans la case. predicat takenSquare(+I, +J, ?L).
addPawnOnBoard( I, J, [_|[I, J]]).

%Verifie si la case est occupée. pediacat allowedMove(+I, +J). si n'est pas membre alors case pas occupé, coup autorisé
takenSquare(I, J):- takenSquare(_, _, L1), not(member([I,J], L1)).

%Coup autorisé
allowedMove(I, J):- I <= 4, I >= 4.


/*------------------ STAGE 1 : Put each pawn ---------------------------------------------------------------------*/

%Premier tour, chaque joueur pose ses pions. initBoard(-Player, +I, +J, ?PawnList).
initBoard(Player, I, J, L):-initBoard(Player, I, J, L, 8).
initBoard(_, _, _, _, 0). % condition d'arret
initBoard(Player, I, J, L, N):- N1 is N-1, player(Player, _), pawn( Player, L), takenSquare(I, J), addPawnOnBoard(I, J, _), nextPlayer(nextP, Player), initBoard(nextP, I, J, L, N1).


/*------------------ STAGE 2 : Move each pawn until own a win combo ----------------------------------------*/

% Tour par tour. turnBased(-Player, +Pawn, +I, +J).
turnBased(Player, Pawn, I, J, ).



/*------------------ Player vs AI ------------------------------------------------------------------------------*/
/* Algo MinMax with elagage AlphaBeta*/

