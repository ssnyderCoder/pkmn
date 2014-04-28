package config 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TrainerInfo 
	{
		public var name:String = "ZACHARY"; //only 1st seven characters shown
		public var hasPokemon:Boolean = false;
		public var hasPokedex:Boolean = false;
		public var hasItems:Boolean = false;
		public var canSaveGame:Boolean = false;
		public var hasTrainerCard:Boolean = false;
		private var _gameOptions:GameOptions = new GameOptions();
		
		public function get gameOptions():GameOptions 
		{
			return _gameOptions;
		}
	}

}