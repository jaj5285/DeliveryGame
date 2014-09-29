package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		protected var _level:FlxTilemap;
		protected var _player:Player;
		protected var _present:Present;
		
		protected var _flyer:Flyer;
		
		[Embed(source="assets/basic_tiles.png")] public static var ImgTiles:Class;
		
		override public function create():void
		{
			// Basic level structure
			FlxG.bgColor = 0xffffffff;
			
			// create the tilemap data
			var gridW:int = FlxG.width / 16;
			var gridH:int = FlxG.height / 16;
			// Generate a floor for the level
			var mapData:String = "";
			for (var j:int = 0; j < gridH; j++) {
				for (var i:int = 0; i < gridW; i++) {
					if ((j >= gridH - 3 && i >= gridW / 2) || j == gridH - 1)
						mapData = mapData.concat("1");
					else
						mapData = mapData.concat("0");
					if (i != gridW - 1) 
						mapData = mapData.concat(",");
				}
				if (j != gridH - 1) 
					mapData = mapData.concat("\n");
			}
			_level = new FlxTilemap();
			_level.loadMap(mapData, ImgTiles, 16, 16);
			add(_level);
			
			// Add the player and present to carry
			_player = new Player(FlxG.width / 2 - 100, FlxG.height / 2);
			add(_player);
			_present = new Present(FlxG.width / 2 + 50, FlxG.height / 2, _player);
			_player.present = _present;
			add(_present);
			
			// Add the different types of enemies
			_flyer = new Flyer(500, 100, _player);
			add(_flyer);
		}
		
		override public function update():void {
			super.update();
			FlxG.collide();
			
			FlxG.overlap(_player, _flyer, takeDamage);
			
			// temporary
			if (FlxG.keys.justPressed("C")) {
				_player.hurt(0);
			}
		}
		
		private function takeDamage(player:Player, enemy:FlxSprite):void {
			player.hurt(0);
			//if (enemy is Bullet) enemy.kill();
		}
	}
}