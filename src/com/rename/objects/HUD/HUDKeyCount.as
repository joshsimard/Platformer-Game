package com.rename.objects.HUD 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import com.rename.program.Controller;
	import net.flashpunk.FP;
	import com.rename.Assets;
	/**
	 * A text that keeps a count of the total keys collected.
	 */
	public class HUDKeyCount extends Entity
	{
		protected var HUD_key_count:Text;
		
		public function HUDKeyCount() 
		{
			//Text.font = "vlaand";
			
			HUD_key_count = new Text("0", FP.camera.x, FP.camera.y);
			HUD_key_count.color = 0xFFFFFF;
			HUD_key_count.size = 12;
			
			graphic = HUD_key_count;
		}
		
		override public function render():void
		{
			HUD_key_count.text = "Keys: " + Controller.getKeys().toString();
			HUD_key_count.x = FP.camera.x + 250;
			HUD_key_count.y = FP.camera.y;
			
			super.render();
		}
	}
}