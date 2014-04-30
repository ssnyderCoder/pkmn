package constants 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class Maps 
	{
		[Embed(source = "../../maps/oregonHouse1.oel", mimeType = "application/octet-stream")] public static const OREGON_HOUSE_1:Class;
		[Embed(source = "../../maps/oregonPath.oel", mimeType = "application/octet-stream")] public static const OREGON_PATH:Class;
		[Embed(source = "../../maps/oregonTown.oel", mimeType = "application/octet-stream")] public static const OREGON_TOWN:Class;
		[Embed(source = "../../maps/oregonCave.oel", mimeType = "application/octet-stream")] public static const OREGON_CAVE:Class;
		
		private static const maps:Dictionary = new Dictionary();
		{
			maps["oregonHouse1"] = OREGON_HOUSE_1;
			maps["oregonPath"] = OREGON_PATH;
			maps["oregonTown"] = OREGON_TOWN;
			maps["oregonCave"] = OREGON_CAVE;
		}
		
		public static function getMapData(name:String):Class {
			return maps[name];
		}
	}

}