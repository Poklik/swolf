package pl.poklik.test.swolf.game.gameObjects.enemies 
{
	import pl.poklik.test.swolf.game.gameObjects.Enemy;
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.Resources;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Poklik
	 */
	public class EnemyShip extends Enemy
	{
		
		public function EnemyShip(callback:IGameObjectCallback, posXStart:Number, posY:Number, posXEnd:Number, scale:Number) 
		{
			super(callback, Resources.texEnemyShip, 200, posXStart, posY, posXEnd, 30*scale, scale);
		}
		
	}

}
