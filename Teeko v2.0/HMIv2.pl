/* HMI.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/* Prolog function use */
%between(+Low, +High, ?Value)
%get(-Char)
%assertz(+Term)
%retract(+Term)
%findall(+Template, :Goal, -Bag)
%not(:Goal)
%name(?Atomic, ?CodeList)
%halt
%writeln(X)
%read(-Char)
%nl

/*-------------------------------------- Game Initialisation & GAME MODE ---------------------------------------*/

:- consult('TEEKOv2.pl'). % inclusion of file teeko.pl
:- dynamic playerType/2. % dynamic predicat, if player is a human or ai
:- dynamic choseAiLevel/1. % ai level mode

/* Choose mode - Player vs Player or Player vs AI */
%init and chose mode pvp ou pvAI
init:- nl, nl, writeln('TEEKO GAME - The best AI game to infinity and beyond...'),
		writeln('Haha, welcome ! I am Jarvis, this AI Computer.'), nl,
		writeln('What would you like to do ?'),	
		writeln('1. Play against a friend'),
		writeln('2. Play against me'),
		writeln('3. Me against me'),
        writeln('4. Quit the application'),
        get(Mode), nl, name(Choice, [Mode]), applyMode(Choice).

applyMode(1):- resetAll, assertz(playerType('B', 'human')), assertz(playerType('R', 'human')), writeln('Ok. Have fun together. Player black begin !'), !,
			launchGame.
applyMode(2):- resetAll, assertz(playerType('B', 'human')), assertz(playerType('R', 'ai')), writeln('Hahaha, really ? Ok.'), !,
			getAiLevel, launchGame.
applyMode(3):- resetAll, assertz(playerType('B', 'ai')), assertz(playerType('R', 'ai')), writeln('You right, I am schizophrenic...'), !,
			getAiLevel, launchGame.			
applyMode(4):- writeln('See you soon buddy !'), halt, !.
applyMode(_):- writeln('Error input. Try again !'), nl, init.
				
% choseDifficult of AI Computer
getAiLevel:- writeln('I let you choose the difficulty level of my AI :'), writeln('1. EASY'), writeln('2. MEDIUM'), writeln('3. HARD'),
        get(LevelChr), nl, nl, name(Level, [LevelChr]), applyLevelChose(Level).

% applyLevelChose: apply Level Chose for AI Computer
applyLevelChose(1):- assert(choseAiLevel(1)).
applyLevelChose(2):- assert(choseAiLevel(2)).
applyLevelChose(3):- assert(choseAiLevel(3)).
applyLevelChose(_):- writeln('Error level. Try again !'), nl, getAiLevel.

% launch the game
launchGame:- /*board,*/ nl, % board display
        writeln('Ready ? 3, 2, 1... Let s go !'),
        set('B'). % game begin with player Black, Rules of Teeko.

% resetPlayerType: reset dynamic predicat of playerType
resetPlayerType:- playerType('B', BType), playerType('R', RType), retract(playerType('B', BType)), retract(playerType('R', RType)).
resetPlayerType:- !.

% resetaiLevel: reset dynamic predicat of choseAiLevel
resetChoseAiLevel:- choseAiLevel(Level), !, retract(choseAiLevel(Level)).
resetChoseAiLevel:- !.

% clearBoard: reset dynamic predicat of board
clearBoard:- board([0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0,
		0, 0, 0, 0, 0
		]).

% resetAll
resetAll:- resetPlayerType, resetChoseAiLevel, clearBoard.

/*----------------------------- BOARD DISPLAY -----------------------------------------*/

%clearboard:- ...

%board:- ...


/*----------------------------- GAME STAGE 1 : Set pawns -----------------------------------------*/

% Set of pawns, while all pawns are not set, nextPlayer, while nobody win
set(Player):- writeln('set1'), not(stageTwo), nextPlayer(Player, NextPlayer), not(winner(NextPlayer)), !, playerType(Player, Type), set(Player, Type, NextPlayer).
% If at the end of the stage 1 we have a winner -> end of the game
set(Player):- writeln('set2'), nextPlayer(Player, NextPlayer), winner(NextPlayer), !, haveAWinner(NextPlayer, Type).
set(Player):- writeln('set3'), move(Player).
% Player set a pawn, and turn to NextPlayer
set(Player, 'human', NexPlayer):- writeln('set joueur humain'), addPosPawn(Player), writeln('PASSE PAR LA'), set(NextPlayer), !.
% AI set a pawn, and turn to Player
set(Player, 'ai', NexPlayer):- write('Its my turn... '), choseAiLevel(AiLevel), bestChange(Player, 3, L, Pawn, A), setOnBoard(Pawn, A), set(NexPlayer), !.

% addCoordPawn: add coordonates of each pawn
addPosPawn(Player):- 
		writeln('addPosPawn'), write(Player), write(', add a position on board such as "05.", "12." or "25." : '),
		read(X), writeln(X), name(X, PosPawn), checkPos(Player, PosPawn, Pos), writeln(Pos), checkAvPos(Player, Pos), !.
