package worlds 
{
	import constants.Assets;
	import entities.Actor;
	import entities.menu.Dialogue;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class BattleWorld extends World 
	{
		private var _userPkmn:Entity;
		private var _oppPkmn:Entity;
		private var _dialogue:Dialogue;
		//private var _oppHP:Entity;
		//private var _userHP:Entity;
		
		public function BattleWorld() 
		{
			var backSprite:Spritemap = new Spritemap(Assets.BACK_SPRITES, 32, 32);
			backSprite.scale = 2;
			backSprite.frame = Assets.SPITE_BB_PIDGEY;
			_userPkmn = new Entity(0, 32, backSprite);
			this.add(_userPkmn);
			
			var frontSprite:Spritemap = new Spritemap(Assets.FRONT_SPRITES, 56, 56);
			frontSprite.frame = Assets.SPITE_BF_PIDGEY;
			_oppPkmn = new Entity(104, 0, frontSprite);
			this.add(_oppPkmn);
			
			this.addGraphic(new Stamp(Assets.B_ENEMY_HP), 0, 11, 10);
			this.addGraphic(new Stamp(Assets.B_PLAYER_HP), 0, 72, 66);
			showDialogue("hello");
		}
		
		/**
		 * Display dialogue to the text box.
		 * @param	dialogue The dialogue to display.
		 */
		public function showDialogue(dialogue:String, onComplete:Function = null):void
		{
			_dialogue = Dialogue(create(Dialogue, true));
			_dialogue.init(dialogue);
		}
		
		
	}

}