package
{
	import org.flixel.*;
	
	public class Present extends FlxSprite
	{
		protected var player:Player;
		protected var held:Boolean;
		
		public function Present(X:Number, Y:Number, _player:Player)
		{
			super(X, Y);
			makeGraphic(10, 10, 0xffFFDD38);
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
			if (overlaps(player) && !flickering) {
				held = true;
				player.getPresent();
			}
			
			if (held) {
				x = player.x + 3;
				y = player.y + 12;
				solid = false;
				acceleration.y = 0;
			} else {
				solid = true;
				acceleration.y = 360;
			}
		}
	}
}