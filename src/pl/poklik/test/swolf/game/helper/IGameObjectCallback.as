package pl.poklik.test.swolf.game.helper 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Poklik
	 */
	public interface IGameObjectCallback 
	{
		function removeObjectFromScene(obj:Sprite):void;
		function moveParticles(px:Number, py:Number):void;
		function showParticles(time:Number):void;
	}
	
}