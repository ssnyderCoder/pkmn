package entities.script 
{
	import entities.IScript;
	import entities.ScriptedNPC;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class MultiScript implements IScript 
	{
		private var _scripts:Array = new Array();
		private var _scriptIndex:int = 0;
		protected var _user:ScriptedNPC;
		private var _parentScript:MultiScript;
		public function MultiScript() 
		{
			
		}
		
		public function addScript(script:IScript):void {
			_scripts.push(script);
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_scriptIndex = 0;
			_user = user;
			var currentScript:IScript = _scripts[_scriptIndex];
			currentScript.init(user);
		}
		
		public function update():void 
		{
			if (_scriptIndex >= _scripts.length) {
				return;
			}
			
			var currentScript:IScript = _scripts[_scriptIndex];
			currentScript.update();
			if (currentScript.isFinished()) {
				_scriptIndex++;
				if (!isFinished()) {
					var nextScript:IScript = _scripts[_scriptIndex];
					nextScript.init(_user);
				}
			}
		}
		
		public function isFinished():Boolean 
		{
			return _scriptIndex >= _scripts.length;
		}
		
		public function get parentScript():MultiScript 
		{
			return _parentScript;
		}
		
		public function set parentScript(value:MultiScript):void 
		{
			_parentScript = value;
		}
		
	}

}