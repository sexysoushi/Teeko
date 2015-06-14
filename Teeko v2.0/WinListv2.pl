/* winListv2.pl - Barbara SCHIAVI - IA41 UTBM 2015*/
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

 -------------------------------------------------------------------------------------------------------*/
/*--------------------------------------------------------------- Win Line ---------------------------------------------------------------*/


win(1, [PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
win(2, [_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
win(3, [_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
win(4, [_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).		
win(5, [_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
win(6, [_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
win(7, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _
		], PlayerPawn).
win(8, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _
		], PlayerPawn).	
win(9, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _
		], PlayerPawn).
win(10, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn
		], PlayerPawn).	
		

/*--------------------------------------------------------------- Win Column ---------------------------------------------------------------*/
win(11, [PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(12, [_, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _], PlayerPawn).
win(13, [_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(14, [_, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _], PlayerPawn).
win(15, [_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, _, _], PlayerPawn).			
win(16, [_, _, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _], PlayerPawn).
win(17, [_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, _], PlayerPawn).
win(18, [_, _, _, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _], PlayerPawn).
win(19, [_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, _], PlayerPawn).
win(20, [_, _, _, _, _,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn], PlayerPawn).

		
/*--------------------------------------------------------------- Win Diago ---------------------------------------------------------------*/
win(21, [PlayerPawn, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, _], PlayerPawn).
win(22, [_, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, PlayerPawn], PlayerPawn).
win(23, [_, _, _, _, _,
			PlayerPawn, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _], PlayerPawn).			
win(24, [_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, PlayerPawn,
			_, _, _, _, _], PlayerPawn).
win(25, [_, _, _, _, PlayerPawn,
			_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(26, [_, _, _, _, _,
			_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _,
			PlayerPawn, _, _, _, _], PlayerPawn).
win(27, [_, _, _, _, _,
			_, _, _, _, PlayerPawn,
			_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _], PlayerPawn).
win(28, [_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _,
			PlayerPawn, _, _, _, _,
			_, _, _, _, _], PlayerPawn).

		
/*--------------------------------------------------------------- Win Square ---------------------------------------------------------------*/
win(29, [PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(30, [_, PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(31, [_, _, PlayerPawn, PlayerPawn, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(32, [_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(33, [_, _, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(34, [_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(35, [_, _, _, _, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(36, [_, _, _, _, _,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).			
win(37, [_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			_, _, _, _, _], PlayerPawn).
win(38, [_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, _, _, _, _], PlayerPawn).
win(39, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _], PlayerPawn).
win(40, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, _, _], PlayerPawn).			
win(41, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _], PlayerPawn).
win(42, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_,PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _], PlayerPawn).	
win(43, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _,PlayerPawn, PlayerPawn, _,
			_, _,PlayerPawn, PlayerPawn, _], PlayerPawn).	
win(44, [_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn], PlayerPawn).	
