package pl.poklik.test.swolf.game.gameObjects.enemies 
{
	import pl.poklik.test.swolf.game.gameObjects.Enemy;
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.Resources;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author 
	 */
	public class EnemyMine extends Enemy
	{
		
		public function EnemyMine(callback:IGameObjectCallback, posXStart:Number, posY:Number, posXEnd:Number, scale:Number) 
		{
			super(callback, Resources.texMine, 0, posXStart, posY, posXEnd, 50*scale, scale);
		}
		
	}

}
