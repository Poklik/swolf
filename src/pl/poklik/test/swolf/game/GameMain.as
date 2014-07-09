package pl.poklik.test.swolf.game 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import pl.poklik.test.swolf.game.gameObjects.enemies.EnemyMine;
	import pl.poklik.test.swolf.game.gameObjects.enemies.EnemyPirate;
	import pl.poklik.test.swolf.game.gameObjects.enemies.EnemyShip;
	import pl.poklik.test.swolf.game.gameObjects.enemies.EnemySub;
	import pl.poklik.test.swolf.game.gameObjects.Enemy;
	import pl.poklik.test.swolf.game.gameObjects.Missile;
	import pl.poklik.test.swolf.game.gameObjects.Player;
	import pl.poklik.test.swolf.game.gameObjects.Water;
	import pl.poklik.test.swolf.game.helper.IGameObjectCallback;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.PDParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	import pl.poklik.test.swolf.game.helper.ScreenInfo;
	import flash.utils.setInterval;
	/**
	 * ...
	 * @author Poklik
	 */
	public class GameMain extends Sprite implements IGameObjectCallback
	{
		private const playerPosY:Number = 400;
		private const spawningDelay:Number = 3000;
		
		private var player:Player;
		//private var layerMissile:Sprite;
		
		private var missiles:Vector.<Missile>;
		private var water:Vector.<Water>;
		private var enemies:Vector.<Enemy>;
		
		private var partc:PDParticleSystem;
		
		public function GameMain() 
		{
			addChild(new TextField(ScreenInfo.width, ScreenInfo.height, ""));
			addChild(new Image(Resources.texBackground));
			
			player = new Player(this, Resources.texPlayer);
			addChild(player);
			player.moveTo(ScreenInfo.width/2, playerPosY, false);
			
			water = new Vector.<Water>;
			missiles = new Vector.<Missile>;
			enemies = new Vector.<Enemy>;
			
			var waterPos:Number = 90;
			var waterScale:Number = 0.5;
			var waterHeight:Number = Resources.texWater.height;
			for (var waterRow:int = 0; waterRow < 11; waterRow++)
			{
				water.push(new Water(Resources.texWater, waterScale, 800, waterPos, (waterRow%2==0)?0.5:-0.5));
				addChild(water[waterRow]);
				
				waterPos += (waterHeight * waterScale) / 1.8;
				waterScale+= 0.1;
			}
			
			setChildIndex(player, getChildIndex(water[water.length - 2]));

			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouchEvent);
			
			partc = new PDParticleSystem(XML(new Resources.partcWater()), Resources.texWaterPartcicle);
			addChild(partc);
			Starling.juggler.add(partc);
			
			/**
			 * Enemy spawner
			 */
			setInterval(
				function():void
				{
					spawnEnemy(Math.floor(Math.random() * 3)+1, Math.floor(Math.random() * 5)+1);
					spawnEnemy(ENEMY_MINE, Math.floor(Math.random() * 4)+6);
				},
			spawningDelay);
		}
 
		private function onEnterFrame(event:EnterFrameEvent):void
		{
			player.tick(event.passedTime);
			
			for each (var msl:Missile in missiles)
			{
				for each (var col:Enemy in enemies)
				{
					if (col.checkCollision(msl))
					{
						col.destroy();
						msl.destroy();
					}
				}
				msl.tick(event.passedTime);
			}
			
			for each (var wtr:Water in water)
			{
				wtr.tick(event.passedTime);
			}
			
			for each (var enm:Enemy in enemies)
			{
				enm.tick(event.passedTime);
			}
		}
		
		private function onTouchEvent(event:TouchEvent):void
		{
			var touchDown:Touch = event.getTouch(this, TouchPhase.BEGAN);
			var touchMove:Touch = event.getTouch(this, TouchPhase.MOVED);
			if (touchDown || touchMove)
			{
				var pos:Point = (touchMove)?touchMove.getLocation(this):touchDown.getLocation(this);
				if (pos.x < 0) pos.x = 0;
				else if (pos.x > ScreenInfo.width) pos.x = ScreenInfo.width;
				player.moveTo(pos.x, playerPosY);
			}
			
			var touchUp:Touch = event.getTouch(this, TouchPhase.ENDED);
			if (touchUp)
			{
				shoot();
			}
		}
		
		/**
		 * Shoots missile in current player position.
		 */
		private function shoot():void
		{
			var newMissile:Missile = new Missile(this, player.x, player.y, 80);
			//layerMissile.
			addChild(newMissile);
			setChildIndex(newMissile, getChildIndex(player));
			missiles.push(newMissile);
		}

		private const ENEMY_MINE:int = 0;
		private const ENEMY_SHIP:int = 1;
		private const ENEMY_SUB:int = 2;
		private const ENEMY_PIRATE:int = 3;
		private var enemiesArray:Array = [ EnemyMine, EnemyShip, EnemySub, EnemyPirate ];
		private var texturesArray:Array = [ Resources.texMine, Resources.texEnemyShip, Resources.texEnemySub, Resources.texEnemyPirate ];
		
		/**
		 * Spawns enemy at given water slot.
		 * @param	type	Enemy type. Use GameObject.ENEMY_*
		 * @param	slot	Water slot for Y position of spawning. Also affects objects scale and speed to match given water slot.
		 * Every object in even numbered slot will be moving right and left in odd numbered.
		 */
		private function spawnEnemy(type:int, slot:int):void
		{
			var wtr:Water = water[slot];
			var scale:Number = wtr.scaleX;
			var tex:Texture = texturesArray[type];
			var enemy:Enemy;
			if (slot % 2 == 0)
				enemy = new enemiesArray[type](this, -tex.width, wtr.y + tex.height / 4, ScreenInfo.width + tex.width, scale);
			else
				enemy = new enemiesArray[type](this, ScreenInfo.width + tex.width, wtr.y + tex.height / 4, -tex.width, scale);
			enemies.push(enemy);
			addChild(enemy);
			setChildIndex(enemy, getChildIndex(wtr));
		}
		
		/**
		 * Removes sprite from scene and if it possible also from game arrays.
		 * @param	obj	Sprite/GameObject to remove
		 */
		public function removeObjectFromScene(obj:Sprite):void
		{
			try
			{
				var index:int = -1;
				if (obj is Missile)
				{
					index = missiles.indexOf(obj);
					if (index>=0)
						missiles.splice(index, 1);
				}
				else if (obj is Enemy)
				{
					index = enemies.indexOf(obj);
					if (index>=0)
						enemies.splice(index, 1);
				}
				else if (obj is Water)
				{
					index = enemies.indexOf(obj);
					if (index>=0)
						water.splice(index, 1);
				}
				removeChild(obj);
			}
			catch (e:Error)
			{
				trace("Error removing object \"" + obj + "\" from scene!");
			}
		}
		
		/**
		 * Move emitter at position.
		 * @param	px	Position X.
		 * @param	py	Position Y.
		 */
		public function moveParticles(px:Number, py:Number):void
		{
			partc.emitterX = px;
			partc.emitterY = py;
		}
		
		/**
		 * Starts emitting particles for given period in seconds.
		 * @param	time	Time in seconds.
		 */
		public function showParticles(time:Number):void
		{
			partc.start(time);
		}

	}

}
