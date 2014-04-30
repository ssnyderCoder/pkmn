package config 
{
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TrainerInfo 
	{
		public var name:String = "ZACHARY"; //only 1st seven characters shown
		public var timeInSeconds:int = 0;
		public var money:int = 0; //maxes as 99999
		public var numBadges:int = 0;
		public var hasPokemon:Boolean = false;
		public var hasPokedex:Boolean = false;
		public var hasItems:Boolean = false;
		public var canSaveGame:Boolean = true;
		public var hasTrainerCard:Boolean = true;
		private var _gameOptions:GameOptions = new GameOptions();
		
		public function get gameOptions():GameOptions 
		{
			return _gameOptions;
		}
	}

}