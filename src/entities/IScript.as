package entities 
{
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public interface IScript 
	{
		function init(user:ScriptedNPC):void;
		function update():void;
		function isFinished():Boolean;
	}
	
}