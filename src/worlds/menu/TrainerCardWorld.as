package worlds.menu 
{
	import config.TrainerInfo;
	import constants.Assets;
	import entities.menu.MenuBuilder;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Sean Snyder
	 */
	public class TrainerCardWorld extends World 
	{
		private var _prevWorld:World;
		public function TrainerCardWorld(info:TrainerInfo, prevWorld:World) 
		{
			super();
			_prevWorld = prevWorld;
			var background:Stamp = new Stamp(Assets.TRAINER_CARD);
			
			var textMap:Tilemap = new Tilemap(Assets.MENU_SPRITES, 96, 40, 8, 8);
			textMap.x = 16;
			textMap.y = 16;
			textMap.floodFill(0, 0, 0);
			var text:String = "NAME/" + info.name + "\n";
			var moneyText:String = info.money.toString();
			while (moneyText.length < 5) moneyText = " " + moneyText;
			text = text.concat("MONEY/$" + moneyText + "\n");
			var timeInMinutes:int = info.timeInSeconds / 60;
			var timeText:String = (int(timeInMinutes % 60)).toString();
			if (timeText.length == 1) timeText = "0" + timeText;
			timeText = (int(timeInMinutes / 60)).toString() + ":" + timeText;
			while (timeText.length < 7) timeText = "0" + timeText;
			text = text.concat("TIME/" + timeText);
			MenuBuilder.addText(textMap, text, 0, 0, 1);
			
			var badges1:Tilemap = new Tilemap(Assets.BADGE_SPRITES, 112, 16, 16, 16);
			badges1.x = 24;
			badges1.y = 96;
			var badges2:Tilemap = new Tilemap(Assets.BADGE_SPRITES, 112, 16, 16, 16);
			badges2.x = 24;
			badges2.y = 120;
			for (var i:int = 0; i < 4; i++) 
			{
				badges1.setTile(i * 2, 0, i < info.numBadges ? i + 8 : i);
				badges2.setTile(i * 2, 0, i + 4 < info.numBadges ? i + 4 + 8 : i + 4);
			}
			
			var graphics:Graphiclist = new Graphiclist(background, textMap, badges1, badges2);
			addGraphic(graphics);
		}
		
		//uses trainer card background
		//text - 5 rows, 12 columns, starts at 16, 16
			//NAME/1234567
			//MONEY/P12345
			//TIME/0000:00
		//badges 2 rows, 4 columns, starts at ROW1: 24, 96 / ROW2: 24, 120, each box starts 32 width after 1st box
		
		override public function update():void 
		{
			if (Input.pressed(Key.SPACE) || Input.pressed(Key.ENTER))
			{
				FP.world = _prevWorld;
				return;
			}
			
			super.update();
		}
	}

}