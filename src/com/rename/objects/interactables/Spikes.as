package com.rename.objects.interactables 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import com.rename.Assets;
	
	public class Spikes extends Entity
	{
		public var spriteSpikes:Image = new Image(Assets.SPIKES);
		
		public function Spikes(x:int = 0, y:int = 0)
		{
			this.x = x;
			this.y = y;
			
			type = "enemy";
			setHitbox(16, 16);
			graphic = spriteSpikes;
		}
	}
}