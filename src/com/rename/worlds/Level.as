package com.rename.worlds {
	
	import com.rename.Assets;
	import com.rename.ogmoloader.OgmoLoader;
	import com.rename.objects.interactables.physics_based.actor.Player;
	import com.rename.objects.scenery.Tree;
	import net.flashpunk.FP;
	import net.flashpunk.World;

	public class Level extends World {
		
		public var width:int;
		public var height:int;
		private var level:int = 0;
		public static var levelNum:int = 0;
		public static var instance:Level;
		
		public function Level(level:int):void {
			this.level = level;
			levelNum = level;
		}	
		
		override public function begin():void { 
			instance = this;
			loadFromXML(Assets.levels[levelNum]);
		}
		
		private function loadFromXML(file:Class):void { 
			
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
			
			// Add objects
			loader.registerEntityType(Player);
			loader.registerEntityType(Tree);
			
			// Update the level
			addList(loader.buildLevelAsArray(xml));
		}
	}
}