package
{
	import constants.Direction;
	import constants.Maps;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.MapWorld;
	
	[SWF(width="640",height="576",backgroundColor="#000000")]
	
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Main extends Engine
	{
		public static const WIDTH:int = 160;
		public static const HEIGHT:int = 144;
		static public const VERSION:String = "0.06";
		public function Main():void
		{
			super(160, 144, 60, true);
		}
		
		override public function init():void
		{
			FP.screen.color = 0x000000;
			FP.screen.scale = 4;
			FP.world = new MapWorld();
			super.init();
		}
	}

}