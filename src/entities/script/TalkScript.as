package entities.script 
{
	import constants.Direction;
	import entities.IScript;
	import entities.ScriptedNPC;
	import worlds.MapWorld;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TalkScript implements IScript, IScriptBuilder 
	{
		private var _dialogue:String;
		private var _user:ScriptedNPC;
		private var isDone:Boolean = false;
		private var isActive:Boolean = false;
		public function TalkScript(text:String="NONONONO") 
		{
			_dialogue = text;
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_user = user;
			isActive = false;
		}
		
		public function update():void 
		{
			if (isActive) {
				return;
			}
			var mapWorld:MapWorld = MapWorld(_user.world);
			// If the world isn't a map world, this didn't even happen.
			if (mapWorld != null)
			{
				// Turn to look at the player.
				_user.setFacing(Direction.GetOppositeDirection(mapWorld.player.facing));
				
				// Spit some game.
				mapWorld.showDialogue(_dialogue, finish);
				isActive = true;
				isDone = false;
			}
		}
		
		public function isFinished():Boolean 
		{
			return isDone;
		}
		
		private function finish():void {
			isDone = true;
		}
		
		/* INTERFACE entities.script.IScriptBuilder */
		
		public function buildScript(params:Array):IScript 
		{
			try{
				var text:String = params[0];
				return new TalkScript(text);
			} catch (error:Error) {
				return null;
			}return null;
		}
		
	}

}