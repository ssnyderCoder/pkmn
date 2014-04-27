package entities 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class BehaviorWatch implements IBehavior 
	{
		private var direction:String;
		public function BehaviorWatch() 
		{
			direction = "down";
		}
		
		/* INTERFACE entities.IBehavior */
		
		public function act(actor:Actor):Boolean 
		{
			if (actor.ableToMove()) {
				actor.facing = direction;
			}
		}
		
		public function restart(actor:Actor):Boolean 
		{
			direction = actor.facing;
		}
		
	}

}