package com.rename.worlds {
	
	import com.rename.Assets;
	import com.rename.objects.HUD.HUDBar;
	import com.rename.objects.HUD.HUDCoinCount;
	import com.rename.objects.scenery.Background;
	import com.rename.ogmoloader.OgmoLoader;
	import com.rename.objects.interactables.physics_based.actor.Player;
	import com.rename.objects.interactables.Exit;
	import com.rename.objects.scenery.Tree;
	import com.rename.objects.scenery.Star;
	import com.rename.objects.interactables.Coin;
	import com.rename.objects.interactables.MovingPlatform;
	import com.rename.objects.particles.Dust;
	import net.flashpunk.FP;
	import net.flashpunk.World;

	public class Level extends World {
		
		public var width:int;
		public var height:int;
		private var level:int = 0;
		public static var levelNum:int = 0;
		public static var instance:Level;
		public var coins:int;
		private var HUD_bar:HUDBar;
		private var HUD_coin_count:HUDCoinCount;
		
		public function Level(level:int):void {
			this.level = level;
			levelNum = level;
			
			coins = 0;
		}	
		
		override public function begin():void { 
			instance = this;
			loadFromXML(Assets.levels[levelNum]);
		}
		
		private function loadFromXML(file:Class):void { 
			
			var background:Background = new Background();
			add(background);
			
			// Get the room size
			var xml:XML = FP.getXML(file);
			this.width = xml.@width;
			this.height = xml.@height;
			
			// Add solids to the level
			var loader:OgmoLoader = new OgmoLoader();
			loader.registerGridType("Tiles", "Solid", 16, 16);
			
			// Add tiles
			loader.registerTilemapType("Grass", Assets.GRASS_TILES, 16, 16);
			loader.registerTilemapType("Ice", Assets.ICE_TILES, 16, 16);
			
			//HUD setup
			HUD_bar = new HUDBar();
			HUD_coin_count = new HUDCoinCount();
			
			// Add objects
			loader.registerEntityType(Player);
			loader.registerEntityType(Exit);
			loader.registerEntityType(Tree);
			loader.registerEntityType(Dust);
			loader.registerEntityType(Coin);
			loader.registerEntityType(Star);
			loader.registerEntityType(MovingPlatform);
			
			// Update the level
			addList(loader.buildLevelAsArray(xml));
		}
		
		override public function render():void
		{
			super.render();
			
			//HUD setup
			HUD_bar.render();
			HUD_coin_count.render();
		}
	}
}