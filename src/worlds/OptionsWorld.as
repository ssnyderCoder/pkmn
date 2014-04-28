package worlds 
{
	import config.GameOptions;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class OptionsWorld extends World 
	{
		private var _options:GameOptions;
		private var _prevWorld:World;
		public function OptionsWorld(options:GameOptions, prevWorld:World) 
		{
			super();
			_options = options;
			_prevWorld = prevWorld;
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.ENTER))
			{
				FP.world = _prevWorld;
				return;
			}
			
			super.update();
		}
		
	}

}