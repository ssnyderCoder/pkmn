package constants
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Assets 
	{
		[Embed(source = "../../assets/tiles.png")] public static const MAP_TILES:Class;
		[Embed(source = "../../assets/characters.png")] public static const CHARACTER_SPRITES:Class;
		[Embed(source = "../../assets/menus.png")] public static const MENU_SPRITES:Class;
		
		
		public static const SPRITE_RED:uint = 0;
		public static const SPRITE_REDBIKE:uint = 1;
		public static const SPRITE_BLUE:uint = 2;
		public static const SPRITE_SCIENTIST:uint = 3;
		public static const SPRITE_SWIMMER:uint = 4;
		public static const SPRITE_MAN1:uint = 5;
		public static const SPRITE_GIRL1:uint = 6;
		public static const SPRITE_GIRL2:uint = 7;
		
		private static const spriteIDs:Dictionary = new Dictionary();
		{
			spriteIDs["red"] = SPRITE_RED;
			spriteIDs["redbike"] = SPRITE_REDBIKE;
			spriteIDs["blue"] = SPRITE_BLUE;
			spriteIDs["scientist"] = SPRITE_SCIENTIST;
			spriteIDs["swimmer"] = SPRITE_SWIMMER;
			spriteIDs["man1"] = SPRITE_MAN1;
			spriteIDs["girl1"] = SPRITE_GIRL1;
			spriteIDs["girl2"] = SPRITE_GIRL2;
		}
		
		public static function getSpriteID(spriteName:String):uint {
			return spriteIDs[spriteName];
		}
	}

}