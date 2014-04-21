package entities 
{
	import constants.Maps;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Hitbox;
	import worlds.MapWorld;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class Teleport extends Entity implements ITouchable 
	{
		private var _mapName:String;
		private var _mapX:uint;
		private var _mapY:uint;
		private var _warpDirection:String;
		public function Teleport(x:uint = 0, y:uint = 0) 
		{
			type = "touchable";
			super(x, y, null, new Hitbox(12, 12, 2, 2));
		}
		
		public function setWarpPoint(mapName:String, mapX:uint, mapY:uint, warpDirection:String):void {
			_mapName = mapName;
			_mapX = mapX;
			_mapY = mapY;
			_warpDirection = warpDirection;
		}
		
		/* INTERFACE entities.ITouchable */
		
		public function touch():void 
		{
			var mapClass:Class = Maps.getMapData(_mapName);
			if(mapClass){
				FP.world = new MapWorld(mapClass, _mapX, _mapY, _warpDirection);
			}
		}
		
	}

}