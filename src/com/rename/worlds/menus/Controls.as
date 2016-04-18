package com.rename.worlds.menus 
{
	import com.rename.worlds.Level;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Key;
	import com.rename.Assets;
	
	public class Controls extends World
	{		
		private var  bg:Backdrop;
		
		public function Controls() 
		{
			bg = new Backdrop(Assets.CONTROLS_MENU_BACKDROP);
			addGraphic(bg, 20);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed)
			{
					FP.world = new Level(0);
			}
		}
	}
}