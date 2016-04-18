package com.rename.objects.HUD 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import com.rename.program.Controller;
	import net.flashpunk.FP;
	import com.rename.Assets;
	/**
	 * A text that keeps a count of the total coins collected.
	 */
	public class HUDCoinCount extends Entity
	{
		protected var HUD_coin_count:Text;
		
		public function HUDCoinCount() 
		{
			Text.font = "vlaand";
			
			HUD_coin_count = new Text("0", FP.camera.x, FP.camera.y);
			HUD_coin_count.color = 0xFFFFFF;
			HUD_coin_count.size = 12;
			
			graphic = HUD_coin_count;
		}
		
		override public function render():void
		{
			HUD_coin_count.text = "Coins: " + Controller.getCoins().toString();
			HUD_coin_count.x = FP.camera.x;
			HUD_coin_count.y = FP.camera.y;
			
			super.render();
		}
	}
}