package worlds 
{
	import config.TrainerInfo;
	import constants.Assets;
	import constants.Direction;
	import constants.GC;
	import constants.Maps;
	import entities.Actor;
	import entities.BehaviorFactory;
	import entities.DialogueNPC;
	import entities.GameMap;
	import entities.IInteractable;
	import entities.Interaction;
	import entities.ITouchable;
	import entities.menu.Dialogue;
	import entities.menu.InGameMenu;
	import entities.Teleport;
	import entities.TransitionScreen;
	import flash.geom.Point;

import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Zachary Lewis (http://zacharylew.is)
	 */
	public class MapWorld extends World 
	{
		private static const TRANSITION_TIME:Number = 0.5; //total time is double this
		private var _player:Actor;
		private var _tempPlayer:Actor;
		private var _rawMapData:Class;
		private var _mapEntity:GameMap;
		private var _dialogue:Dialogue;
		private var _menu:InGameMenu;
		private var _inputEnabled:Boolean = true;
		private var _trainerInfo:TrainerInfo = new TrainerInfo();
		
		public function get player():Actor { return _player; }
		
		public function get trainerInfo():TrainerInfo 
		{
			return _trainerInfo;
		}
		
		public function MapWorld() {
			_player = new Actor();
			if (_trainerInfo.load("pkmn", _player)) {
				setup(_trainerInfo.currentMap, _player.tileX, _player.tileY, _player.facing);
			}
			else {
				setup("oregonHouse1", 2, 2, Direction.DOWN);
			}
		}
		
		public function setup(mapName:String, playerX:uint, playerY:uint, direction:String) :void
		{
			_trainerInfo.currentMap = mapName;
			_player = new Actor(playerX, playerY, direction, GC.MOVE_SPEED, Assets.SPRITE_RED);
			_mapEntity = new GameMap();
			add(_player);
			add(_mapEntity);
			_mapEntity.init(this, Maps.getMapData(mapName));
			FP.timeFlag();
		}
		////////////////////////////////////////MAP RELATED///////////////////////////
		public function getMap():GameMap
		{
			return _mapEntity;
		}
		
		public function setNewMap(mapName:String, playerX:uint, playerY:uint, direction:String):void {
			_trainerInfo.currentMap = mapName;
			_rawMapData = Maps.getMapData(mapName);
			_tempPlayer = new Actor(playerX, playerY, direction, GC.MOVE_SPEED, Assets.SPRITE_RED);
			beginTransition();
		}
		
		private function beginTransition():void 
		{
			_inputEnabled = false;
			
			var transitionScreen:TransitionScreen = new TransitionScreen();
			transitionScreen.activate(TransitionScreen.NONE_TO_WHITE, TRANSITION_TIME, midTransition);
			this.add(transitionScreen);
		}
		
		private function midTransition():void 
		{
			var transitionScreen:TransitionScreen = (TransitionScreen)(this.getInstance("transition"));
			var entities:Array = new Array();
			this.getAll(entities);
			var entity:Entity;
			for each (entity in entities) {
				if (entity != transitionScreen) {
					this.remove(entity);
				}
			}
			_player = _tempPlayer;
			_tempPlayer = null;
			_mapEntity = new GameMap();
			add(_player);
			add(_mapEntity);
			_mapEntity.init(this, _rawMapData);
			FP.timeFlag();
			
			transitionScreen.activate(TransitionScreen.WHITE_TO_NONE, TRANSITION_TIME, endTransition);
			this.add(transitionScreen);
		}
		
		private function endTransition():void {
			_inputEnabled = true;
			var transitionScreen:Entity = (Entity)(this.getInstance("transition"));
			this.remove(transitionScreen);
		}
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Display dialogue to the text box.
		 * @param	dialogue The dialogue to display.
		 */
		public function showDialogue(dialogue:String, onComplete:Function = null):void
		{
			_dialogue = Dialogue(create(Dialogue, true));
			_dialogue.init(dialogue, _trainerInfo.gameOptions.textSpeed, onComplete);
		}
		
		override public function update():void 
		{
			if (!_inputEnabled) {
				//no input triggered
			}
			else {
				handleInput(Input.pressed(Key.ANY) ? Input.lastKey : -100);
			}
			
			
			FP.camera.x = _player.x - 64;
			FP.camera.y = _player.y - 64;
			
			super.update();
		}
		
		public function cancelMenus():void {
			if (_menu != null && _menu.world == this)
			{
				_menu.cancel();
			}
		}
		
		public function saveGame():void 
		{
			_trainerInfo.timeInSeconds += FP.timeFlag() / (1000);
			_trainerInfo.save("pkmn", _player);
		}
		
		public function loadGame():void {
			if (_trainerInfo.load("pkmn", _player)) {
				setNewMap(_trainerInfo.currentMap, _player.tileX, _player.tileY, _player.facing);
			}
		}
		
		private function handleInput(keyCode:int):void 
		{
			if (_dialogue != null && _dialogue.world == this)
			{
				_dialogue.handleInput(keyCode);
			}
			else if (_menu != null && _menu.world == this)
			{
				_menu.handleInput(keyCode);
			}
			else if (keyCode == Key.ENTER) {
				_menu = InGameMenu(create(InGameMenu, true));
				_menu.init(_trainerInfo);
				_menu.x = Main.WIDTH - _menu.width;
			}
			else if (_player.ableToMove())
			{   
				if (keyCode == Key.SPACE)
				{
					doPlayerInteraction();
				}
				if(Input.check((Key.UP || Key.DOWN || Key.LEFT || Key.RIGHT) && Input.lastKey))
				{
					doPlayerMovement();
					doPlayerTouch();
				}
			}
			
			
		}
		
		private function doPlayerInteraction():void 
		{
			// Check for collision with an IInteractable in the direction the player is facing and handle it accordingly.
			var interactionLocation:Point = Direction.GetDirectionValue(_player.facing);
			var interactionObject:IInteractable = IInteractable(_player.collide("actor", _player.x + interactionLocation.x * GC.TILE_SIZE, _player.y + interactionLocation.y * GC.TILE_SIZE));
			if (interactionObject != null)
			{
				interactionObject.interact();
			}
		}
		
		private function doPlayerMovement():void 
		{
			switch (Input.lastKey)
			{
				case Key.UP:
					_player.applyInput(Direction.UP);
					break;
				case Key.DOWN:
					_player.applyInput(Direction.DOWN);
					break;
				case Key.LEFT:
					_player.applyInput(Direction.LEFT);
					break;
				case Key.RIGHT:
					_player.applyInput(Direction.RIGHT);
					break;
				default:
					break;
			}
		}
		
		private function doPlayerTouch():void 
		{
			// Check for collision with an ITouchable in the direction the player is facing and handle it accordingly.
			var interactionLocation:Point = Direction.GetDirectionValue(_player.facing);
			var interactionObject:ITouchable = ITouchable(_player.collide("touchable", _player.x + interactionLocation.x * GC.TILE_SIZE, _player.y + interactionLocation.y * GC.TILE_SIZE));
			if (interactionObject != null)
			{
				interactionObject.touch();
			}
		}
		
	}

}