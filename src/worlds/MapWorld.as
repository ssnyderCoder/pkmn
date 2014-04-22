package worlds 
{
	import constants.Assets;
	import constants.Direction;
	import constants.GC;
	import entities.Actor;
	import entities.Dialogue;
	import entities.DialogueNPC;
	import entities.IInteractable;
	import entities.Interaction;
	import entities.ITouchable;
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
		private var _grid:Grid;
		private var _map:Tilemap;
		private var _mapEntity:Entity;
		private var _dialogue:Dialogue;
		private var _inputEnabled:Boolean = true;
		
		public function get player():Actor { return _player; }
		
		public function MapWorld(map:Class, playerX:uint, playerY:uint, direction:String) 
		{
			_rawMapData = map;
			_player = new Actor(playerX, playerY, direction, GC.MOVE_SPEED, Assets.SPRITE_RED);
		}
		
		override public function begin():void 
		{
			generateMap(_rawMapData);
			add(_player);
			super.begin();
		}
		
		public function setNewMap(map:Class, playerX:uint, playerY:uint, direction:String):void {
			_rawMapData = map;
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
			generateMap(_rawMapData);
			add(_player);
			
			transitionScreen.activate(TransitionScreen.WHITE_TO_NONE, TRANSITION_TIME, endTransition);
			this.add(transitionScreen);
		}
		
		private function endTransition():void {
			_inputEnabled = true;
			var transitionScreen:Entity = (Entity)(this.getInstance("transition"));
			this.remove(transitionScreen);
		}
		
		/**
		 * Display dialogue to the text box.
		 * @param	dialogue The dialogue to display.
		 */
		public function showDialogue(dialogue:String):void
		{
			_dialogue = Dialogue(create(Dialogue, true));
			_dialogue.init(dialogue);
		}
		
		override public function update():void 
		{
			if (!_inputEnabled) {
				//no input triggered
			}
			else if (_dialogue != null && _dialogue.world == this)
			{
				if (Input.pressed(Key.SPACE))
				{
					_dialogue.resume();
				}
			}
			else if (!_player.isMoving())
			{   if (Input.pressed(Key.SPACE))
				{
					doPlayerInteraction();
				}
				else if (Input.check((Key.UP || Key.DOWN || Key.LEFT || Key.RIGHT) && Input.lastKey))
				{
					doPlayerMovement();
					doPlayerTouch();
				}
			}
			
			FP.camera.x = _player.x - 64;
			FP.camera.y = _player.y - 64;
			
			super.update();
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
		
		public function getMap():Entity
		{
			return _mapEntity;
		}
		
		private function generateMap(data:Class):void
		{
			var xmlData:XML = FP.getXML(data);
			var mapWidth:uint = uint(xmlData.@width);
			var mapHeight:uint = uint(xmlData.@height);
			var tileString:String = xmlData.Tiles;
			var gridString:String = xmlData.Collision;
			var property:XML;
			
			// Populate Map
			_map = new Tilemap(Assets.MAP_TILES, mapWidth, mapHeight, GC.TILE_SIZE, GC.TILE_SIZE);
			_map.loadFromString(tileString);
			
			// Populate Grid
			_grid = new Grid(mapWidth, mapHeight, GC.TILE_SIZE, GC.TILE_SIZE);
			trace(gridString);
			_grid.loadFromString(gridString,"");
			
			_mapEntity = add(new Entity(0, 0, _map, _grid));
			_mapEntity.type = "maps";
			
			// Add actors.
			for each (property in xmlData.Entities.Interaction)
			{
				add(new Interaction(property.@dialogue, uint(property.@x), uint(property.@y)));
			}
			
			for each (property in xmlData.Entities.DialogueNPC)
			{
				add(new DialogueNPC(property.@dialogue, uint(property.@x / GC.TILE_SIZE), uint(property.@y / GC.TILE_SIZE), Direction.DOWN, GC.MOVE_SPEED, Assets.getSpriteID(property.@spriteName)));
			}
			
			for each (property in xmlData.Entities.Transition)
			{
				var transition:Teleport = new Teleport(uint(property.@x), uint(property.@y));
				transition.setWarpPoint(property.@map, uint(property.@xTile), uint(property.@yTile), property.@face);
				add(transition);
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
		
		
	}

}