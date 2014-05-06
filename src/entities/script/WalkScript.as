package entities.script 
{
	import constants.Direction;
	import entities.IScript;
	import entities.ScriptedNPC;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class WalkScript implements IScript, IScriptBuilder 
	{
		
		private var _user:ScriptedNPC;
		private var _direction:String;
		private var _stepsToDo:uint;
		
		private var _prevTileX:int = 0;
		private var _prevTileY:int = 0;
		private var _stepsDone:uint = 0;
		public function WalkScript(direction:String=Direction.LEFT, steps:uint=1) 
		{
			_direction = direction;
			_stepsToDo = steps;
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_user = user;
			_stepsDone = 0;
			_prevTileX = user.tileX;
			_prevTileY = user.tileY;
		}
		
		public function update():void 
		{
			if (_prevTileX != _user.tileX || _prevTileY != _user.tileY) {
				_prevTileX = _user.tileX;
				_prevTileY = _user.tileY;
				_stepsDone++;
			}
			if (_user.ableToMove() && _stepsDone < _stepsToDo) {
				_user.move(_direction);
			}
		}
		
		public function isFinished():Boolean 
		{
			return _stepsDone >= _stepsToDo;
		}
		
		/* INTERFACE entities.script.IScriptBuilder */
		
		public function buildScript(params:Array):IScript 
		{
			//direction, steps
			try{
				var direction:String = params[0];
				var steps:uint = ((uint)(params[1]));
				return new WalkScript(direction, steps);
			} catch (error:Error) {
				return null;
			}
			return null;
		}
		
	}

}