package constants 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Maps 
	{
		[Embed(source = "../../maps/test.oel", mimeType = "application/octet-stream")] public static const TEST:Class;
		[Embed(source = "../../maps/test2.oel", mimeType = "application/octet-stream")] public static const TEST2:Class;
		
		private static const maps:Dictionary = new Dictionary();
		{
			maps["test"] = TEST;
			maps["test2"] = TEST2;
		}
		
		public static function getMapData(name:String):Class {
			return maps[name];
		}
	}

}