package pl.poklik.test.swolf.game.helper 
{
	/**
	 * ...
	 * @author Poklik
	 */
	public class ScreenInfo 
	{
		private static var _width:Number;
		private static var _height:Number;
		
		public static function setInfo(sw:Number, sh:Number):void
		{
			_width = sw;
			_height = sh;
		}
		
		public static function get width():Number
		{
			return _width;
		}
		
		public static function get height():Number
		{
			return _height;
		}
		
	}

}