package com.rename.objects.interactables 
{
	import flash.media.Sound;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import com.rename.Assets;
	import com.rename.program.Controller;
	import com.rename.program.Sounds;
	
	public class LockedDoor extends Entity
	{
		private var doorSprite:Image = new Image(Assets.LOCKED_DOOR);
		
		public function LockedDoor(x:int = 0, y:int = 0) 
		{
			this.x = x;
			this.y = y;
			
			type = "locked_door";
			setHitbox(16, 32);
			
			layer = 2;
			
			graphic = doorSprite;
		}
	}
}