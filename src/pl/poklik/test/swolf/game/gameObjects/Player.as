package pl.poklik.test.swolf.game.gameObjects 
{

	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Poklik
	 */
	public class Player extends GameObject
	{
		private const animValue:Number=5.0;

		private var destPosX:Number;
		private var destRotation:Number;
		private var blurFilter:BlurFilter;
		
		public function Player(callback:IGameObjectCallback, texture:Texture)
		{
			super(callback, texture);
			image.y = -image.height / 2.0 + animValue;
			
			var tween:Tween = new Tween(image, 1, Transitions.EASE_IN_OUT);
			tween.animate("y", -image.height / 2.0 - animValue);
			tween.repeatCount = 0;
			tween.reverse = true;
			Starling.juggler.add(tween);
			
			destPosX = 0;
			destRotation = 0;

			blurFilter = new BlurFilter();
			blurFilter.blurX = 0;
			blurFilter.blurY = 0;
			filter = blurFilter;
		}
		
		override public function tick(timeSecDelta:Number):void
		{
			var moveDeltaX:Number = ((destPosX - x) / 2) * (timeSecDelta * 20);
			blurFilter.blurX = (Math.abs(moveDeltaX) < 0.1)?0:Math.abs(moveDeltaX)/2.0;
			x += moveDeltaX;
			destRotation = moveDeltaX / 100;
			rotation += (destRotation - rotation) / 2 * (timeSecDelta * 10);
			
			moveParticles(x, y + 20);
			if (Math.abs(moveDeltaX) > 10)
				showParticles(0.1);
		}
		
		public function moveTo(newPosX:Number, newPosY:Number, doAnimation:Boolean=true):void
		{
			if (doAnimation == false)
			{
				x = newPosX;
			}
			destPosX = newPosX;
			y = newPosY;
		}

	}

}
