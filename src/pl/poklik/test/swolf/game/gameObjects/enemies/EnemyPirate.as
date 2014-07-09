package pl.poklik.test.swolf.game.gameObjects.enemies 
{
	import pl.poklik.test.swolf.game.gameObjects.Enemy;
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.Resources;
	/**
	 * ...
	 * @author Poklik
	 */
	public class EnemyPirate extends Enemy
	{
		
		public function EnemyPirate(callback:IGameObjectCallback, posXStart:Number, posY:Number, posXEnd:Number, scale:Number) 
		{
			super(callback, Resources.texEnemyPirate, 1000, posXStart, posY, posXEnd, 70*scale, scale);
		}
		
	}

}