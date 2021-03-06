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
			scriptBuilders["give"] = new GiveScript();
			scriptBuilders["look"] = new LookScript();
			scriptBuilders["wait"] = new WaitScript();
			scriptBuilders["cond"] = new ConditionalMultiScript();
			scriptBuilders["setvar"] = new SetGameVarScript();
			scriptBuilders["behavior"] = new BehaviorScript();
		}
		
		public function createScript(scriptText:String):IScript {
			try{
				var script:MultiScript = new MultiScript();
				var splitText:Array = scriptText.split("~")
				for each (var singleScript:String in splitText) 
				{
					var splitScript:Array = singleScript.split("^");
					var command:String = StringUtil.trim(splitScript[0]);
					if (command == "end") {
						script = script.parentScript;
					}
					else{
						var parameters:Array = StringUtil.trimArrayElements(((String)(splitScript[1])), "*").split("*");
						var builder:IScriptBuilder = scriptBuilders[command];
						var builtScript:IScript = builder.buildScript(parameters);
						script.addScript(builtScript);
						if (command == "cond") {
							var condScript:MultiScript = (MultiScript)(builtScript);
							condScript.parentScript = script;
							script = condScript;
						}
					}
				}
				
				return script;
			} catch (error:Error) {
				return null;
			}
			return null;
		}
		
	}

}