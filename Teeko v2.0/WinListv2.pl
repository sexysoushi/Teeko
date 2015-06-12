/* WinListv2.pl - Barbara SCHIAVI & Paul Emile BRETEGNIER - IA41 UTBM 2015*/
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
winList([PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
winList([_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
winList([_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
winList([_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).		
winList([_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _
		], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _
		], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn,
			_, _, _, _, _
		], PlayerPawn).	
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn, _
		], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, PlayerPawn, PlayerPawn
		], PlayerPawn).	
		

/*--------------------------------------------------------------- Win Column ---------------------------------------------------------------*/
winList([PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _,
			PlayerPawn, _, _, _, _], PlayerPawn).
winList([_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _,
			_, PlayerPawn, _, _, _], PlayerPawn).
winList([_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, _, _], PlayerPawn).			
winList([_, _, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _,
			_, _, PlayerPawn, _, _], PlayerPawn).
winList([_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _,
			_, _, _, PlayerPawn, _], PlayerPawn).
winList([_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn,
			_, _, _, _, PlayerPawn], PlayerPawn).

		
/*--------------------------------------------------------------- Win Diago ---------------------------------------------------------------*/
winList([PlayerPawn, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, PlayerPawn], PlayerPawn).
winList([_, _, _, _, _,
			PlayerPawn, _, _, _, _,
			_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _], PlayerPawn).			
winList([_, PlayerPawn, _, _, _,
			_, _, PlayerPawn, _, _,
			_, _, _, PlayerPawn, _,
			_, _, _, _, PlayerPawn,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, PlayerPawn,
			_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _,
			PlayerPawn, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, PlayerPawn,
			_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _], PlayerPawn).
winList([_, _, _, PlayerPawn, _,
			_, _, PlayerPawn, _, _,
			_, PlayerPawn, _, _, _,
			PlayerPawn, _, _, _, _,
			_, _, _, _, _], PlayerPawn).

		
/*--------------------------------------------------------------- Win Square ---------------------------------------------------------------*/
winList([PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, PlayerPawn, PlayerPawn, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, _, _,
			_, _, _, _, _], PlayerPawn).			
winList([_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, PlayerPawn, PlayerPawn, _,
			_, _, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, _, _], PlayerPawn).			
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _,
			PlayerPawn, PlayerPawn, _, _, _], PlayerPawn).
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_,PlayerPawn, PlayerPawn, _, _,
			_, PlayerPawn, PlayerPawn, _, _], PlayerPawn).	
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _,PlayerPawn, PlayerPawn, _,
			_, _,PlayerPawn, PlayerPawn, _], PlayerPawn).	
winList([_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, _, _,
			_, _, _, PlayerPawn, PlayerPawn,
			_, _, _, PlayerPawn, PlayerPawn], PlayerPawn).	
