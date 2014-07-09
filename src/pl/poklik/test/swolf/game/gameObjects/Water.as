package pl.poklik.test.swolf.game.gameObjects 
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Poklik
	 */
	public class Water extends GameObject
	{
		private static const animValue:Number = Math.PI / 64;
		
		private var sceneWidth:Number;
		private var horizontalSpeed:Number;
		
		/**
		 * Creates on row of water animation.
		 * @param	texture	Water texture.
		 * @param	scale	Row scale.
		 * @param	sceneWidth	Scene width.
		 * @param	positionY	Water position on screen.
		 * @param	horizontalSpeed	Speed of moving water.
		 */
		public function Water(texture:Texture, scale:Number, sceneWidth:Number, positionY:Number, horizontalSpeed:Number) 
		{
			super(null, null);
			isAlive = false;
			scaleX = scale;
			scaleY = scale;
			this.sceneWidth = sceneWidth / scale;
			this.horizontalSpeed = horizontalSpeed;
			var posX:Number = 0;
			var numberOfImagesInRow:int = Math.ceil(sceneWidth / (texture.width * scale) + 1);
			if (numberOfImagesInRow % 2 == 1)
				numberOfImagesInRow++;
			for (var i:int = 0; i < numberOfImagesInRow; i++)
			{
				var img:Image = new Image(texture);
				img.pivotX = img.width / 2;
				img.pivotY = img.height / 2;
				img.x = posX;
				posX += img.width;
				addChild(img);
				
				img.rotation = (i % 2 == 0)?animValue: -animValue;
				var tween:Tween = new Tween(img, 4, Transitions.EASE_IN_OUT);
				tween.animate("rotation", (i % 2 == 1)?animValue: -animValue);
				tween.repeatCount = 0;
				tween.reverse = true;
				Starling.juggler.add(tween);
			}
			y = positionY;
		}
		
		override public function tick(timeSecDelta:Number):void
		{
			for (var i:int = 0; i < numChildren; i++)
			{
				getChildAt(i).x += horizontalSpeed;
			}
			
			if (horizontalSpeed > 0)
			{
				var lastImg:Image = (Image)(getChildAt(numChildren - 1));
				if (lastImg.x - lastImg.width / 2 > sceneWidth)
				{
					lastImg.x = getChildAt(0).x - getChildAt(0).width / 2 - lastImg.width / 2;
					setChildIndex(lastImg, 0);
				}
			}
			else
			{
				var firstImg:Image = (Image)(getChildAt(0));
				if (firstImg.x + firstImg.width / 2 < 0)
				{
					firstImg.x = getChildAt(numChildren-1).x + getChildAt(numChildren-1).width / 2 + firstImg.width / 2;
					setChildIndex(firstImg, numChildren);
				}

			}
		}
		
	}

}
