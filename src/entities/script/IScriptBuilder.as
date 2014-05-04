package entities.script 
{
	import entities.IScript;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public interface IScriptBuilder 
	{
		function buildScript(params:Array):IScript;
	}
	
}