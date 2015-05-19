/* HMI.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/*------------------------------------------- BOARD ---------------------------------------------

| A1  | A2  | A3  | A4  | A5  |
_______________________________
| A6  | A7  | A8  | A9  | A10 |
_______________________________
| A11 | A12 | A13 | A14 | A15 |
_______________________________
| A16 | A17 | A18 | A19 | A20 |
_______________________________
| A21 | A22 | A23 | A24 | A25 |

-------------------------------------- Game Initialisation ---------------------------------------*/

:- consult('Teeko.pl'). % inclusion du fichier teeko.pl

/* Board Init, clear list, clear dynamic predicat */

/* Choose mode - Player vs Player or Player vs AI */

/* Launch game*/


/*----------------------------- GAME STAGE 1 : Set pawns -----------------------------------------*/

% Set of pawns, while all pawns are not set, nextPlayer, while nobody win
set(Player):- not(stage2), nextPlayer(Player, NextPlayer), not(winner(NextPlayer)), !, playerType(Player, Type) /*playerType sera rentré lors du choix de la partie*/, set(Player, Type, NextPlayer).
% If at the end of the stage 1 we have a winner -> end of the game
set(Player):- nextPlayer(Player, NextPlayer), winner(NextPlayer), !, haveAWinner(NextPlayer, Type).
% Player set a pawn, and turn to NextPlayer
set(Player, 'human', NexPlayer):- lastPawn(Player, Pawn), addPosPawn(Pawn), set(Player), !.
% AI set a pawn, and turn to Player
%set(Player, 'ai', NexPlayer):- lastPawn(Player, Pawn), addPosPawn(Pawn), set(Player), !.

% addCoordPawn: add coordonates of each pawn
addPosPawn(Pawn):- lastPawn(Player, Pawn), player(Player, Name), write(Name), write(', add a position such as "n." (n for number) for the pawn '), writeln(Pawn),write(' : A') read(PosPawn), checkCoord(Pawn, PosPawn, N), not(pawnPosition(_, N)), !, setOnBoard(Pawn, N), nl.
addPosPawn(Pawn):- nl, writeln(' Unavailable position. Try again !'), addCoordPawn(Pawn).

% checkPos: check position add by the player
%checkPos(_, [], _).
%  ASCII code between 1 and 25
%checkPos(_, [A], A):- I is X - 48, J is Y - 48, checkBetween(_, A), !. % check position add by the player
%checkPos(Pawn, [_, _], _, _):- write('Error position. Try again ! (dont forget the . )'), addPosPawn(Pawn). % else return to addPosPawn


% stage2: prediact allows stage 2 if all pawns are set on board.
stage2:- not(lastPawn('B', _)), not(lastPawn('R', _)), !, not(winner('B')), not(winner('R')).

/*----------------------------- GAME STAGE 2 : Move pawns -----------------------------------------*/


/*----------------------------- END OF GAME : haveAWinner -----------------------------------------*/

haveAWinner(Player, 'human'):- writeln(' We have a winner !!'), player(Player, Name), write(Name), writeln(' won this game !').
haveAWinner(Player, 'ai'):- writeln(' Haha sorry !! YOU LOSE. AI MACHINE is too Badass for you! Mouahahahah').