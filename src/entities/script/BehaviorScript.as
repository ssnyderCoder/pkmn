package entities.script 
{
	import entities.BehaviorFactory;
	import entities.IBehavior;
	import entities.IScript;
	import entities.ScriptedNPC;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class BehaviorScript implements IScript, IScriptBuilder 
	{
		private var _behaviorFactory:BehaviorFactory = new BehaviorFactory();
		private var _behavior:IBehavior;
		private var _user:ScriptedNPC;
		public function BehaviorScript(behaviorName:String="wander") 
		{
			_behavior = _behaviorFactory.getBehavior(behaviorName);
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_user = user;
			_behavior.restart(user);
		}
		
		public function update():void 
		{
			_behavior.act(_user);
		}
		
		public function isFinished():Boolean 
		{
			return false; //never finishes
		}
			
		/* INTERFACE entities.script.IScriptBuilder */
		
		public function buildScript(params:Array):IScript 
		{
			//behavior name
			try{
				var name:String = params[0];
				return new BehaviorScript(name);
			} catch (error:Error) {
				return null;
			}return null;
		}
		
	}

}