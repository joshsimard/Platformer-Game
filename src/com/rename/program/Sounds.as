package com.rename.program 
{
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import com.rename.Assets;
	
	public class Sounds extends World
	{
		private static var soundfx:Sfx = null;
		
		public function Sounds() {
		}
		
		public static function playSound(curSound:String, doLoop:Boolean = false):void {
			
			//todo: Figure out howw to make theme not stop if it's the same theme.
			//todo: if you collide with enemy, sound plays on top of old sound
			
			if (soundfx != null) {
				
				if (soundfx.playing == true && curSound != "coin_sfx") {
					soundfx.stop();
				}
			}
			
			soundfx = null;
			
			switch(curSound) {
				case "main_theme":
					soundfx = new Sfx(Assets.MAIN_THEME);
					soundfx.play();
					break;
				case "ice_theme":
					soundfx = new Sfx(Assets.ICE_THEME);
					soundfx.play();
					break;
				case "grass_theme":
					soundfx = new Sfx(Assets.MAIN_THEME);
					soundfx.play();
					break;
				case "coin_sfx":
					soundfx = new Sfx(Assets.PICKUP_COIN);
					soundfx.play(0.5);
					break;
				default:
					break;
			}
			
			if (doLoop)
			{
				soundfx.loop();
			}
		}
	}
}