% Board Display

displayBorder() :- writeln('#####################').
displayInterLine() :- writeln('# |   |   |   |   | #').

displayBoard(Board) :- displayBoard(Board, 1).
displayBoard([T|R], N) :- N = 1, displayBorder(), displayLine(T), N1 is N +1, displayBoard(R, N1).
displayBoard([T|R], N) :- N > 1, N <= 5, displayInterLine(), displayLine(T), N1 is N + 1, displayBoard(R, N1).
displayBoard([], _) :- displayBorder().

displayLine(L) :- (L, 1).
displayLine([T|R], N) :- N = 1, write('# '), write(T), N1 is N + 1, displayLine(R, N1).
displayLine([T|R], N) :- N > 1, N <= 5, write(' - '), write(T) N1 is N + 1, displayLine(R, N1).
displayLine([], _) :- writeln(' #').

Board(
	[
		[a,b,c,d,e],
		[1,2,3,4,5],
		[f,g,h,i,j],
		[6,7,8,9,0],
		[k,l,m,n,o]
	]
).
/*
#####################
# 1   2   3   4   5 #
# |   |   |   |   | #
# 6   7   8   9   10 #
# |   |   |   |   | #
# |   |   |   |   | #
# |   |   |   |   | #
# |   |   |   |   | #
# |   |   |   |   | #
# |   |   |   |   | #
#####################
*/