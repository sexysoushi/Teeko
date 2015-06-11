/* AI.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/

/* Prolog function use */
%findall(+Template, :Goal, -Bag)
%not(:Goal)
%length(?List, ?Int)
%dif(@A, @B) : succed if A and B are different
%setof(+Template, +Goal, -Set)
%random(-R:float)
%round(+Expr) : Evaluate Expr and round the result to the nearest integer.

/*-------------------------------- Algo MinMax with elagage AlphaBeta -------------------------------------------------*/

%calcule le nombre de pions places pour une couleur donnee. Retourne egalement la liste des positions correspondantes aux pions.
nbPawnOnBoard(C,N,L2):- findall(A, (pawnList(C, L), member(P,L), pawnPosition(P,A)),L2), length(L2, N).

%detect player win change depending on difficulty
detectPlayerWinChange(1) :- random(X), X < 0.75.
detectPlayerWinChange(2) :- random(X), X < 0.9.
detectPlayerWinChange(3).

%detect opponent win change depending on difficulty
detectOpponentWinChange(1) :- random(X), X < 0.2.
detectOpponentWinChange(2) :- random(X), X < 0.5.
detectOpponentWinChange(3) :- random(X), X < 0.8.

% position 13 is the middle case of the board, so this bestChange predicat depends only on this case
bestChange(C, _, _, M,13):- nbPawnOnBoard(C,0, _), not(pawnPosition(_, 13)), lastPawn(C, M),!. %Set on middle case 13 AI pawn if its free
bestChange(C, _, _, M,A):- nbPawnOnBoard(C,0, _), lastPawn(C, M), random(RndX), random(RndY), X is 2 + 2 * round(RndX), Y is 2 + 2 * round(RndY),!.
bestChange(C, L, IAL, M, A) :- bestChange(C, L, IAL, _, 1, -200, 200, [M, X, Y]).

%bestChange : return the best change (move or set for a player)
bestChange(C, 0, L, X, _, _, _, _) :- flipPlayer(C, C1), eval(L, C1, X).
bestChange(C, _, L, X, MINMAX, _, _, _) :- winner(C), detectOpponentWinChange(L), X is MINMAX*100.
bestChange(C, _, L, X, MINMAX, _, _, _) :- flipPlayer(C, C2), winner(C2), detectPlayerWinChange(L), X is -1*MINMAX*90.
bestChange(C, V, IAL, RE, MINMAX, ALPHA, BETA, ADD) :- dif(V, 0), findall([C, M, X, Y], calcAll(C, M, X, Y), L), VAL is -1 * MINMAX * 200, change(L, V, IAL, LR, MINMAX, ALPHA, BETA, VAL), extractScore(LR, LV), min_or_max(MINMAX, LV, RE), nth1(_, LR, [RE|ADD]), !.

%Main part of the algorithm
%Depending on phase of game (first or second)
change([[C, M, X, Y]|R], V, IAL, [TE|RE], MINMAX, ALPHA, BETA, VAL) :-
    lastPawn(C, M),
    set(X, Y, M), flipPlayer(C, C2), V1 is V - 1, INVMINMAX is -1 * MINMAX,
    bestChange(C2, V1, IAL, T, INVMINMAX, ALPHA, BETA, _), TE = [T, M, X, Y], unset(M),
    min_or_max(MINMAX, [VAL, T], NEWVAL), alphaBeta(MINMAX, NEWVAL, ALPHA, BETA, IAL, R, V, RE).
change([[C, M, X, Y]|R], V, IAL, [TE|RE], MINMAX, ALPHA, BETA, VAL) :-
    not(lastPawn(C, M)),
    position(FROMX, FROMY, M), move(X, Y, M), flipPlayer(C, C2), V1 is V - 1, INVMINMAX is -1 * MINMAX,
    bestChange(C2, V1, IAL, T, INVMINMAX, ALPHA, BETA, _), TE = [T, M, X, Y], move(FROMX, FROMY, M),
    min_or_max(MINMAX, [VAL, T], NEWVAL), alphaBeta(MINMAX, NEWVAL, ALPHA, BETA, IAL, R, V, RE).
change([], _, _, [], _, _, _, _).

%End of IA algorithm, check if an alpha or a Beta cut is possible
alphaBeta(-1, VAL, ALPHA, _, _, _, _, []) :- ALPHA >= VAL.
alphaBeta(-1, VAL, ALPHA, BETA, IAL, R, V, RE) :- min_list([BETA, VAL], BETA2), change(R, V, IAL, RE, -1, ALPHA, BETA2, VAL).
alphaBeta(1, VAL, _, BETA, _, _, _, []) :- VAL >= BETA.
alphaBeta(1, VAL, ALPHA, BETA, IAL, R, V, RE) :- max_list([ALPHA, VAL], ALPHA2), change(R, V, IAL, RE, 1, ALPHA2, BETA, VAL).

%fonction d'evaluation
eval(_,C,100):- winner(C),!.
eval(D,C,-100):- D > 1, flipPlayer(C,C1), winner(C1),!.  %uniquement si le joueur n'a pas choisi le mode facile

%evaluation en mode facile
eval(1,C,N):- nbPawnOnBoard(C, NbMC, LMC), NbMC<4, !, calcNbWinSet(C,NWS, NbMC, LMC), N is (NbMC*NWS/2).
eval(1,C,N):- calcAlignment(C,NA), N is 2*NA.

