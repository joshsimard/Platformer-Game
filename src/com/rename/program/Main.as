package com.rename.program
{
	import com.rename.worlds.Level;
	import com.rename.worlds.menus.MainMenu;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.Sfx;
	import net.flashpunk.FP;
	import com.rename.Assets;
	import com.rename.program.Sounds;
	
	public class Main extends Engine
	{
		public function Main()
		{
			super(Settings.SCREEN_WIDTH, Settings.SCREEN_HEIGHT, Settings.TARGET_FPS, Settings.IS_FPS_LOCKED);
			FP.screen.scale = Settings.SCREEN_SCALE;
			
			//FP.console.enable();
		}
		
		override public function init():void 
		{
			Sounds.playSound("main_theme", true);
			FP.world = new MainMenu();
		}
	}
}