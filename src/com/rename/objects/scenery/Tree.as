package com.rename.objects.scenery 
{
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import com.rename.Assets;
	/**
	 * ...
	 * @author Josh
	 */
	public class Tree extends Scenery
	{
		private static const trees:Array = [
			new Rectangle(0, 0, 28, 36),
			new Rectangle(28, 0, 28, 36),
			new Rectangle(56, 0, 28, 36)
		];
		
		private var sprite:Image;
		private var timer:Number;
		private const STRETCH:Number = 0.20;
		private var distance:Number;
		private var duration:Number;
		
		public function Tree(x:int = 0, y:int = 0) 
		{
			super(x, y);
			
			sprite = new Image(Assets.TREES, FP.choose(trees));
			
			sprite.originX = sprite.width / 2;
			sprite.originY = sprite.height / 2 + 8; //plus 10 so it doesn't fall through ground
			sprite.scale = 2;	//scale it to 2 times the size of the image
			
			// reset motion stuff
			timer = FP.random * Math.PI * 2;
			distance = 1 + FP.rand(10);
			duration = 0.5 + FP.random;
			
			graphic = sprite;
		}
		
	
	override public function update():void 
		{
			timer += FP.elapsed * (1 / duration);
			
			// make me move aaarrrouund
			sprite.angle = Math.sin(timer) * distance;
			sprite.scaleX = (1.0 - STRETCH / 2) + Math.abs(Math.sin(timer + Math.PI / 2) * STRETCH);
		}
		
	}

}