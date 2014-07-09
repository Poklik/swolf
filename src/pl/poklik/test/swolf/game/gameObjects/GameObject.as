package pl.poklik.test.swolf.game.gameObjects 
{
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import pl.poklik.test.swolf.game.Resources;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Poklik
	 */
	public class GameObject extends Sprite
	{
		private var callback:IGameObjectCallback;
		protected var image:Image;
		protected var isAlive:Boolean;
		
		/**
		 * Generic game object on screen.
		 * @param	callback	Callback object for particles effect and removing itself from screen.
		 * @param	texture		Default image of object (centered).
		 */
		public function GameObject(callback:IGameObjectCallback=null, texture:Texture=null) 
		{
			this.callback = callback;
			if (texture != null)
			{
				image = new Image(texture);
				addChild(image);
				image.x = -image.width / 2.0;
				image.y = -image.height / 2.0;
			}
			isAlive = true;
		}
		
		/**
		 * Default tick function called every frame.
		 * @param	timeSecDelta	Time delta between frames (in seconds).
		 */
		public function tick(timeSecDelta:Number):void
		{
			
		}
		
		/**
		 * Destroys object with animation.
		 */
		public function destroy():void
		{
			isAlive = false;
			remove();
		}
		
		public function checkCollision(obj:GameObject):Boolean
		{
			if (isAlive)
				if (obj.getAlive())
					if (bounds.containsRect(obj.bounds))
						return true;
			return false;
		}
		
		public function getAlive():Boolean
		{
			return isAlive;
		}

		/**
		 * Removes object from board.
		 */
		protected function remove():void
		{
			if (callback!=null)
				callback.removeObjectFromScene(this);
		}
		
		protected function moveParticles(newX:Number, newY:Number):void
		{
			if (callback != null)
				callback.moveParticles(newX, newY);
		}
		
		protected function showParticles(time:Number):void
		{
			if (callback != null)
				callback.showParticles(time);
		}

	}

}