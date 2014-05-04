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
		private var interactScript:IScript;
		private var isInteracting:Boolean = false;
		public function ScriptedNPC(tileX:uint=0, tileY:uint=0, facing:String="down", speed:uint=0, sprite:uint=0) 
		{
			super(tileX, tileY, facing, speed, sprite);
			
		}
		
		override public function update():void 
		{
			super.update();
			if (isInteracting && interactScript != null) {
				applyInteractScript();
			}
			else if (idleScript != null) {
				applyIdleScript();
			}
		}
		
		private function applyInteractScript():void 
		{
			interactScript.update();
			if (interactScript.isFinished()) {
				isInteracting = false;
			}
		}
		
		private function applyIdleScript():void 
		{
			idleScript.update();
			if (idleScript.isFinished()) {
				idleScript.init(this);
			}
		}
		
		public function setIdleScript(script:IScript):void {
			idleScript = script;
			idleScript.init(this);
		}
		
		public function setInteractScript(script:IScript):void {
			interactScript = script;
		}
		
		/* INTERFACE entities.IInteractable */
		
		public function interact():void 
		{
			interactScript.init(this);
			isInteracting = true;
		}
		
	}

}