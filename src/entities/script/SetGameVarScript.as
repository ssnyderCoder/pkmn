package entities.script 
{
	import config.GameVars;
	import entities.IScript;
	import entities.ScriptedNPC;
	import worlds.MapWorld;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class SetGameVarScript implements IScript, IScriptBuilder 
	{
		private var _gameVarName:String;
		private var _value:int;
		private var _gameVars:GameVars;
		private var _user:ScriptedNPC;
		private var _done:Boolean = false;
		public function SetGameVarScript(gameVarName:String="", value:int=-1) 
		{
			_gameVarName = gameVarName;
			_value = value;
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
				var gameVars:GameVars = mapWorld.trainerInfo.gameVars;
				gameVars.setGameVar(_gameVarName, _value);
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
			//gameVarName, value
			try{
				var name:String = params[0];
				var value:int = ((int)(params[1]));
				return new SetGameVarScript(name, value);
			} catch (error:Error) {
				return null;
			}
			return null;
		}
		
	}

}