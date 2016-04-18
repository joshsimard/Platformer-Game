package com.rename.objects.scenery 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import com.rename.Assets;

	public class Background extends Entity
	{
		private var backdrop:Backdrop;
		
		public function Background(x:int = 0, y:int = 0) 
		{
			backdrop = new Backdrop(Assets.SKY_NIGHT, true, true);
			
			graphic = backdrop;
			
			layer = 20;
			
			super(x, y, graphic);
		}
		
		override public function update():void
		{
			backdrop.scrollX = 0.5;
			backdrop.scrollY = 2.0;
			super.update();
		}
	}
}