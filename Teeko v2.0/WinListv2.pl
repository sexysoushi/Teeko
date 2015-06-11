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

		
/*--------------------------------------------------------------- Win Di'Ago ---------------------------------------------------------------*/
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

		
/*--------------------------------------------------------------- Win Squ'Are ---------------------------------------------------------------*/
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
