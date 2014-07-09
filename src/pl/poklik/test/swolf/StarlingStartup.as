package pl.poklik.test.swolf 
{
	/**
	 * ...
	 * @author Poklik
	 */
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import pl.poklik.test.swolf.game.helper.ScreenInfo;
	import starling.core.Starling;
	import pl.poklik.test.swolf.game.GameMain;
	import starling.utils.ScaleMode;
	import starling.utils.RectangleUtil;

	[SWF(width="800", height="480", frameRate="30", backgroundColor="#1192ee")]
	public class StarlingStartup extends Sprite
	{
		private var starling:Starling;

		public function StarlingStartup()
		{
			ScreenInfo.setInfo(stage.stageWidth, stage.stageHeight);
			starling = new Starling(GameMain, stage);
			starling.start();
		}
	}

}
