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
		private static const CANCEL:String = " CANCEL";
		private static const INDEX_CANCEL:int = 0;
		private static const BOX_TITLES:Array = ["TEXT SPEED", "BATTLE ANIMATION", "BATTLE STYLE"];
		private static const BOX_CHOICES:Array = [" FAST  MEDIUM SLOW", " ON       OFF", " SHIFT    SET"];
		private static const INDEXES_CHOICES:Array = [[0, 6, 13], [0, 9], [0, 9], [INDEX_CANCEL]];
		
		private var _options:GameOptions;
		private var _prevWorld:World;
		private var _tilemap:Tilemap;
		private var _configIndexes:Array = [0, 0, 0, 0];
		private var _cursorRow:int = 0;
		public function OptionsWorld(options:GameOptions, prevWorld:World) 
		{
			super();
			_options = options;
			_prevWorld = prevWorld;
			_tilemap = new Tilemap(Assets.MENU_SPRITES, Main.WIDTH, Main.HEIGHT, 8, 8);
			initConfig();
			setupMenu();
		}
		
		private function initConfig():void 
		{
			_configIndexes[0] = _options.textSpeed == GameOptions.TEXT_FAST ? 0 :
				                _options.textSpeed == GameOptions.TEXT_MEDIUM ? 1 : 2;
			_configIndexes[1] = _options.battleScene == GameOptions.SCENE_ON ? 0 : 1;
			_configIndexes[2] = _options.battleStyle == GameOptions.STYLE_SHIFT ? 0 : 1;
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
				setTileText(columnIndex, rowIndex, text);
				// Cursor
				_tilemap.setTile(1 + INDEXES_CHOICES[j][_configIndexes[j]], j*5 + 3, 8); //Cursor
				
			}
			// Cancel
			_tilemap.setTile(1, 16, 8); //Cursor
			setTileText(2, 16, CANCEL);
			
			//Current Cursor
			_tilemap.setTile(1 + INDEXES_CHOICES[_cursorRow][_configIndexes[_cursorRow]], _cursorRow*5 + 3, 9);
			addGraphic(_tilemap);
		}
		
		private function setTileText(columnIndex:int, rowIndex:int, text:String):void 
		{
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
		
		override public function update():void 
		{
			if (Input.pressed(Key.LEFT)) {
				changeSelection(-1);
			}
			else if (Input.pressed(Key.RIGHT)) {
				changeSelection(1);
			}
			else if (Input.pressed(Key.UP)) {
				changeRow(-1);
			}
			else if (Input.pressed(Key.DOWN)) {
				changeRow(1);
			}
			else if ((Input.pressed(Key.SPACE) && _cursorRow == 3) || Input.pressed(Key.ENTER))
			{
				saveChanges();
				FP.world = _prevWorld;
				return;
			}
			
			super.update();
		}
		
		private function changeRow(change:int):void 
		{
			//change previous cursor
			var rowOffset:int = _cursorRow == 3 ? 1 : 3;
			_tilemap.setTile(1 + INDEXES_CHOICES[_cursorRow][_configIndexes[_cursorRow]], _cursorRow * 5 + rowOffset, 8);
			
			_cursorRow += change;
			_cursorRow = _cursorRow < 0 ? INDEXES_CHOICES.length - 1 : _cursorRow >= INDEXES_CHOICES.length ? 0 : _cursorRow;
			
			//change new cursor
			rowOffset = _cursorRow == 3 ? 1 : 3;
			_tilemap.setTile(1 + INDEXES_CHOICES[_cursorRow][_configIndexes[_cursorRow]], _cursorRow * 5 + rowOffset, 9);
		}
		
		private function changeSelection(change:int):void 
		{
			var choices:Array = INDEXES_CHOICES[_cursorRow];
			var numChoices:int = choices.length;
			var rowOffset:int = _cursorRow == 3 ? 1 : 3;
			_tilemap.setTile(1 + choices[_configIndexes[_cursorRow]], _cursorRow * 5 + rowOffset, 0); //remove previous cursor
			
			var newIndex:int = _configIndexes[_cursorRow] + change;
			newIndex = newIndex < 0 ? numChoices - 1 : newIndex >= numChoices ? 0 : newIndex;
			_configIndexes[_cursorRow] = newIndex;
			_tilemap.setTile(1 + choices[_configIndexes[_cursorRow]], _cursorRow * 5 + rowOffset, 9); //set new cursor
			
		}
		
		private function saveChanges():void 
		{
			_options.textSpeed = _configIndexes[0] == 0 ? GameOptions.TEXT_FAST :
				                 _configIndexes[0] == 1 ? GameOptions.TEXT_MEDIUM : GameOptions.TEXT_SLOW;
			_options.battleScene = _configIndexes[1] == 0 ? GameOptions.SCENE_ON : GameOptions.SCENE_OFF;
			_options.battleStyle = _configIndexes[2] == 0 ? GameOptions.STYLE_SHIFT : GameOptions.STYLE_SET;
		}
		
	}

}