%evaluation en mode moyen
eval(2,C,N):- nbPawnOnBoard(C, NbMC, LMC), NbMC<4, flipPlayer(C,C1),nbPawnOnBoard(C1, NbMC1, LMC1), NbMC1<4, !, calcNbWinSet(C,NWS, NbMC, LMC), calcNbWinSet(C1,NWS1, NbMC1, LMC1), N is (1.5*NbMC*NWS - NbMC1*NWS1).
eval(2,C,N):- nbPawnOnBoard(C, 4, _), flipPlayer(C,C1),nbPawnOnBoard(C1, 4, _), !,calcAlignment(C,NA), calcAlignment(C1,NA2), N is (6*NA - 4*NA2).
eval(2,C,N):- calcAlignment(C,NA), flipPlayer(C,C1), calcAlignment(C1,NA2), nbPawnOnBoard(C, NbMC, LMC),nbPawnOnBoard(C1, NbMC1, LMC1),calcNbWinSet(C,NWS, NbMC, LMC), calcNbWinSet(C1,NWS1, NbMC1, LMC1), N is (6*NA - 4*NA2 + NbMC*NWS - NbMC1*NWS1).

%evaluation en mode difficile
eval(3,C,N):- nbPawnOnBoard(C, NbMC, LMC), NbMC<4, flipPlayer(C,C1),nbPawnOnBoard(C1, NbMC1, LMC1), NbMC1<4, !, calcNbWinSet(C,NWS, NbMC, LMC), calcNbWinSet(C1,NWS1, NbMC1, LMC1), N is (NbMC*NWS - 1.5*NbMC1*NWS1).
eval(3,C,N):- nbPawnOnBoard(C, 4, _), flipPlayer(C,C1),nbPawnOnBoard(C1, 4, _), !,calcAlignment(C,NA), calcAlignment(C1,NA2), N is (4*NA - 7*NA2).
eval(3,C,N):- calcAlignment(C,NA), flipPlayer(C,C1), calcAlignment(C1,NA2), nbPawnOnBoard(C, NbMC, LMC),nbPawnOnBoard(C1, NbMC1, LMC1),calcNbWinSet(C,NWS, NbMC, LMC), calcNbWinSet(C1,NWS1, NbMC1, LMC1), N is (4*NA - 7*NA2 + NbMC*NWS - NbMC1*NWS1).

%Calcule le nombre de pions alignes pour une couleur donnee (et verifie si les cases necessitant des pions pour gagner ne sont pas occupees par les pions de l'adversaire).
calcAlignment(C,N):- positions(C, _, _, X2, Y2, X3, Y3, X4, Y4), winner(X, Y, X2, Y2, X3, Y3, X4, Y4), inRange([X,Y], 1, 5), checkEmptyCase(X,Y,EC),!, N is 3*EC.
calcAlignment(C,N):- positions(C, X1, Y1, _, _, X3, Y3, X4, Y4), winner(X1, Y1, X, Y, X3, Y3, X4, Y4), inRange([X,Y], 1, 5), checkEmptyCase(X,Y,EC),!, N is 3*EC.
calcAlignment(C,N):- positions(C, X1, Y1, X2, Y2, _, _, X4, Y4), winner(X1, Y1, X2, Y2, X, Y, X4, Y4), inRange([X,Y], 1, 5), checkEmptyCase(X,Y,EC),!, N is 3*EC.
calcAlignment(C,N):- positions(C, X1, Y1, X2, Y2, X3, Y3, _, _), winner(X1, Y1, X2, Y2, X3, Y3, X, Y), inRange([X,Y], 1, 5), checkEmptyCase(X,Y,EC),!, N is 3*EC.
calcAlignment(_,0).

%Verifie que la case ayant les coordonnee (X,Y) est vide.
checkEmptyCase(X,Y,1):- not(position(X,Y,_)),!.
checkEmptyCase(_,_,0.2).

%calcule le nombre de positions gagnantes possible avec les pions qu'il reste a placer
calcNbWinSet(C,T, N, L):- N<4, flipPlayer(C1,C), calcPositions(4,L,[X1, Y1, X2, Y2, X3, Y3, X4, Y4]), setof([[X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4]], (winner(X1, Y1, X2, Y2, X3, Y3, X4, Y4), inRange([X1, Y1, X2, Y2, X3, Y3, X4, Y4], 1, 5), noOpponentMarker(C1,[X1, Y1, X2, Y2, X3, Y3, X4, Y4])), L2),deleteDouble(L2,L3), length(L3, T),!.
calcNbWinSet(_,0,_,_).

%forme une liste contenant les positions de N pions, en utilisants les coordonnees des pions passes en parametre. Utilise ensuite des variables anonymes si le nombre de pions passes en parametre est inferieur a N.
calcPositions(0, _, []):-!.
calcPositions(N, [], [_,_|R]):- N1 is N-1, calcPositions(N1, [], R),!.
calcPositions(N, [[X,Y]|R], [X,Y|R2]):-  N1 is N-1, calcPositions(N1, R, R2).

%Verifie que les positions contenues dans la liste ne sont pas occupees par les pions du joueur C
noOpponentMarker(_,[]):- !.
noOpponentMarker(C,[X,Y|R]):- markers(C,[C1,C2,C3,C4]),not(position(X,Y,C1)),not(position(X,Y,C2)),not(position(X,Y,C3)),not(position(X,Y,C4)), noOpponentMarker(C,R).

%supprime les doublons (deux placements sont consideres comme identiques si le seul changement est la permutation des pions entre eux)
deleteDouble([],[]):-!.
deleteDouble([T|R],R2):- member(T2,R), calcDouble(T,T2), deleteDouble(R,R2),!.
deleteDouble([T|R],[T|R2]):-deleteDouble(R,R2).

%verifie si deux placements sont identiques
calcDouble([],_):-!.
calcDouble([T|R],L):-member(T,L),calcDouble(R,L).