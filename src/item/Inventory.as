package item 
{
	import entities.Actor;
	import net.flashpunk.utils.Data;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class Inventory 
	{
		private var items:Array = new Array();
		private var _maxItems:int;
		public function Inventory(maxItems:int=16) 
		{
			_maxItems = maxItems;
			addInvItem(new InvItem(AllItems.POKEBALL.id, 75));
			addInvItem(new InvItem(AllItems.MASTERBALL.id, 1));
			addInvItem(new InvItem(AllItems.HYPER_POTION.id, 4));
			addInvItem(new InvItem(AllItems.POTION.id, 99));
			addInvItem(new InvItem(AllItems.SUPER_POTION.id, 18));
			addInvItem(new InvItem(AllItems.BICYCLE.id, 1));
		}
		
		public function get numItems():int { return items.length; }
		
		public function getInvItem(slot:int):InvItem {
			return items[slot];
		}
		
		public function setInvItem(slot:int, invItem:InvItem):void {
			items[slot] = invItem;
		}
		
		public function addInvItem(invItem:InvItem):Boolean {
			var maxQuantity:int = AllItems.getItem(invItem.id).maxQuantity;
			
			//make sure quantity not above max
			invItem.quantity = invItem.quantity > maxQuantity ? maxQuantity : invItem.quantity
			
			//look through current items for a match and add to that stack
			for each (var it:InvItem in items) 
			{
				if (it.id == invItem.id) {
					it.quantity += invItem.quantity;
					if (it.quantity > maxQuantity) {
						invItem.quantity = it.quantity - maxQuantity;
						it.quantity = maxQuantity;
					}
					else return true;
				}
			}
			if (items.length == _maxItems) return false;
			items.push(invItem);
			return true;
		}
		
		public function removeInvItem(slot:int):void {
			items.splice(slot, 1);
		}
		
		public function useItem(slot:int, world:World=null, user:Actor=null):Boolean {
			var invItem:InvItem = items[slot];
			if (invItem == null) return false;
			return AllItems.getItem(invItem.id).activate(invItem, world, user);
		}
		
		public function save():void 
		{
			var numItems:int = 0;
			for (var i:int = 0; i < items.length; i++) 
			{
				var invItem:InvItem = items[i];
				if (invItem != null) {
					Data.writeInt("itemID" + i, invItem.id);
					Data.writeInt("itemQt" + i, invItem.quantity);
					numItems++;
				}
			}
			Data.writeInt("numItems", numItems);
		}
		
		public function load():void 
		{
			var numItems:int = Data.readInt("numItems");
			for (var i:int = 0; i < numItems; i++) 
			{
				items[i] = new InvItem(Data.readInt("itemID" + i), Data.readInt("itemQt" + i));
			}
		}
		
		public function get maxItems():int 
		{
			return _maxItems;
		}
		
		public function set maxItems(value:int):void 
		{
			_maxItems = value;
		}
		
	}

}