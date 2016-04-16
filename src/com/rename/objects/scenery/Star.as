package com.rename.objects.scenery 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import com.rename.Assets;
	
	public class Star extends Scenery
	{
		private var timer:Number;
		private const STRETCH:Number = 0.20;
		private var distance:Number;
		private var duration:Number;
		private var sprite:Spritemap;
		
		public function Star(x:int = 0, y:int = 0) 
		{
			super(x, y);
			
			sprite = new Spritemap(Assets.STAR, 5, 5);

			sprite.originX = sprite.width / 2;
			//sprite.originY = sprite.height / 2 + 8; //plus 10 so it doesn't fall through ground
			sprite.scale = FP.rand(2);	//scale it to 2 times the size of the image
			
			// reset motion stuff
			timer = FP.random * Math.PI * 2;
			distance = 1 + FP.rand(10);
			duration = 0.5 + FP.random;
			
			sprite.add("flux", [0, 1], 2, true);
			graphic = sprite;
			
			layer = 5;
		}
		
		override public function update():void 
		{
			timer += FP.elapsed * (1 / duration);
			
			sprite.play("flux");
			
			// make me move aaarrrouund
			sprite.angle = Math.sin(timer) * distance;
			sprite.scaleX = (1.0 - STRETCH / 2) + Math.abs(Math.sin(timer + Math.PI / 2) * STRETCH);
		}
	}
}