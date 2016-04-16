package com.rename.objects.HUD 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import com.rename.Assets;
	/**
	 * A black bar that goes on the top of the screen.
	 */
	public class HUDBar extends Entity
	{
		private var HUD_bar:Image = new Image(Assets.HUD_BAR);
		
		public function HUDBar() 
		{
			graphic = HUD_bar;
			HUD_bar.x = FP.camera.x;
			HUD_bar.y = FP.camera.y;
		}
		
		override public function render():void
		{
			HUD_bar.x = FP.camera.x;
			HUD_bar.y = FP.camera.y;
			
			super.render();
		}
	}
}