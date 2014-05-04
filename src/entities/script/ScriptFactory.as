package entities.script 
{
	import entities.IScript;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ScriptFactory 
	{
		
		public function ScriptFactory() 
		{
			
		}
		
		public function createIdleScript(scriptText:String):IScript {
			var script:MultiScript = new MultiScript();
			//format script text
			var whiteSpaceReg:RegExp = /[\s\r\n]*/gim;
			scriptText = scriptText.replace(whiteSpaceReg, ""); //strip spaces and new lines
			var splitText:Array = scriptText.split("~")
			for each (var singleScript:String in splitText) 
			{
				var splitScript:Array = singleScript.split("^");
				var command:String = splitScript[0];
				var parameters:Array = ((String)(splitScript[1])).split("*");
				
				if (command == "walk") {
					var direction:String = parameters[0];
					var steps:uint = ((uint)(parameters[1]));
					script.addScript(new WalkScript(direction, steps));
				}
				
			}
			
			return script;
		}
		
	}

}