package worlds 
{
	import config.GameOptions;
	import constants.Assets;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class OptionsWorld extends World 
	{
		private static const NEW_LINE:uint = 10; //REFACTOR THIS INTO common class for all text-interfaces to use
		private static const BOX_TITLES:Array = ["TEXT SPEED", "BATTLE ANIMATION", "BATTLE STYLE"];
		private static const BOX_CHOICES:Array = [" FAST  MEDIUM SLOW", " ON       OFF", " SHIFT    SET"];
		private static const INDEXES_CHOICES:Array = [[0, 6, 13], [0, 9], [0, 9]];
		private static const CANCEL:String = " CANCEL";
		private static const INDEX_CANCEL:int = 0;
		
		private var _options:GameOptions;
		private var _prevWorld:World;
		private var _tilemap:Tilemap;
		public function OptionsWorld(options:GameOptions, prevWorld:World) 
		{
			super();
			_options = options;
			_prevWorld = prevWorld;
			_tilemap = new Tilemap(Assets.MENU_SPRITES, Main.WIDTH, Main.HEIGHT, 8, 8);
			setupMenu();
		}
		
		private function setupMenu():void 
		{
			// Set up frame.
			_tilemap.floodFill(0, 0, 0);
			// 3 full-width 5-height Boxes
			for (var j:int = 0; j < 3; j++) 
			{
				// Corners
				_tilemap.setTile(0, j*5, 1);
				_tilemap.setTile(_tilemap.columns - 1, j*5, 2);
				_tilemap.setTile(0, j*5 + 4, 3);
				_tilemap.setTile(_tilemap.columns - 1, j*5 + 4, 4);
				// Borders
				_tilemap.setRect(1, j*5, _tilemap.columns - 2, 1, 5);
				_tilemap.setRect(1, j*5 + 4, _tilemap.columns - 2, 1, 5);
				_tilemap.setRect(0, j*5 + 1, 1, 3, 6);
				_tilemap.setRect(_tilemap.columns - 1, j * 5 + 1, 1, 3, 6);
				// Text
				var columnIndex:int = 1;
				var rowIndex:int = j * 5 + 1;
				var text:String = BOX_TITLES[j] + "\n" + BOX_CHOICES[j];
				for (var i:int = 0; i < text.length; i++)
				{
					var charCode:uint = text.charCodeAt(i);
					if (charCode == NEW_LINE)
					{
						columnIndex = 1;
						rowIndex += 2;
					}
					else if (columnIndex < _tilemap.columns - 1)
					{
						_tilemap.setTile(columnIndex, rowIndex, charCode);
						columnIndex++;
					}
				}
			}
			addGraphic(_tilemap);
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