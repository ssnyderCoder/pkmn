package config 
{
	import flash.utils.Dictionary;
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GameVars 
	{
		private var gameVariables:Dictionary = new Dictionary();
		public function GameVars() 
		{
			
		}
		
		public function setGameVar(name:String, value:int = 0):void {
			gameVariables[name] = value;
		}
		
		public function getGameVar(name:String):int {
			if (name in gameVariables) {
				return gameVariables[name];
			}
			return -1;
		}
		
		public function save():void 
		{
			var dataString:String = "";
			for (var keyName:String in gameVariables) {
				var value:int = gameVariables[keyName];
				dataString += keyName + "^" + value + "~";
			}
				Data.writeString("gameVars", dataString);
		}
		
		public function load():void 
		{
			var dataString:String = Data.readString("gameVars");
			var dataArray:Array = dataString.split("~");
			for (var data:String in dataArray) {
				if (data == "") {
					continue;
				}
				var splitData:Array = data.split("^");
				var keyName:String = data[0];
				var value:int = (int)(data[1]);
				gameVariables[keyName] = value;
			}
		}
		
	}

}