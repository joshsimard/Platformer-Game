package com.rename.worlds {
	
	import com.rename.Assets;
	import com.rename.objects.HUD.HUDBar;
	import com.rename.objects.HUD.HUDCoinCount;
	import com.rename.objects.HUD.HUDKeyCount;
	import com.rename.objects.scenery.Background;
	import com.rename.ogmoloader.OgmoLoader;
	import com.rename.objects.interactables.physics_based.actor.Player;
	import com.rename.objects.interactables.Exit;
	import com.rename.objects.scenery.Tree;
	import com.rename.objects.scenery.Star;
	import com.rename.objects.interactables.Coin;
	import com.rename.objects.interactables.LockedDoor;
	import com.rename.objects.interactables.SmallKey;
	import com.rename.objects.interactables.Spikes;
	import com.rename.objects.interactables.MovingPlatform;
	import com.rename.objects.particles.Dust;
	import com.rename.program.Sounds;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import com.rename.program.Controller;

	public class Level extends World {
		
		public var width:int;
		public var height:int;
		private var level:int = 0;
		public static var levelNum:int = 0;
		public static var instance:Level;
		public var coins:int;
		public var keys:int;
		private var HUD_bar:HUDBar;
		private var HUD_coin_count:HUDCoinCount;
		private var HUD_key_count:HUDKeyCount;
		
		public function Level(level:int):void {
			this.level = level;
			levelNum = level;

			//keys should reset on level load
			Controller.resetKeys();
			
			coins = 0;
			keys = 0;
		}	
		
		override public function begin():void { 
			instance = this;
			loadFromXML(Assets.levels[levelNum]);
			
			//add theme to level
			selectTheme();
		}
		
		override public function render():void
		{
			super.render();
			
			//HUD setup
			HUD_bar.render();
			HUD_coin_count.render();
			HUD_key_count.render();
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
			HUD_key_count = new HUDKeyCount();
			
			// Add objects
			loader.registerEntityType(Player);
			loader.registerEntityType(Exit);
			loader.registerEntityType(Tree);
			loader.registerEntityType(Dust);
			loader.registerEntityType(Coin);
			loader.registerEntityType(Star);
			loader.registerEntityType(MovingPlatform);
			loader.registerEntityType(Spikes);
			loader.registerEntityType(SmallKey);
			loader.registerEntityType(LockedDoor);
			
			// Update the level
			addList(loader.buildLevelAsArray(xml));
		}
		
		private function selectTheme():void {
			switch(levelNum) {
				case 2:
					Sounds.playSound("ice_theme", true);
					break;
				default:
					break;
			}
		}
	}
}