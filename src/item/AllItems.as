package item 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class AllItems 
	{
		public static const BICYCLE:Item = new Item(0, "Bicycle").setMaxQuantity(1);
		
		private static const items:Dictionary = new Dictionary();
		{
			items[BICYCLE.id] = BICYCLE;
		}
		
		public static function getItem(id:int):Item {
			return items[id];
		}
		
	}

}