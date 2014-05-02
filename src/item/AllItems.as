package item 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class AllItems 
	{
		public static const BICYCLE:Item = new ItemBike(0, "BICYCLE").setMaxQuantity(1);
		public static const POTION:Item = new Item(1, "POTION");
		public static const SUPER_POTION:Item = new Item(2, "SUPER POTION");
		public static const HYPER_POTION:Item = new Item(3, "HYPER POTION");
		public static const POKEBALL:Item = new Item(4, "POKE BALL");
		public static const MASTERBALL:Item = new Item(5, "MASTER BALL");
		public static const ANTIDOTE:Item = new Item(6, "ANTIDOTE");
		
		private static const ITEMS_ID:Dictionary = new Dictionary();
		private static const ITEMS_NAME:Dictionary = new Dictionary();
		{
			addItem(BICYCLE);
			addItem(POTION);
			addItem(SUPER_POTION);
			addItem(HYPER_POTION);
			addItem(POKEBALL);
			addItem(MASTERBALL);
			addItem(ANTIDOTE);
		}
		
		private static function addItem(itemToAdd:Item):void {
			ITEMS_ID[itemToAdd.id] = itemToAdd;
			ITEMS_NAME[itemToAdd.name] = itemToAdd;
		}
		
		public static function getItemFromID(id:int):Item {
			return ITEMS_ID[id];
		}
		
		public static function getItemFromName(name:String):Item {
			return ITEMS_NAME[name];
		}
		
	}

}