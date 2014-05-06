package entities.script 
{
	import constants.Direction;
	import entities.IScript;
	import entities.ScriptedNPC;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class LookScript implements IScript, IScriptBuilder 
	{
		
		private var _user:ScriptedNPC;
		private var _done:Boolean = false;
		private var _direction:String;
		public function LookScript(direction:String=Direction.LEFT) 
		{
			_direction = direction;	
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
			if (_user.ableToMove()) {
				_user.setFacing(_direction);
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
			//direction
			try{
				var direction:String = params[0];
				return new LookScript(direction);
			} catch (error:Error) {
				return null;
			}
			return null;
		}
	}

}