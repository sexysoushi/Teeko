/* HMI.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/*------------------------------------------- BOARD ---------------------------------------------

I : raw
J : column

I\J| 1 | 2 | 3 | 4 | 5 |
  1|
  2|
  3|
  4|
  5|

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
set(Player, 'human', NexPlayer):- lastPawn(Player, Pawn), addCoordPawn(Pawn), set(Player), !.
% AI set a pawn, and turn to Player
%set(Player, 'ai', NexPlayer):- lastPawn(Player, Pawn), checkCoordPawn(Pawn), set(Player), !.

% addCoordPawn: add coordonates of each pawn
addCoordPawn(Pawn):- lastPawn(Player, Pawn), player(Player, Name), write(Name), write(', add coordonates such as "IJ." at the pawn '), writeln(Pawn),write(' : ') read(CoordPawn), checkCoord(Pawn, CoordPawn, I, J), not(pawnPosition(_, I, J)), !, setOnBoard(Pawn, I, J), nl.
addCoordPawn(Pawn):- nl, writeln(' Unavailable position. Try again !'), addCoordPawn(Pawn).

% checkCoord: check coordonates add by the player
checkCoord(_, [], _, _).
% -48 car utilisation du code ascii 
checkCoord(_, [X, Y], I, J):- I is X - 48, J is Y - 48, checkBetween(_, I, J), !. % on verifie que les coordonnees saisies sont correctes
checkCoord(Pawn, [_, _], _, _):- write('Error coordonates. Try again !'), addCoordPawn(Pawn). % sinon: renvoi sur 'getCoord'


% stage2: prediact allows stage 2 if all pawns are set on board.
stage2:- not(lastPawn('B', _)), not(lastPawn('R', _)), !, not(winner('B')), not(winner('R')).

/*----------------------------- GAME STAGE 2 : Move pawns -----------------------------------------*/


/*----------------------------- END OF GAME : haveAWinner -----------------------------------------*/

haveAWinner(Player, 'human'):- writeln(' We have a winner !!'), player(Player, Name), write(Name), writeln(' won this game !').
haveAWinner(Player, 'ai'):- writeln(' Haha sorry !! YOU LOSE. AI MACHINE is too Badass for you! Mouahahahah').