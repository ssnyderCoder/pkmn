package entities 
{
	import constants.Assets;
	import constants.RenderLayers;
	import item.AllItems;
	import item.Inventory;
	import item.InvItem;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import worlds.MapWorld;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ItemBall extends Entity implements IInteractable 
	{
		private var _item:InvItem = new InvItem(0,0);
		public function ItemBall(x:Number=0, y:Number=0) 
		{
			var sprite:Spritemap = new Spritemap(Assets.CHARACTER_SPRITES, 16, 16, null);;
			sprite.frame = Assets.SPRITE_INDEX_ITEMBALL;
			
			type = "actor";
			layer = RenderLayers.ACTOR_ITEMBALL;
			super(x, y, sprite, new Hitbox(12, 12, 2, 2));
		}
		
		public function init(item:InvItem):void {
			_item = item;
		}
		
		/* INTERFACE entities.IInteractable */
		
		public function interact():void 
		{
			var itemName:String = AllItems.getItemFromID(_item.id).name;
			itemName = _item.quantity > 1 ? itemName + "S" : itemName;
			var mapWorld:MapWorld = (MapWorld(world));
			var inventory:Inventory = mapWorld.trainerInfo.inventory;
			var complete:Function;
			if (inventory.addInvItem(_item)) {
				complete = successPickup;
			}
			else {
				complete = failPickup;
			}
			mapWorld.showDialogue("You found " + _item.quantity + " " + itemName + "!", complete);
		}
		
		private function failPickup():void {
			var mapWorld:MapWorld = (MapWorld(world));
			mapWorld.showDialogue("However, your backpack was full...");
		}
		
		private function successPickup():void {
			world.recycle(this);
		}
		
	}

}