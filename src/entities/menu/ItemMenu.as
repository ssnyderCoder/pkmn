package entities.menu 
{
	import constants.Assets;
	import entities.Actor;
	import item.AllItems;
	import item.Inventory;
	import item.InvItem;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ItemMenu extends Entity 
	{
		private var _user:Actor;
		private var _inventory:Inventory;
		private var _tilemap:Tilemap;
		private var _cursor:int;
		private var _firstItemSlot:int;
		public function ItemMenu(x:Number=0, y:Number=0) 
		{
			super(x, y);
			_tilemap = new Tilemap(Assets.MENU_SPRITES, 128, 88, 8, 8);
			this.graphic = _tilemap;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			this.setHitbox(_tilemap.width, _tilemap.height);
		}
		
		public function init(inventory:Inventory, user:Actor):void {
			_inventory = inventory;
			_user = user;
			_cursor = 0;
			_firstItemSlot = 0;
			setupMenu();
			renderInventory();
		}
		
		
		public function handleInput(keyCode:int):void 
		{
			if (keyCode == Key.ENTER) {
				world.recycle(this);
			}
			else if (keyCode == Key.DOWN) {
				moveCursor(1);
			}
			else if (keyCode == Key.UP) {
				moveCursor(-1);
			}
		}
		
		private function moveCursor(change:int):void 
		{
			var numItems:int = _inventory.numItems;
			_cursor += change;
			if (_cursor < 0) {
				_cursor = 0;
				_firstItemSlot -= 1;
				if (_firstItemSlot < 0) {
					_firstItemSlot = numItems > 4 ? numItems - 4 : 0;
					_cursor = numItems > 4 ? 3 : numItems - 1;
				}
			}
			else if (_cursor > 3) {
				_cursor = 3;
				_firstItemSlot += 1;
				if (_firstItemSlot > numItems - 4) {
					_firstItemSlot = 0;
					_cursor = 0;
				}
			}
			else if (_cursor >= numItems) {
				_cursor = 0;
			}
			
			renderInventory();
		}
		
		private function setupMenu():void 
		{
			// Set up frame.
			_tilemap.floodFill(0, 0, 0);
			
			MenuBuilder.createBox(_tilemap, 0, 0, _tilemap.columns, _tilemap.rows);
		}
		
		private function renderInventory():void 
		{
			if (_inventory.numItems == 0) return;
			//reset 
			_tilemap.setRect(1, 1, 14, 9, 0);
			
			// Cursor
			_tilemap.setTile(1, 2 + 2 * _cursor, 9);
			
			// Text
			//get 1st 4 invItems to show
			for (var i:int = 0; i < 4; i++) 
			{
				var invItem:InvItem = _inventory.getInvItem(_firstItemSlot + i);
				if (invItem != null) {
					MenuBuilder.addText(_tilemap, AllItems.getItem(invItem.id).name, 2, 2 + 2 * i, 0);
					var quant:String = "" + invItem.quantity;
					if (quant.length == 1) quant = "0" + quant;
					MenuBuilder.addText(_tilemap, "x" + quant, 10, 3 + 2*i, 0);
				}
			}
		}
		//16 tiles wide, 11 tiles deep
		
	}

}