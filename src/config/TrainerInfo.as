package config 
{
	import entities.Actor;
	import flash.utils.Dictionary;
	import item.Inventory;
	import net.flashpunk.utils.Data;
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
		public var hasItems:Boolean = true;
		public var canSaveGame:Boolean = true;
		public var hasTrainerCard:Boolean = true;
		public var currentMap:String = "oregonHouse1";
		private var _gameOptions:GameOptions = new GameOptions();
		private var _inventory:Inventory = new Inventory();
		private var noSaveFile:Boolean = false; //used only for checking that a file was saved
		private var _gameVars:GameVars = new GameVars(); //used for handling events
		
		public function get gameOptions():GameOptions 
		{
			return _gameOptions;
		}
		
		public function get inventory():Inventory 
		{
			return _inventory;
		}
		
		public function get gameVars():GameVars 
		{
			return _gameVars;
		}
		
		public function save(fileName:String, player:Actor):void
		{
			Data.writeString("version", Main.VERSION);
			Data.writeString("name", name);
			Data.writeInt("time", timeInSeconds);
			Data.writeInt("money", money);
			Data.writeInt("badges", numBadges);
			Data.writeBool("hasPokemon", hasPokemon);
			Data.writeBool("hasPokedex", hasPokedex);
			Data.writeBool("hasItems", hasItems);
			Data.writeBool("canSaveGame", canSaveGame);
			Data.writeBool("hasTrainerCard", hasTrainerCard);
			
			_gameOptions.save();
			_inventory.save();
			_gameVars.save();
			
			Data.writeInt("tileX", player.tileX);
			Data.writeInt("tileY", player.tileY);
			Data.writeString("facing", player.facing);
			Data.writeString("currentMap", currentMap);
			
			Data.writeBool("noSaveFile", noSaveFile); //should always be false
			
			Data.save(fileName);
		}
		
		public function load(fileName:String, player:Actor):Boolean
		{
			Data.load(fileName);
			if (Data.readBool("noSaveFile") || Main.VERSION != Data.readString("version")) return false;
			
			name = Data.readString("name");
			timeInSeconds = Data.readInt("time");
			money = Data.readInt("money");
			numBadges = Data.readInt("badges");
			hasPokemon = Data.readBool("hasPokemon");
			hasPokedex = Data.readBool("hasPokedex");
			hasItems = Data.readBool("hasItems");
			canSaveGame = Data.readBool("canSaveGame");
			hasTrainerCard = Data.readBool("hasTrainerCard");
			
			_gameOptions.load();
			_inventory.load();
			_gameVars.load();
			
			player.tileX = Data.readInt("tileX");
			player.tileY = Data.readInt("tileY");
			player.setFacing(Data.readString("facing"));
			currentMap = Data.readString("currentMap");
			return true;
		}
	}

}