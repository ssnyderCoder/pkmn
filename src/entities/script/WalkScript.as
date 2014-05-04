package entities.script 
{
	import constants.Direction;
	import entities.IScript;
	import entities.ScriptedNPC;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class WalkScript implements IScript 
	{
		
		private var _npc:ScriptedNPC;
		private var _direction:String;
		private var _stepsToDo:uint;
		
		private var _stepsDone:uint = 0;
		public function WalkScript(direction:String=Direction.LEFT, steps:uint=1) 
		{
			_direction = direction;
			_stepsToDo = steps;
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_npc = user;
			_stepsDone = 0;
		}
		
		public function update():void 
		{
			if (_npc.ableToMove() && _stepsDone < _stepsToDo) {
				_npc.move(_direction);
				_stepsDone++;
			}
		}
		
		public function isFinished():Boolean 
		{
			return _stepsDone >= _stepsToDo;
		}
		
	}

}