/**
 * Created by zachwlewis on 2/22/14.
 */
package entities.menu
{
import config.GameOptions;
import constants.Assets;
import constants.GC;
import constants.RenderLayers;
import entities.menu.MenuBuilder;
import net.flashpunk.Entity;
import net.flashpunk.graphics.Tilemap;
import net.flashpunk.utils.Key;

public class Dialogue extends Entity
{
	private var _tilemap:Tilemap;
	private var _text:String;
	
	private var _characterIndex:uint = 0;
	private var _columnIndex:uint = 1;
	private var _rowIndex:uint = 2;
	private var _paused:Boolean = false;
	private var _textTick:uint = 0;
	private var _dialogueComplete:Function;
	
	private var textSpeed:uint;
	
	private static const MAX_LINE_LENGTH:uint = 17;

	public function Dialogue()
	{
		_tilemap = new Tilemap(Assets.MENU_SPRITES, 160, 48, 8, 8);
		_tilemap.x = 0;
		_tilemap.y = 96;
		_tilemap.scrollX = 0;
		_tilemap.scrollY = 0;
		
		// Set up frame.
		_tilemap.floodFill(0, 0, 0);
		
		MenuBuilder.createBox(_tilemap, 0, 0, _tilemap.columns, _tilemap.rows);
		
		// Pause the dialogue until it has been initialized with text.
		_paused = true;
		
		layer = RenderLayers.DIALOGUE;
		
		super(0, 0, _tilemap);
	}
	
	public function handleInput(key:int):void {
		if (key == Key.SPACE)
		{
			resume();
		}
	}

	public function resume():void
	{
		if (_paused)
		{
			if (_characterIndex >= _text.length)
			{
				if (_dialogueComplete != null) {
					_dialogueComplete();
				}
				world.recycle(this);
			}
			else
			{
				_tilemap.setRect(1, 1, _tilemap.columns - 2, _tilemap.rows - 2, 0);
				_columnIndex = 1;
				_rowIndex = 2;
				_paused = false;
				_textTick = 0;
			}
		}
	}
	
	public function init(text:String, speedSetting:int=GameOptions.TEXT_MEDIUM, onComplete:Function = null):void
	{
		
		textSpeed = speedSetting == GameOptions.TEXT_SLOW ? 2 :
			         speedSetting == GameOptions.TEXT_MEDIUM ? 1 : 0;
		_text = formatForDisplay(text);
		_dialogueComplete = onComplete;
		
		// Reset dialogue.
		_tilemap.setRect(1, 1, _tilemap.columns - 2, _tilemap.rows - 2, 0);
		_characterIndex = 0;
		_columnIndex = 1;
		_rowIndex = 2;
		
		// Begin dialogue.
		_paused = false;
	}
	
	//Formats a long single-line string into a multiple-line string that fits in the displayed text box
	private function formatForDisplay(text:String):String
	{
		var words:Array = text.split(" ");
		var newText:String = "";
		var line:String = "";
		var newLine:String = "";
		for each (var word:String in words) 
		{
			newLine = line == "" ? line.concat(word) : line.concat(" ", word);
			if (newLine.length > MAX_LINE_LENGTH) {
				newText = newText.concat(line, "\n");
				newLine = word;
			}
			line = newLine;
		}
		newText = newText.concat(line);
		return newText;
	}

	override public function update():void
	{
		if (_textTick == 0 && !_paused && _characterIndex < _text.length)
		{
			_textTick = textSpeed;
			
			var newIndexes:Array = MenuBuilder.addText(_tilemap, _text.charAt(_characterIndex), _columnIndex, _rowIndex, 1);
			_columnIndex = _rowIndex == newIndexes[1] ? newIndexes[0] : 1;
			_rowIndex = newIndexes[1];
			if (_rowIndex == 6)
			{
				// There is more dialog. Show the indicator and wait.
				_tilemap.setTile(_tilemap.columns - 2, _tilemap.rows - 2, 94);
				_paused = true;
			}
			
			_characterIndex++;
		}
		else if (_characterIndex >= _text.length)
		{
			_paused = true;
		}
		else
		{
			_textTick--;
		}
		super.update();
	}
}
}
