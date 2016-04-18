package com.rename.objects.interactables 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import com.rename.Assets;
	import com.rename.program.Sounds;
	import com.rename.program.Controller;

	public class SmallKey extends Entity
	{
		public var keySprite:Image = new Image(Assets.KEY);
		public function SmallKey(x:int = 0, y:int = 0) 
		{
			this.x = x;
			this.y = y;
			
			x = x + 3;
			y = y - 10;
			
			setHitbox(9, 5);
			type = "key";
			graphic = keySprite;
		}
		
		public function collect():void
		{
			Sounds.playSound("key_sfx");
			Controller.incrementKeys();
		}
	}
}