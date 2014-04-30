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
		
		private static const items:Dictionary = new Dictionary();
		{
			items[BICYCLE.id] = BICYCLE;
			items[POTION.id] = POTION;
			items[SUPER_POTION.id] = SUPER_POTION;
			items[HYPER_POTION.id] = HYPER_POTION;
			items[POKEBALL.id] = POKEBALL;
			items[MASTERBALL.id] = MASTERBALL;
		}
		
		public static function getItem(id:int):Item {
			return items[id];
		}
		
	}

}