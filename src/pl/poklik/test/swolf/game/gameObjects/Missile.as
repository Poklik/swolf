package pl.poklik.test.swolf.game.gameObjects 
{
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.Resources;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Poklik
	 */
	public class Missile extends GameObject
	{
		
		private var vY:Number;
		private var maxHeight:Number;
		private var startY:Number;
		
		public function Missile(callback:IGameObjectCallback, posX:Number, posY:Number, maxHeight:Number) 
		{
			super(callback, Resources.texMissile);
			startY = posY;
			this.maxHeight = maxHeight;
			x = posX;
			y = posY;
			vY = 25;
			Resources.sndShoot.play();
		}
		
		override public function tick(timeSecDelta:Number):void
		{
			if (isAlive)
			{
				y -= vY*timeSecDelta;
				vY += timeSecDelta * 800;
				scaleX = ((y / startY)+0.4>1)?1:(y / startY)+0.4;
				scaleY = scaleX;
				if (y < maxHeight)
				{
					remove();
					Resources.sndMiss.play();
				}
			}
		}
		
		override public function destroy():void
		{
			image.alpha = 0;
			isAlive = false;
			var anim:MovieClip = new MovieClip(Resources.atlas.getTextures("explosion_"), 6);
			anim.loop = true;
			anim.pivotX = anim.width / 2;
			anim.pivotY = anim.height / 2;
			anim.scaleX = 0.5;
			anim.scaleY = 0.5;
			addChild(anim);
			anim.play();
			Starling.juggler.add(anim);
			Starling.juggler.delayCall(remove, 1);
			Resources.sndExplosion.play();
		}
		
	}

}

