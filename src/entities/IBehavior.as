package entities 
{
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public interface IBehavior 
	{
		function act(actor:Actor):Boolean; //makes the actor take an action
		function restart(actor:Actor):Boolean; //resets this behavior
	}
	
}