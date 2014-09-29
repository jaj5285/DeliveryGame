package
{
	import org.flixel.*;
	
	public class Flyer extends FlxSprite
	{	
		public var player:Player;
		protected var range:FlxSprite;
		protected var moving:Number;
		
		protected static const VIEW:Number = 300;
		//protected static const SPEED:Number = 1;
		protected static const SPEED:Number = 150;
		
		public function Flyer(X:Number, Y:Number, _player:Player)
		{
			super(X, Y);
			makeGraphic(32, 32, 0xffFF0000);
			maxVelocity.x = SPEED;			//walking speed
			maxVelocity.y = SPEED;
			drag.x = maxVelocity.x * 1;		//deceleration (sliding to a stop)
			drag.y = maxVelocity.y * 1;
			immovable = true;
			solid = true;
			
			range = new FlxSprite(x + width / 2 - VIEW / 2, y + height / 2 - VIEW / 2);
			range.makeGraphic(VIEW, VIEW, 0xff000001);
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
				var speed:Number = drag.x * 8;
				velocity.x += (x - player.x < 0)? speed : -speed;
				velocity.y += (y - player.y < 0)? speed : -speed;
				moving = 40;
			} else if (moving > 0)
				moving -= 1;

			range.x = x + 8 - VIEW / 2;
			range.y = y + 8 - VIEW / 2;
		}
	}
}