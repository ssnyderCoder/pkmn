package entities.script 
{
	import entities.IScript;
	import flash.utils.Dictionary;
	import mx.utils.StringUtil;
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class ScriptFactory 
	{
		private const scriptBuilders:Dictionary = new Dictionary();
		public function ScriptFactory() 
		{
			scriptBuilders["walk"] = new WalkScript();
			scriptBuilders["talk"] = new TalkScript();
		}
		
		public function createScript(scriptText:String):IScript {
			try{
				var script:MultiScript = new MultiScript();
				var splitText:Array = scriptText.split("~")
				for each (var singleScript:String in splitText) 
				{
					var splitScript:Array = singleScript.split("^");
					var command:String = StringUtil.trim(splitScript[0]);
					var parameters:Array = StringUtil.trimArrayElements(((String)(splitScript[1])), "*").split("*");
					var builder:IScriptBuilder = scriptBuilders[command];
					var builtScript:IScript = builder.buildScript(parameters);
					script.addScript(builtScript);
					
				}
				
				return script;
			} catch (error:Error) {
				return null;
			}
			return null;
		}
		
	}

}