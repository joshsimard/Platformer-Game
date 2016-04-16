package com.rename.objects.interactables 
{
	import flash.media.Sound;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import com.rename.Assets;
	import com.rename.program.Controller;
	
	public class Coin extends Entity
	{
		public var coinSprite:Spritemap = new Spritemap(Assets.COIN, 16, 16);
		//public var pickup_coin:Sfx = new Sfx(Assets.PICKUP_COIN);
		
		public function Coin(x:int = 0, y:int = 0)
		{
			this.x = x;
			this.y = y;
			
			type = "coin";
			setHitbox(16, 16);
			
			//pickup_coin.volume = 0.1;
			
			graphic = coinSprite;
			coinSprite.add("play", [0, 1, 2], 4);
			
			coinSprite.play("play");
		}
		
		public function collect():void
		{
			//pickup_coin.play();
			Controller.incrementCoins();
		}
	}
}