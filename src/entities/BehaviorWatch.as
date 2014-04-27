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
				actor.setFacing(direction);
				return true;
			}
			return false;
		}
		
		public function restart(actor:Actor):Boolean 
		{
			direction = actor.facing;
			return true;
		}
		
	}

}