package com.rename.program 
{
	import net.flashpunk.World;
	import com.rename.objects.interactables.physics_based.actor.Player;
	/**
	 * This class is a controller for the current level (world?).
	 * 
	 * 	- Keeps track of total coins obtained in level.
	 * 	- Keep track of lives perhaps?
	 */
	public class Controller extends World
	{
		private var player:Player;
		private static var totalCoins:int;
			
		public function Controller() 
		{
			player = Player(add(new Player()));
			totalCoins = 0;
		}
		
	/*	public function updateCoin():void
		{
			// What coins did the player collect this update?
			var collectedCoins:Vector.<Coin> = new Vector.<Coin>();
			player.collideInto("coin", player.x, player.y, collectedCoins);

			if (collectedCoins.length > 0)
			{
				// Yay player! You got some coins!
				for each (var collectedCoin:Coin in collectedCoins)
				{
					// Remove the coins, play a little song, whatever.
					collectedCoin.collect();
				}
			}
		}	*/
		
		public static function incrementCoins():void
		{
			totalCoins++;
		}
		
		public static function decrementCoins():void
		{
			totalCoins--;
		}
		
		public static function getCoins():int
		{
			return totalCoins;
		}
	}
}