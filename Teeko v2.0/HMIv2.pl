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

init:- nl, nl, writeln('TEEKO GAME - The best AI game to infinity and beyond...'),
	writeln('Haha, welcome ! I am Jarvis, this AI Computer.'), nl, choseMode.

/* Choose mode - Player vs Player or Player vs AI */
%chose mode pvp ou pvAI
choseMode:- writeln('What would you like to do ?'),	
		writeln('1. Play against a friend'),
		writeln('2. Play against me'),
		writeln('3. Me against me'),
        writeln('4. Quit the application'),
        get(Mode), nl, name(Choice, [Mode]), applyMode(Choice), !.

applyMode(1):- /*resetAll,*/ assertz(playerType('B', 'human')), assertz(playerType('R', 'human')), writeln('Ok. Have fun together. Player black begin !'), nl, !,
			launchGame.
applyMode(2):- resetAll, assertz(playerType('B', 'human')), assertz(playerType('R', 'ai')), writeln('Hahaha, really ? Ok.'), nl, !,
			getAiLevel, launchGame.
applyMode(3):- resetAll, assertz(playerType('B', 'ai')), assertz(playerType('R', 'ai')), writeln('You right, I am schizophrenic...'), nl, !,
			getAiLevel, launchGame.			
applyMode(4):- writeln('See you soon buddy !'), halt, !.
applyMode(_):- writeln('Error input. Try again !'), nl, choseMode.
				
% choseDifficult of AI Computer
getAiLevel:- writeln('I let you choose the difficulty level of my AI :'), writeln('1. EASY'), writeln('2. MEDIUM'), writeln('3. HARD'),
        get(LevelChr), nl, nl, name(Level, [LevelChr]), applyLevelChose(Level).

% applyLevelChose: apply Level Chose for AI Computer
applyLevelChose(1):- assert(choseAiLevel(1)).
applyLevelChose(2):- assert(choseAiLevel(2)).
applyLevelChose(3):- assert(choseAiLevel(3)).
applyLevelChose(_):- writeln('Error level. Try again !'), nl, getAiLevel.

% launch the game
launchGame:- /*board,*/ nl, nl, % board display
        writeln('Ready ? 3, 2, 1... Let s go !'),
        set('B'). % game begin with player Black, Rules of Teeko.

% resetPlayerType: reset dynamic predicat of playerType
resetPlayerType:- playerType('B', BType), playerType('R', RType), retract(playerType('B', BType)), retract(playerType('R', RType)).
resetPlayerType:- !.

% resetaiLevel: reset dynamic predicat of choseAiLevel
resetChoseAiLevel:- choseAiLevel(Level), !, retract(choseAiLevel(Level)).
resetChoseAiLevel:- !.

% resetAll
resetAll:- resetPlayerType, resetChoseAiLevel, clearboard.

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
set(Player, 'human', NexPlayer):- writeln('set joueur humain'), addPosPawn, set(Player), !.
% AI set a pawn, and turn to Player
set(Player, 'ai', NexPlayer):- write('Its my turn... '), choseAiLevel(L), bestChange(Player, 3, L, Pawn, A), setOnBoard(Pawn, A), placement(NexPlayer), !.

% addCoordPawn: add coordonates of each pawn
addPosPawn:- writeln('addPosPawn'), player(Player, Name), write(Name), write(', add a position such as "n." (n for number) : '), read(X), name(X, PosPawn),
		checkPos(PosPawn), !, checkAvailblePos(PosPawn), !, setOnBoard(Player, PosPawn), nl.
addPosPawn:- nl, writeln(' Unavailable position. Try again !'), addPosPawn.

% checkPos: check position add by the player
checkPos(N):- writeln('checkPos'), between(1, 25, N), !. % check position add by the player
checkPos(N):- write('Error position. Try again ! (dont forget the . )'), addPosPawn. % else return to addPosPawn

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