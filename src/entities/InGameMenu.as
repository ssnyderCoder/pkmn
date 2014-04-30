package entities 
{
	import config.TrainerInfo;
	import constants.Assets;
	import entities.menu.MenuBuilder;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import worlds.OptionsWorld;
	import worlds.TrainerCardWorld;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class InGameMenu extends Entity 
	{
		private static const MENU_TEXTS:Array = new Array("POK~DEX\n",
		                                 "POK~MON\n",
		                                 "ITEM\n",
		                                 "NAME\n",
		                                 "SAVE\n",
		                                 "OPTION\n",
		                                 "EXIT");
		
		private var _tilemap:Tilemap;
		private var _cursorPosition:uint = 0; //0 to numSelections - 1
		private var _numSelections:uint = 0;
		private var _selectionFunctions:Array = new Array();
		private var _finished:Boolean = false;
		private var _trainerInfo:TrainerInfo;
		
		public function InGameMenu(x:Number=0, y:Number=0) 
		{
			super(x, y);
			layer = RenderLayers.MENU1;
		}
		
		public function init(info:TrainerInfo):void {
			_trainerInfo = info;
			_numSelections = getNumberSelections(info);
			_tilemap = new Tilemap(Assets.MENU_SPRITES, 80, (2 + _numSelections*2) * 8, 8, 8);
			this.graphic = _tilemap;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			this.setHitbox(_tilemap.width, _tilemap.height);
			setupMenu(info);
			setupSelections(info);
		}
		
		private function setupSelections(info:TrainerInfo):void 
		{
			if (info.hasPokedex) _selectionFunctions.push(selectPokedex);
			if (info.hasPokemon) _selectionFunctions.push(selectPokemon);
			if (info.hasItems) _selectionFunctions.push(selectItems);
			if (info.hasTrainerCard) _selectionFunctions.push(selectName);
			if (info.canSaveGame) _selectionFunctions.push(selectSave);
			_selectionFunctions.push(selectOptions);
			_selectionFunctions.push(selectExit);
		}
		
		private function getNumberSelections(info:TrainerInfo):uint 
		{
			var num:uint = 2; //OPTIONS & EXIT
			if (info.hasPokedex) num++;
			if (info.hasPokemon) num++;
			if (info.hasItems) num++;
			if (info.hasTrainerCard) num++;
			if (info.canSaveGame) num++;
			return num;
		}
		
		private function setupMenu(info:TrainerInfo):void 
		{
			// Set up frame.
			_tilemap.floodFill(0, 0, 0);
			
			MenuBuilder.createBox(_tilemap, 0, 0, _tilemap.columns, _tilemap.rows);
			
			// Cursor
			_tilemap.setTile(1, 2, 9);
			// Text
			var menuText:String = "";
			menuText = info.hasPokedex ? menuText.concat(MENU_TEXTS[0]) : menuText;
			menuText = info.hasPokemon ? menuText.concat(MENU_TEXTS[1]) : menuText;
			menuText = info.hasItems ? menuText.concat(MENU_TEXTS[2]) : menuText;
			menuText = info.hasTrainerCard ? menuText.concat(MENU_TEXTS[3]) : menuText;
			menuText = info.canSaveGame ? menuText.concat(MENU_TEXTS[4]) : menuText;
			menuText = menuText.concat(MENU_TEXTS[5]); //OPTIONS
			menuText = menuText.concat(MENU_TEXTS[6]); //EXIT
			menuText = menuText.replace("NAME", info.name); //set name properly
			MenuBuilder.addText(_tilemap, menuText, 2, 2, 1);
			
		}
		
		public function handleInput(keyCode:int):void {
			_tilemap.setTile(1, (_cursorPosition * 2) + 2, 0);
			if (keyCode == Key.UP) {
				_cursorPosition = _cursorPosition == 0 ? _numSelections - 1 : _cursorPosition - 1;
			}
			else if (keyCode == Key.DOWN) {
				_cursorPosition = _cursorPosition == _numSelections - 1 ? 0 : _cursorPosition + 1;
			}
			else if (keyCode == Key.SPACE) {
				var select:Function = _selectionFunctions[_cursorPosition];
				select();
			}
			else if (keyCode == Key.ENTER) {
				world.recycle(this);	
			}
			_tilemap.setTile(1, (_cursorPosition * 2) + 2, 9);
		}
		
		public function isFinished():Boolean {
			return _finished;
		}
		
		private function selectPokedex():void {
			
		}
		private function selectPokemon():void {
			
		}
		private function selectItems():void {
			
		}
		private function selectName():void {
			_trainerInfo.timeInSeconds += FP.timeFlag() / (1000);
			FP.world = new TrainerCardWorld(_trainerInfo, this.world);
		}
		private function selectSave():void {
			
		}
		private function selectOptions():void {
			FP.world = new OptionsWorld(_trainerInfo.gameOptions, this.world)
		}
		private function selectExit():void {
			world.recycle(this);
		}
		
	}

}