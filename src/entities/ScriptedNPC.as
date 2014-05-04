package entities 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ScriptedNPC extends Actor implements IInteractable 
	{
		//will only have idle and interact script
		private var idleScript:IScript;
		public function ScriptedNPC(tileX:uint=0, tileY:uint=0, facing:String="down", speed:uint=0, sprite:uint=0) 
		{
			super(tileX, tileY, facing, speed, sprite);
			
		}
		
		override public function update():void 
		{
			super.update();
			if (idleScript != null) {
				applyIdleScript();
			}
		}
		
		private function applyIdleScript():void 
		{
			idleScript.update();
			if (idleScript.isFinished()) {
				idleScript.init(this);
			}
		}
		
		public function addIdleScript(script:IScript):void {
			idleScript = script;
			idleScript.init(this);
		}
		
		/* INTERFACE entities.IInteractable */
		
		public function interact():void 
		{
			
		}
		
	}

}