package entities.menu 
{
	import constants.Assets;
	import entities.Actor;
	import item.Inventory;
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
			setupMenu();
		}
		
		public function handleInput(keyCode:int):void 
		{
			if (keyCode == Key.ENTER) {
				world.recycle(this);
			}
		}
		
		private function setupMenu():void 
		{
			// Set up frame.
			_tilemap.floodFill(0, 0, 0);
			
			MenuBuilder.createBox(_tilemap, 0, 0, _tilemap.columns, _tilemap.rows);
		}
		
		//16 tiles wide, 11 tiles deep
		
	}

}