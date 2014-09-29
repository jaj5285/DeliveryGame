package
{
	import org.flixel.*;
	
	public class Present extends FlxSprite
	{
		protected var player:Player;
		protected var held:Boolean;
		[Embed(source="assets/package.png")] public static var ImgPresent:Class;
		
		public function Present(X:Number, Y:Number, _player:Player)
		{
			super(X, Y);
			//makeGraphic(10, 10, 0xffFFDD38);
			loadGraphic(ImgPresent);
			maxVelocity.x = 50;				//walking speed
			acceleration.y = 330;			//gravity
			drag.x = maxVelocity.x * 4;		//deceleration (sliding to a stop)
			
			player = _player;
			held = false;
		}
		
		// Drop the present
		public function drop():void {
			if (held) {
				held = false;
				flicker(.5);
			}
		}
		
		override public function update():void {
			// Pick up the present
			if (overlaps(player) && !flickering && !held) {
				held = true;
				player.getPresent();
			}
			
			if (held) {
				x = player.x + player.width / 2 - width / 2;
				y = player.y + player.height - height;
				solid = false;
				acceleration.y = 0;
			} else {
				solid = true;
				acceleration.y = 360;
			}
		}
	}
}