package entities 
{
	import entities.behaviors.BehaviorTwitch;
	import entities.behaviors.BehaviorWander;
	import entities.behaviors.BehaviorWatch;
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
			behaviors["wander"] = BehaviorWander;
			behaviors["twitch"] = BehaviorTwitch;
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