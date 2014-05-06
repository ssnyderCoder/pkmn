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
	public class ConditionalMultiScript extends MultiScript implements IScriptBuilder
	{
		private var _condition:String;
		private var _value:int;
		private var _gameVars:GameVars;
		public function ConditionalMultiScript(condition:String="", value:int=-1) 
		{
			super();
			_condition = condition;
			_value = value;
		}
		
		override public function update():void 
		{
			if (_gameVars == null) {
				var mapWorld:MapWorld = MapWorld(_user.world);
				// If the world isn't a map world, this didn't even happen.
				if (mapWorld != null)
				{
					_gameVars = mapWorld.trainerInfo.gameVars;
				}
			}
			if(_gameVars.getGameVar(_condition) == _value){
				super.update();
			}
		}
		
		override public function isFinished():Boolean 
		{
			return (_gameVars != null && _gameVars.getGameVar(_condition) != _value) || super.isFinished();
		}
		
		/* INTERFACE entities.script.IScriptBuilder */
		
		public function buildScript(params:Array):IScript 
		{
			//condition, value
			try{
				var condition:String = params[0];
				var value:int = ((int)(params[1]));
				return new ConditionalMultiScript(condition, value);
			} catch (error:Error) {
				return null;
			}
			return null;
		}
		
	}

}