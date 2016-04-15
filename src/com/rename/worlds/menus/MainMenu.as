package com.rename.worlds.menus 
{
	import com.rename.worlds.Level;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	public class MainMenu extends World
	{
		public function MainMenu() 
		{
			
		}
		
		override public function begin():void 
		{
			
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