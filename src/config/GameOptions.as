package config 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GameOptions 
	{
		public static const TEXT_SLOW:int = 0;
		public static const TEXT_MEDIUM:int = 1;
		public static const TEXT_FAST:int = 2;
		public var textSpeed:int = TEXT_MEDIUM;
		
		public static const SCENE_ON:int = 0;
		public static const SCENE_OFF:int = 1;
		public var battleScene:int = SCENE_OFF;
		
		public static const STYLE_SET:int = 0;
		public static const STYLE_SHIFT:int = 1;
		public var battleStyle:int = STYLE_SHIFT;
	}

}