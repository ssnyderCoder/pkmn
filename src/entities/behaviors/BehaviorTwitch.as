package entities.behaviors 
{
	import constants.Direction;
	import entities.Actor;
	import entities.IBehavior;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class BehaviorTwitch implements IBehavior 
	{
		private static const TICKS_PER_ACTION:int = 15;
		private var ticksElapsed:int = 0;
		public function BehaviorTwitch() 
		{
			
		}
		
		/* INTERFACE entities.IBehavior */
		
		public function act(actor:Actor):Boolean 
		{
			ticksElapsed++;
			if(ticksElapsed >= TICKS_PER_ACTION){
				if (Math.random() < 0.75) {
					actor.setFacing(Direction.GetRandomDirection());
				}
				else {
					actor.move(Direction.GetRandomDirection());
				}
				ticksElapsed = 0;
			}
			return true;
		}
		
		public function restart(actor:Actor):Boolean 
		{
			ticksElapsed = 0;
			return true;
		}
		
	}

}