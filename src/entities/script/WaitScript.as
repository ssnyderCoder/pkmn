package entities.script 
{
	import entities.IScript;
	import entities.ScriptedNPC;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class WaitScript implements IScript, IScriptBuilder 
	{
		private var _ticksToWait:int;
		private var _ticksDone:int = 0;
		public function WaitScript(ticks:int=20) 
		{
			_ticksToWait = ticks;
		}
		
		/* INTERFACE entities.IScript */
		
		public function init(user:ScriptedNPC):void 
		{
			_ticksDone = 0;
		}
		
		public function update():void 
		{
			_ticksDone++;
		}
		
		public function isFinished():Boolean 
		{
			return _ticksDone >= _ticksToWait;
		}
		
		/* INTERFACE entities.script.IScriptBuilder */
		
		public function buildScript(params:Array):IScript 
		{
			//ticks to wait
			try{
				var ticks:int = ((int)(params[0]));
				return new WaitScript(ticks);
			} catch (error:Error) {
				return null;
			}
			return null;
		}
	}

}