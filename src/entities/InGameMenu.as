package entities 
{
	import constants.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class InGameMenu extends Entity 
	{
		private const TILDA:uint = 126;
		private const PKMN_TILDA_E:uint = 92;
		private const NEW_LINE:uint = 10;
		//treats ~ as pokemon ~e
		private const MENU_TEXT:String = "POK~DEX\n" +
		                                 "POK~MON\n" +
		                                 "ITEM\n" +
		                                 "ZACHARY\n" +
		                                 "SAVE\n" +
		                                 "OPTION\n" +
		                                 "EXIT";
										 
		
		private var _tilemap:Tilemap;
		private var _cursorPosition:uint = 0; //0-6
		
		public function InGameMenu(x:Number=0, y:Number=0) 
		{
			super(x, y);
			_tilemap = new Tilemap(Assets.MENU_SPRITES, 80, 128, 8, 8);
			this.graphic = _tilemap;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			this.setHitbox(_tilemap.width, _tilemap.height);
			setupMenu();
		}
		
		private function setupMenu():void 
		{
			// Set up frame.
			_tilemap.floodFill(0, 0, 0);
			// Corners
			_tilemap.setTile(0, 0, 1);
			_tilemap.setTile(_tilemap.columns - 1, 0, 2);
			_tilemap.setTile(0, _tilemap.rows - 1, 3);
			_tilemap.setTile(_tilemap.columns - 1, _tilemap.rows - 1, 4);
			// Borders
			_tilemap.setRect(1, 0, _tilemap.columns - 2, 1, 5);
			_tilemap.setRect(1, _tilemap.rows - 1, _tilemap.columns - 2, 1, 5);
			_tilemap.setRect(0, 1, 1, _tilemap.rows - 2, 6);
			_tilemap.setRect(_tilemap.columns - 1, 1, 1, _tilemap.rows - 2, 6);
			// Cursor
			_tilemap.setTile(1, 2, 9);
			// Text
			var columnIndex:int = 2;
			var rowIndex:int = 2;
			for (var i:int = 0; i < MENU_TEXT.length; i++)
			{
				var charCode:uint = MENU_TEXT.charCodeAt(i);
				if (charCode == NEW_LINE)
				{
					columnIndex = 2;
					rowIndex += 2;
				}
				else
				{
					if (charCode == TILDA) {
						charCode = PKMN_TILDA_E;
					}
					if (columnIndex < _tilemap.columns - 1)
					{
						_tilemap.setTile(columnIndex, rowIndex, charCode);
						columnIndex++;
					}
				}
			}
		}
		
		public function handleInput(keyCode:int):void {
			_tilemap.setTile(1, (_cursorPosition * 2) + 2, 0);
			if (keyCode == Key.UP) {
				_cursorPosition = _cursorPosition == 0 ? 6 : _cursorPosition - 1;
			}
			else if (keyCode == Key.DOWN) {
				_cursorPosition = _cursorPosition == 6 ? 0 : _cursorPosition + 1;
			}
			_tilemap.setTile(1, (_cursorPosition * 2) + 2, 9);
		}
		
	}

}