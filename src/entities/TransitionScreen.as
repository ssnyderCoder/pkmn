package entities 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.Mask;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * When activated this entity shows a white flash used for transitioning between maps.
	 * @author Sean Snyder
	 */
	public class TransitionScreen extends Entity 
	{
		public static const NONE_TO_WHITE:int = 0;
		public static const WHITE_TO_NONE:int = 1;
		
		private var canvas:Canvas;
		public function TransitionScreen() 
		{
			super(0, 0);
			this.name = "transition";
			this.layer = -1;
			canvas = new Canvas(Main.WIDTH, Main.HEIGHT);
			canvas.fill(new Rectangle(0, 0, canvas.width, canvas.height), 0xDDDDDD);
			this.graphic = canvas;
			canvas.scrollX = 0;
			canvas.scrollY = 0;
		}
		
		public function activate(mode:int, timeInSeconds:Number = 0.5, onFinished:Function = null):void {
			canvas.alpha = mode == NONE_TO_WHITE ? 0.0 : 1.0;
			var alphaGoal:Number = mode == NONE_TO_WHITE ? 1.0 : 0.0;
			var easeFunc:Function = mode == NONE_TO_WHITE ? Ease.circOut : Ease.circIn;
			
			var tween:VarTween = new VarTween(onFinished);
			tween.tween(canvas, "alpha", alphaGoal, timeInSeconds * 60, easeFunc);
			this.addTween(tween, true);
		}
	}

}