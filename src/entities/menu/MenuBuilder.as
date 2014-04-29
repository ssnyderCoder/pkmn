package entities.menu 
{
	import net.flashpunk.graphics.Tilemap;
	/**
	 * Helper methods for building menus and dialogues
	 * @author Sean Snyder
	 */
	public class MenuBuilder 
	{
		private static const TILDA:uint = 126;
		private static const PKMN_TILDA_E:uint = 92; //treats ~ as pokemon ~e
		private static const NEW_LINE:uint = 10;
		
		public static function createBox(tilemap:Tilemap, colStart:int, rowStart:int, width:int, height:int):void {
			// Corners
			tilemap.setTile(colStart, rowStart, 1);
			tilemap.setTile(colStart + width - 1, rowStart, 2);
			tilemap.setTile(colStart, rowStart + height - 1, 3);
			tilemap.setTile(colStart + width - 1, rowStart + height - 1, 4);
			// Borders
			tilemap.setRect(colStart + 1, rowStart, width - 2, 1, 5);
			tilemap.setRect(colStart + 1, rowStart + height - 1, width - 2, 1, 5);
			tilemap.setRect(colStart, rowStart + 1, 1, height - 2, 6);
			tilemap.setRect(colStart + width - 1, rowStart + 1, 1, height - 2, 6);
		}
		
		//lineSpace is number of blank lines between each line of text
		//returns array with [next columnIndex, final rowIndex]
		public static function addText(tilemap:Tilemap, text:String, colStart:int, rowStart:int, lineSpace:int):Array 
		{
			var columnIndex:int = colStart;
			var rowIndex:int = rowStart;
			for (var i:int = 0; i < text.length; i++)
			{
				var charCode:uint = text.charCodeAt(i);
				if (charCode == NEW_LINE)
				{
					columnIndex = colStart;
					rowIndex += lineSpace + 1;
				}
				else
				{
					if (charCode == TILDA) {
						charCode = PKMN_TILDA_E;
					}
					tilemap.setTile(columnIndex, rowIndex, charCode);
					columnIndex++;
				}
			}
			return [columnIndex, rowIndex];
		}
		
	}

}