package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{
		protected var _level:FlxTilemap;
		
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
					if (j == gridH - 1)
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
		}
	}
}