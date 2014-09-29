package
{
	import org.flixel.*;
	
	public class Flyer extends FlxSprite
	{	
		public var player:Player;
		protected var range:FlxSprite;
		protected var moving:Number;
		
		protected static const VIEW:Number = 100;
		//protected static const SPEED:Number = 1;
		protected static const SPEED:Number = 100;
		
		public function Flyer(X:Number, Y:Number, _player:Player)
		{
			super(X, Y);
			makeGraphic(16, 16, 0xffFF0000);
			maxVelocity.x = SPEED;			//walking speed
			maxVelocity.y = SPEED;
			drag.x = maxVelocity.x * .5;		//deceleration (sliding to a stop)
			drag.y = maxVelocity.y * .5;
			immovable = true;
			
			range = new FlxSprite(x + 8 - VIEW / 2, y + 8 - VIEW / 2).makeGraphic(VIEW, VIEW, 0xff000001);
			range.solid = false;
			range.alpha = .33;
			(FlxG.state as PlayState).add(range);
			
			player = _player;
			moving = 0;
		}
			
		override public function update():void {
			super.update();
			
			if (range.overlaps(player) && moving == 0) {
				//x += (x - player.x < 0)? SPEED : -SPEED;
				//y += (y - player.y < 0)? SPEED : -SPEED;
				var speed:Number = drag.x * 2; // SPEED;
				velocity.x += (x - player.x < 0)? speed : -speed;
				velocity.y += (y - player.y < 0)? speed : -speed;
				moving = 60;
			} else if (moving > 0)
				moving -= 1;
			range.x = x + 8 - VIEW / 2;
			range.y = y + 8 - VIEW / 2;
		}
	}
}