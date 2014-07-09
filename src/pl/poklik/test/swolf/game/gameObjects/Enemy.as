package pl.poklik.test.swolf.game.gameObjects 
{
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.helper.ScreenInfo;
	import pl.poklik.test.swolf.game.Resources;
	import starling.textures.Texture;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.animation.Transitions;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Poklik
	 */
	public class Enemy extends GameObject
	{
		private static const animValue:Number = 5;
		
		private var _points:int;
		private var posXEnd:Number;
		private var vX:Number;
		private var isGoingLeft:Boolean;
		
		private var tweenRotation:Tween;
		private var tweenFloating:Tween;
		
		/**
		 * Abstract class of enemy game objects.
		 * @param	callback	Callback object for removing itself from screen.
		 * @param	texture		Objects texture.
		 * @param	points		Points value for destroying this enemy.
		 * @param	posXStart	Starting X position.
		 * @param	posY		Starting Y position.
		 * @param	posXEnd		Ending X position. After it object will be automaticly removed.
		 * @param	speed		Horizontal speed;
		 * @param	scale		Scale of object.
		 */
		public function Enemy(callback:IGameObjectCallback, texture:Texture, points:int, posXStart:Number, posY:Number, posXEnd:Number, speed:Number, scale:Number) 
		{
			super(callback, texture);
			isAlive = true;
			_points = points;
			image.pivotX = image.width / 2;
			image.pivotY = image.height / 2;
			image.scaleX = scale;
			image.scaleY = scale;
			x = posXStart;
			y = posY;
			this.posXEnd = posXEnd;
			if (posXEnd > posXStart)
			{
				isGoingLeft = false;
				vX = Math.abs(speed);
			}
			else
			{
				isGoingLeft = true;
				vX = -Math.abs(speed);
			}
			
			image.rotation = -Math.PI / 16;
			tweenRotation = new Tween(image, 3, Transitions.EASE_IN_OUT);
			tweenRotation.animate("rotation", Math.PI/16);
			tweenRotation.repeatCount = 0;
			tweenRotation.reverse = true;
			Starling.juggler.add(tweenRotation);

			tweenFloating = new Tween(image, 1, Transitions.EASE_IN_OUT);
			tweenFloating.animate("y", -image.height / 2.0 - animValue);
			tweenFloating.repeatCount = 0;
			tweenFloating.reverse = true;
			Starling.juggler.add(tweenFloating);
		}
		
		override public function tick(timeSecDelta:Number):void
		{
			if (isAlive)
			{
				x += vX * timeSecDelta;
				if ( (isGoingLeft == false && x >= posXEnd) || (isGoingLeft && x <= posXEnd))
				{
					remove();
				}
			}
		}
		
		override public function destroy():void
		{
			Resources.sndExplosion.play();
			
			Starling.juggler.remove(tweenRotation);
			Starling.juggler.remove(tweenFloating);
			
			isAlive = false;
			var tween:Tween = new Tween(image, 1, Transitions.EASE_IN);
			tween.animate("rotation", -1.5);
			Starling.juggler.add(tween);
			
			tween = new Tween(this, 2, Transitions.EASE_IN_OUT_BACK);
			tween.animate("y", y + ScreenInfo.height);
			tween.onComplete = remove;
			Starling.juggler.add(tween);
		}
		
		override protected function remove():void
		{
			Starling.juggler.remove(tweenRotation);
			Starling.juggler.remove(tweenFloating);
			super.remove();
		}
		
		/**
		 * Private points setter, just in case someone would modify this parameter outside class.
		 */
		private function set points(newPoints:int):void
		{
			_points = newPoints;
		}
		
		public function get points():int
		{
			return _points;
		}

	}

}
