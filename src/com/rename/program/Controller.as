package com.rename.program 
{
	import net.flashpunk.World;
	import com.rename.objects.interactables.physics_based.actor.Player;
	/**
	 * This class is a controller for the current level (world?).
	 * 
	 * 	- Keeps track of total coins obtained in level.
	 *  - Keeps track of total keys.
	 * 	- Keep track of lives perhaps?
	 */
	public class Controller extends World
	{
		private var player:Player;
		private static var totalCoins:int;
		private static var totalKeys:int;
			
		public function Controller() 
		{
			player = Player(add(new Player()));
			totalCoins = 0;
			totalKeys = 0;
		}
		
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
		
		public static function incrementKeys():void
		{
			totalKeys++;
		}
		
		public static function decrementKeys():void
		{
			totalKeys--;
		}
		
		public static function getKeys():int
		{
			return totalKeys;
		}
	}
}