package item 
{
	import constants.Assets;
	import constants.Terrain;
	import entities.Actor;
	import net.flashpunk.World;
	import worlds.MapWorld;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ItemBike extends Item 
	{
		
		public function ItemBike(id:int, name:String) 
		{
			super(id, name);
		}
		
		override public function activate(invItem:InvItem, world:World = null, user:Actor = null):Boolean 
		{
			var mapWorld:MapWorld = (MapWorld(world));
			if (mapWorld != null && user != null) {
				if (mapWorld.getMap().terrain != Terrain.OUTSIDE) {
					return false;
				}
				else if(user.sprite == Assets.SPRITE_REDBIKE){
					user.sprite = Assets.SPRITE_RED;
					user.setSpeed(20);
					mapWorld.showDialogue("Got off the Bike!", mapWorld.cancelMenus)
				}
				else if(user.sprite == Assets.SPRITE_RED){
					user.sprite = Assets.SPRITE_REDBIKE;
					user.setSpeed(8);
					mapWorld.showDialogue("Used the Bike!", mapWorld.cancelMenus)
				}
				return true;
			}
			return false;
		}
		
	}

}