package com.rename.objects.particles 
{
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import com.rename.Assets;
	
	/**
	 * ...
	 * @author Josh Simard
	 */
	public class Dust extends Entity
	{
		public var spritemap:Spritemap;
		
		public function Dust(x:int, y:int)
		{
			super(x,y);
			
			this.x = x;
			this.y = y;
			
			spritemap = new Spritemap(Assets.DUST, 16, 16);

			layer = 1;
			
			graphic = spritemap;
			
			spritemap.frame = FP.rand(spritemap.frameCount);
		}
		
		override public function update():void
		{
			super.update();
			
			if (spritemap.alpha > 0)
				spritemap.alpha -= 0.1;
			else
				FP.world.remove(this);
		}
	}

}