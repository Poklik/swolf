package pl.poklik.test.swolf.game.gameObjects.enemies 
{
	import pl.poklik.test.swolf.game.gameObjects.Enemy;
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.Resources;
	/**
	 * ...
	 * @author Poklik
	 */
	public class EnemySub extends Enemy
	{
		
		public function EnemySub(callback:IGameObjectCallback, posXStart:Number, posY:Number, posXEnd:Number, scale:Number) 
		{
			super(callback, Resources.texEnemySub, 500, posXStart, posY, posXEnd, 100*scale, scale);
		}
		
	}

}
