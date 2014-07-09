package pl.poklik.test.swolf.game 
{
	import flash.media.Sound;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Poklik
	 */
	public class Resources 
	{
		[Embed(source="../../../../../../rsrc/texatlas.xml", mimeType="application/octet-stream")]
			private static const xmlAtlas:Class;
		
		[Embed(source = "../../../../../../rsrc/texatlas.png")]
			private static const gfxAtlas:Class;
		
			public static const atlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new gfxAtlas()), XML(new xmlAtlas()));
				
		[Embed(source = "../../../../../../rsrc/particle.pex", mimeType = "application/octet-stream")]
			public static const partcWater:Class;
				
		public static const texWater:Texture = atlas.getTexture("water");
		public static const texPlayer:Texture = atlas.getTexture("player");
		public static const texMissile:Texture = atlas.getTexture("missile");
		public static const texBackground:Texture = atlas.getTexture("bck");
		public static const texWaterPartcicle:Texture = atlas.getTexture("particle");
		public static const texEnemyShip:Texture = atlas.getTexture("enemy1");
		public static const texEnemySub:Texture = atlas.getTexture("enemy2");
		public static const texEnemyPirate:Texture = atlas.getTexture("enemy3");
		public static const texMine:Texture = atlas.getTexture("mine");
		
		[Embed(source = "../../../../../../rsrc/explosion.mp3")]
			public static const sfxExplosion:Class;
			public static const sndExplosion:Sound = new sfxExplosion() as Sound;
			
		[Embed(source = "../../../../../../rsrc/miss.mp3")]
			public static const sfxMiss:Class;
			public static const sndMiss:Sound = new sfxMiss() as Sound;
			
		[Embed(source = "../../../../../../rsrc/shoot.mp3")]
			public static const sfxShoot:Class;
			public static const sndShoot:Sound = new sfxShoot() as Sound;
			
		[Embed(source="../../../../../../rsrc/deffont.fnt", mimeType="application/octet-stream")]
			private static const xmlFont:Class;

		public static const font:BitmapFont = new BitmapFont(atlas.getTexture("deffont"), XML(new xmlFont()));
	
	}

}

