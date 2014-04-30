package entities 
{
	import constants.Assets;
	import constants.GC;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class GameMap extends Entity 
	{
		
		private var _map:Tilemap;
		private var _grid:Grid;
		private const behaviorFactory:BehaviorFactory = new BehaviorFactory();
		public function GameMap(x:Number=0, y:Number=0) 
		{
			super(x, y);
		}
		
		public function init(theWorld:World, data:Class):void {
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
			
			this.graphic = _map;
			this.mask = _grid;
			type = "maps";
			layer = RenderLayers.TILES;
			
			// Add actors.
			for each (property in xmlData.Entities.Interaction)
			{
				theWorld.add(new Interaction(property.@dialogue, uint(property.@x), uint(property.@y)));
			}
			
			for each (property in xmlData.Entities.DialogueNPC)
			{
				var npc:DialogueNPC = new DialogueNPC(property.@dialogue, uint(property.@x / GC.TILE_SIZE), uint(property.@y / GC.TILE_SIZE), property.@direction, GC.MOVE_SPEED, Assets.getSpriteID(property.@spriteName));
				npc.assignBehavior(behaviorFactory.getBehavior(property.@behavior));
				theWorld.add(npc);
			}
			
			for each (property in xmlData.Entities.Transition)
			{
				var transition:Teleport = new Teleport(uint(property.@x), uint(property.@y));
				transition.setWarpPoint(property.@map, uint(property.@xTile), uint(property.@yTile), property.@face);
				theWorld.add(transition);
			}
		}
		
	}

}