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
			var script:IScript;
			//format script text
			var whiteSpaceReg:RegExp = /[\s\r\n]*/gim;
			scriptText = scriptText.replace(whiteSpaceReg, ""); //strip spaces and new lines
			var splitText:Array = scriptText.split(":");
			var command:String = splitText[0];
			var parameters:Array = ((String)(splitText[1])).split(",");
			
			if (command == "walk") {
				var direction:String = parameters[0];
				var steps:uint = ((uint)(parameters[1]));
				script = new WalkScript(direction, steps);
			}
			return script;
		}
		
	}

}