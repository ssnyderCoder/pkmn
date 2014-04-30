package item 
{
	import entities.Actor;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class Item 
	{
		private var _id:int;
		private var _name:String;
		private var _max:int = 99;
		public function Item(id:int, name:String) 
		{
			_id = id;
			_name = name;
		}
		
		public function activate(invItem:InvItem, world:World=null, user:Actor=null):Boolean {
			return false;
		}
		
		public function setMaxQuantity(max:int):Item {
			_max = max;
			return this;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get maxQuantity():int 
		{
			return _max;
		}
		
	}

}