addPosPawn(Player):- nl, writeln(' Unavailable position. Try again !'), addPosPawn(Player).

% checkPos: check position add by the player				
checkPos(Player, [A,B], PosNumber):- writeln('checkPos2'), A1 is A - 48, writeln(A1), B1 is B - 48, writeln(B1),
							A1 == 1, between(0, 9, B1), !, atom_concat(A1, B1, PosAtom), atom_number(PosAtom, PosNumber), writeln(PosNumber). % check position add by the player from 10 to 19
checkPos(Player, [A,B], PosNumber):- writeln('checkPos2'), A1 is A - 48, writeln(A1), B1 is B - 48, writeln(B1),
							A1 == 2, between(0, 5, B1), !, atom_concat(A1, B1, PosAtom), atom_number(PosAtom, PosNumber), writeln(PosNumber). % check position add by the player from 20 to 25
checkPos(Player, A, Pos):- writeln('checkPos2'), A1 is A - 48, writeln(A1), between(1, 9, A1), !,
							Pos is A1, writeln(Pos). % check position add by the player from 01 to 09
checkPos(Player, _):- write('Error position. Try again ! (dont forget the . )'), addPosPawn(Player). % else return to addPosPawn

checkAvPos(Player, Pos):- writeln('checkAvPos'), checkAvailblePos(Pos), !, writeln('PASSE PAR ICI'), writeln(Player), writeln(Pos), setOnBoard(Player, Pos).

% stageTwo: predicat allows stage 2 if all pawns are set on board.
stageTwo:- writeln('stageTwo'), fullBoard(NbPawnOnBoard), NbPawnOnBoard == 8, !, not(winner('B')), not(winner('R')).


/*----------------------------- GAME STAGE 2 : Move pawns -----------------------------------------*/

% movePawn: select a pawn to move and move it
move(Player):- nextPlayer(Player, NextPlayer), not(winner(NextPlayer)), !, playerType(Player, Type), move(Player, Type, NextPlayer).
% If at the end of the stage 2 we have a winner -> end of the game
move(Player):- nextPlayer(Player, NextPlayer), winner(NextPlayer), !, haveAWinner(NextPlayer, Type).
% Player move a pawn, and turn to NextPlayer
move(Player, 'human', NextPlayer):- movePawn(Player), move(NextPlayer), !.
/*
move(Player, 'ai', NextPlayer):- writeln('Its my turn, ok let me see...'), choseAiLevel(L), bestChange('R', 3, L, Pawn, A), moveOnBoard(Pawn, A), movePawn(NextPlayer), !.
*/
% movePawn
movePawn(Player):- player(Player, Name), write(Name), writeln('. write the position of pawn to move (as "n.") : '), read(X), name(X, PawnToMove),
					writeln(', and the position to move (as "n.") :'), read(Y), name(Y, NewPos), checkNewPos(Player, PawnToMove, NewPos).

checkNewPos(Player, PawnTo, NewPos):- between(1, 25, PawnTo), between(1, 25, NewPos),!, checkPawnPlayer(Player, PawnTo), !, checkPossibleMove(Player, PawnTo, NewPos). % check position and pawn add by the player
checkNewPos(Player, _, _):- write('Error Pawn or new position request. Try again ! (dont forget the . )'), movePawn(Player). % else return to addPosPawn

% checkPossibleMove : check if its a correct move of the pawn and if the case is free.
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn - 6, ToA == NewA, !, not(member(Pawn, [1, 2, 3, 4, 5, 6, 11, 16, 21])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn - 5, ToA == NewA, !, not(member(Pawn, [1, 2, 3, 4, 5])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn - 4, ToA == NewA, !, not(member(Pawn, [1, 2, 3, 4, 5, 10, 15, 20, 25])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn - 1, ToA == NewA, !, not(member(Pawn, [1, 6, 11, 16, 21])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn + 1, ToA == NewA, !, not(member(Pawn, [5, 10, 15, 20, 25])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn + 4, ToA == NewA, !, not(member(Pawn, [1, 6, 11, 16, 21, 22, 23, 24, 25])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn + 5, ToA == NewA, !, not(member(Pawn, [21, 22, 23, 24, 25])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).
checkPossibleMove(Player, Pawn, ToA):- NewA is Pawn + 6, ToA == NewA, !, not(member(Pawn, [5, 10, 15, 20, 25, 21, 22, 23, 24])), !, checkAvailblePos(NewA), moveOnBoard(Player, Pawn, NewA).

/*----------------------------- END OF GAME : haveAWinner -----------------------------------------*/

haveAWinner(Player, 'human'):- writeln(' We have a winner !!'), player(Player, Name), write(Name), writeln(' won this game !').
haveAWinner(Player, 'ai'):- writeln(' Haha sorry !! YOU LOSE. AI MACHINE is too Badass for you! Mouahahahah ;)').

:- init. %begin with game initialisation 