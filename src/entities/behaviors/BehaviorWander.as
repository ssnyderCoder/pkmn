package entities.behaviors 
{
	import constants.Direction;
	import entities.Actor;
	import entities.IBehavior;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class BehaviorWander implements IBehavior 
	{
		private static const TICKS_PER_MOVE:int = 300;
		private static const MIN_TICK_DELAY:int = -120;
		private static const MAX_TICK_DELAY:int = 120;
		private var ticksElapsed:int = 0;
		private var additionalTickDelay:int = 0;
		
		public function BehaviorWander() 
		{
			
		}
		
		/* INTERFACE entities.IBehavior */
		
		public function act(actor:Actor):Boolean 
		{
			if (!actor.ableToMove()) {
				return false;
			}
			
			ticksElapsed++;
			if (ticksElapsed >= TICKS_PER_MOVE + additionalTickDelay) {
				actor.move(Direction.GetRandomDirection());
				restart(actor);
			}
			return true;
		}
		
		public function restart(actor:Actor):Boolean 
		{
			ticksElapsed = 0;
			additionalTickDelay = getRandomTickDelay();
			return true;
		}
		
		private function getRandomTickDelay():int
		{
			return MIN_TICK_DELAY + (int)(Math.floor(Math.random() * (MAX_TICK_DELAY - MIN_TICK_DELAY)));
		}
		
	}

}