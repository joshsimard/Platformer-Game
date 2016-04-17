package com.rename 
{
	public class Assets 
	{
		//Levels
		[Embed(source="../../../Levels/tutorial.oel", mimeType="application/octet-stream")] public static const TUT:Class;
		[Embed(source="../../../Levels/01.oel", mimeType="application/octet-stream")] public static const LEVEL_1:Class;
		[Embed(source="../../../Levels/test.oel", mimeType="application/octet-stream")] public static const TEST:Class;
		[Embed(source="../../../Levels/IceTest.oel", mimeType="application/octet-stream")] public static const MIKE:Class;
		public static  const levels:Array = new Array(TUT);
		
		//Backdrops
		[Embed(source = "../../../Textures/Background Art/night_sky.png")] public static const SKY_NIGHT:Class;
		//[Embed(source = "../Textures/Background Art/backgroundImage.png")]public static const MAIN_MENU_BACKDROP:Class;
		
		//Scenery
		[Embed(source="../../../Textures/Scenery/Trees.png")] public static const TREES:Class;
		[Embed(source = "../../../Textures/Scenery/star.png")] public static const STAR:Class;
		//[Embed(source="../../../Textures/Scenery/moon.png")] public static const MOON:Class;
		
		//objects
		[Embed(source = "../../../Textures/Objects/door.png")] public static const DOOR:Class;
		[Embed(source = "../../../Textures/Objects/coin_map.png")] public static const COIN:Class;
		[Embed(source="../../../Textures/Objects/moving_platform.png")] public static const MOVING_PLATFORM:Class;
		/*
		[Embed(source = "../Textures/Spritemaps/woodenChest.png")]public static const WOODEN_CHEST:Class;
		[Embed(source = "../Textures/Tiles/Spikes.png")]public static const SPIKES:Class;
		[Embed(source = "../Textures/Objects/wooden_crate.png")]public static const CRATE:Class;
		[Embed(source = "../Textures/Objects/small_key.png")]public static const KEY:Class;
		
		
		//Spritemaps
		[Embed(source = "../Textures/Enemies/ghost.png")]public static const GHOST:Class;
		[Embed(source = "../Textures/Enemies/Plant.png")]public static const PLANT:Class;
		
		*/
		//Tilesets
		[Embed(source="../../../Textures/Tiles/grass_map.png")] public static const GRASS_TILES:Class;
		[Embed(source="../../../Textures/Tiles/IceWorld_Tileset.png")] public static const ICE_TILES:Class;
		

		//HUD
		[Embed(source="../../../Textures/HUD/HUD_coin_count.png")] public static const HUD_COIN_COUNT:Class;
		[Embed(source="../../../Textures/HUD/HUD_bar.png")] public static const HUD_BAR:Class;
		
		//Player
		[Embed(source="../../../res/dbg/Rectangle.png")] public static const SQUARE:Class;
		[Embed(source="../../../res/dbg/Ball.png")] public static const BALL:Class;
		
		//Effects
		[Embed(source="../../../Textures/Effects/DustTest.png")] public static const DUST:Class;
		
		/***************************************************************************************************************************************************/
		//
		//																				SOUNDS
		//
		/**************************************************************************************************************************************************/
		/*
		//Music
		[Embed(source = "../Music/Theme/9-bit Expedition.mp3")]public static const TEST_THEME:Class;
		[Embed(source="../Music/Figure Tunes/Testina 150519-181739.mp3")]public static const MAIN_THEME:Class;
		[Embed(source="../Music/Figure Tunes/Gusivysari 150519-181929.mp3")]public static const THEME1:Class;
		[Embed(source="../Music/Figure Tunes/Kove Kupi 150519-181821.mp3")]public static const THEME2:Class;
		[Embed(source="../Music/Figure Tunes/Nagapop 150519-181802.mp3")]public static const THEME3:Class;
		[Embed(source="../Music/Figure Tunes/Vulva 150519-181752.mp3")]public static const THEME4:Class;
		*/
		
		//Sound Effects
		[Embed(source="../../../Music/Pickup_Coin2.mp3")] public static const PICKUP_COIN:Class;
		
		
		
		
		/***************************************************************************************************************************************************/
		//
		//																				FONTS
		//
		/**************************************************************************************************************************************************/
		/*
		[Embed(source = "Fonts/Vlaanderen/VLAANDE1.TTF", embedAsCFF = "false", fontFamily = 'vlaand')]public static const VLAANDEREN1:Class;
		*/
	
	}

}