package com.rename.objects.interactables 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import com.rename.Assets;
	
	public class Exit extends Entity 
	{
		public var exit:Spritemap = new Spritemap(Assets.DOOR, 16, 32);
		public var doorOpened:Boolean = false;
		
		public function Exit(x:int = 0, y:int = 0)
		{
			this.x = x;
			this.y = y;
			
			setHitbox(16, 32);
			type = "exit";
			graphic = exit;
			
			layer = 5;
			
			exit.add("closed", [0]);
			exit.add("opened", [1]);
			
			exit.play("closed");
		}
		
		override public function update():void 
		{
			super.update();
			
			if (doorOpened)
			{
				exit.play("opened");
			}
		}
	}
}