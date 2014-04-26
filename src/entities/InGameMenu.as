package entities 
{
	import constants.Assets;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class InGameMenu extends Entity 
	{
		public function InGameMenu(x:Number=0, y:Number=0) 
		{
			super(x, y);
			var background:Stamp = new Stamp(Assets.INGAME_MENU);
			background.scrollX = 0;
			background.scrollY = 0;
			this.graphic = background;
			this.setHitbox(background.width, background.height);
		}
		
	}

}