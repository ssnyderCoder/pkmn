package item 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class InvItem 
	{
		private var _id:int;
		private var _quantity:int;
		public function InvItem(id:int, quantity:int) 
		{
			_id = id;
			_quantity = quantity;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get quantity():int 
		{
			return _quantity;
		}
		
		public function set quantity(value:int):void 
		{
			_quantity = value;
		}
		
	}

}