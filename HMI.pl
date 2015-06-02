/* HMI.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

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

-------------------------------------- Game Initialisation & GAME MODE ---------------------------------------*/

:- consult('Teeko.pl'). % inclusion of file teeko.pl
:- dynamic playerType/2. % dynamic predicat, if player is a human or ai

init:- writeln('TEEKO GAME - The best AI game to infinity and beyond...'),
	writeln('Haha, welcome ! I am Jarvis, this AI Computer.'), nl.

/* Choose mode - Player vs Player or Player vs AI */
%chose mode pvp ou pvAI
choseMode:- writeln('What would you like to do ?'),	
		writeln('1. Play against a friend'),
		writeln('2. Play against me'),
        writeln('3. Quit the application'),
        get(Mode), nl, name(Choice, [Mode]), applyMode(Choice), !.

applyMode(1):- resetAll, assert(playerType('B', 'human')), assert(playerType('R', 'human')), writeln('Ok. Have fun together. Player black begin !'), nl, !,
			launchGame.
applyMode(2):- resetAll, assert(playerType('B', 'human')), assert(playerType('R', 'ai')), writeln('Hahaha, really ? Ok. You begin.'), nl, !,
			launchGame.
applyMode(3):- writeln('See you soon buddy !'), halt, !.
applyMode(_):- writeln('Error input'), nl, choseMode.
		
% launch the game
launchGame:- board, nl, nl, % board display
        writeln('Ready ? 3, 2, 1... Let s go !'),
        placement('B'). % game begin with player Black, Rules of Teeko.

% resetPlayerType: reset dynamic predicat of playerType
resetPlayerType:- playerType('B', BType), playerType('R', RType), retract(playerType('B', BType)), retract(playerType('R', RType)).
resetPlayerType:- !.

% resetPawn: reset all pawns (dynamic predicat)
resetPawn:- findall(Pawn, positionPawn(Pawn, _), PawnList), resetPawn(PawnList).
resetPawn([]):- !.
resetPawn([T|R]):- unset(T), resetPawn(R), !.

% resetAll
resetAll:- resetPlayerType, resetPawn, clearboard.

/*----------------------------- BOARD DISPLAY -----------------------------------------*/

clearboard:- ...

board:- ...


/*----------------------------- GAME STAGE 1 : Set pawns -----------------------------------------*/

% Set of pawns, while all pawns are not set, nextPlayer, while nobody win
set(Player):- not(stage2), nextPlayer(Player, NextPlayer), not(winner(NextPlayer)), !, playerType(Player, Type) /*playerType sera rentré lors du choix de la partie*/, set(Player, Type, NextPlayer).
% If at the end of the stage 1 we have a winner -> end of the game
set(Player):- nextPlayer(Player, NextPlayer), winner(NextPlayer), !, haveAWinner(NextPlayer, Type).
% Player set a pawn, and turn to NextPlayer
set(Player, 'human', NexPlayer):- lastPawn(Player, Pawn), addPosPawn(Pawn), set(Player), !.
% AI set a pawn, and turn to Player
%set(Player, 'ai', NexPlayer):- bestChange(Player, 3, L, M, X, Y), setOnBoard(X, Y, M), placement(NexPlayer), !.

% addCoordPawn: add coordonates of each pawn
addPosPawn(Pawn):- lastPawn(Player, Pawn), player(Player, Name), write(Name), write(', add a position such as "An." (n for number) for the pawn '), writeln(Pawn),write(' : A') read(PosPawn), checkPos(Pawn, PosPawn), not(pawnPosition(_, PosPawn)), !, setOnBoard(Pawn, PosPawn), nl.
addPosPawn(Pawn):- nl, writeln(' Unavailable position. Try again !'), addCoordPawn(Pawn).

% checkPos: check position add by the player
checkPos(_, N):- between()1, 25, N), !. % check position add by the player
checkPos(Pawn, N):- write('Error position. Try again ! (dont forget the . )'), addPosPawn(Pawn). % else return to addPosPawn

% stage2: predicat allows stage 2 if all pawns are set on board.
stage2:- not(lastPawn('B', _)), not(lastPawn('R', _)), !, not(winner('B')), not(winner('R')).

/*----------------------------- GAME STAGE 2 : Move pawns -----------------------------------------*/

% movePawn: select a pawn to move and move it
movePawn(Player):- nextPlayer(Player, NextPlayer), not(winner(NextPlayer)), !, playerType(Player, Type), movePawn(Player, Type, NextPlayer).
% If at the end of the stage 2 we have a winner -> end of the game
movePawn(Player):- nextPlayer(Player, NextPlayer), winner(NextPlayer), !, haveAWinner(NextPlayer, Type).
% Player move a pawn, and turn to NextPlayer
movePawn(Player, 'human', NextPlayer):- player(Player, Name), write(Name), writeln(', chose a pawn as "2." : '), read(PawnToMove), writeln(', and add a position such as "An." (n for number) : A'), 
		read(NewPosPawn), name(NewPosPawn, NewPos), consultList(Player, NewPos), movePawn(NextPlayer), !.


%movePawn(Player, 'ai', NextPlayer):- player(Player, Name), write(Name), write(' ok let me see...'), bestChange('R', 3, L, Marker, X, Y), move(X, Y, Marker),
%       show, movePawn(NextPlayer), !.

/*----------------------------- END OF GAME : haveAWinner -----------------------------------------*/

haveAWinner(Player, 'human'):- writeln(' We have a winner !!'), player(Player, Name), write(Name), writeln(' won this game !').
haveAWinner(Player, 'ai'):- writeln(' Haha sorry !! YOU LOSE. AI MACHINE is too Badass for you! Mouahahahah ;)').

:- HMI.
