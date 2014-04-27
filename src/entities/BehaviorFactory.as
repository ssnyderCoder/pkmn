package entities 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class BehaviorFactory 
	{
		private const behaviors:Dictionary = new Dictionary();
		
		public function BehaviorFactory() 
		{
			behaviors["watch"] = BehaviorWatch;
		}
		
		public function getBehavior(name:String):IBehavior {
			var behaviorClass:Class = behaviors[name];
			if (behaviorClass != null) {
				var behavior:IBehavior = new behaviorClass();
				return behavior;
			}
			return null;
		}
		
	}

}