package entities.script 
{
	import entities.IScript;
	import entities.ScriptedNPC;
	import item.AllItems;
	import item.Inventory;
	import item.InvItem;
	import worlds.MapWorld;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GiveScript implements IScript, IScriptBuilder 
	{
		
		private var _user:ScriptedNPC;
		private var _item:InvItem;
		private var _done:Boolean = false;
		public function GiveScript(item:InvItem=null) 
		{
			_item = item;
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_user = user;
			_done = false;
		}
		
		public function update():void 
		{
			if (_done) {
				return;
			}
			
			var mapWorld:MapWorld = MapWorld(_user.world);
			// If the world isn't a map world, this didn't even happen.
			if (mapWorld != null)
			{
				var playerInventory:Inventory = mapWorld.trainerInfo.inventory;
				playerInventory.addInvItem(_item.clone());
				_done = true;
			}
		}
		
		public function isFinished():Boolean 
		{
			return _done;
		}
			
			
		/* INTERFACE entities.script.IScriptBuilder */
		
		public function buildScript(params:Array):IScript 
		{
			//item name, quantity
			try {
				var itemName:String = params[0];
				var itemID:int = AllItems.getItemFromName(itemName).id;
				var quantity:int = (int)(params[1]);
				return new GiveScript(new InvItem(itemID, quantity));
			} catch (error:Error) {
				return null;
			}return null;
		}
		
	}

}