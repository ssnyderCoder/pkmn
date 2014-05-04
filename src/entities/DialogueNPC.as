package entities 
{
	import constants.Direction;
	import flash.geom.Point;
	import worlds.MapWorld;
	/**
	 * An NPC that faces the character and says dialogue.
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class DialogueNPC extends Actor implements IInteractable 
	{
		protected var _dialogue:String;
		
		public function DialogueNPC(dialogue:String, tileX:uint = 0, tileY:uint = 0, facing:String = "down", speed:uint = 0, sprite:uint = 0) 
		{
			_dialogue = dialogue;
			super(tileX, tileY, facing, speed, sprite);
		}
		
		public function interact():void
		{
			var mapWorld:MapWorld = MapWorld(world);
			// If the world isn't a map world, this didn't even happen.
			if (mapWorld != null)
			{
				// Turn to look at the player.
				setFacing(Direction.GetOppositeDirection(mapWorld.player.facing));
				
				// Unable to move around while talking
				_canMove = false;
				
				// Spit some game.
				mapWorld.showDialogue(_dialogue, onMovementComplete);
			}
		}
		
	}

}