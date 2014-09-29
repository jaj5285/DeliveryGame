package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public var present:Present;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			makeGraphic(16, 16, 0xff0094FF);
			maxVelocity.x = 100;			//walking speed
			acceleration.y = 330;			//gravity
			drag.x = maxVelocity.x * 4;		//deceleration (sliding to a stop)
			present = null;
		}
		
		public function getPresent():void {
			//Adjust the bounding box of the player
			height = 22;
			y -= 6;
		}
		
		override public function hurt(Damage:Number):void {
			super.hurt(Damage);
			if (present != null) {
				present.drop();
				height = 16;
			}
		}
		
		override public function update():void {
			//Smooth slidey walking controls
			acceleration.x = 0;
			if(FlxG.keys.LEFT)
				acceleration.x -= drag.x;
			if(FlxG.keys.RIGHT)
				acceleration.x += drag.x;
			
			//Flight controls
			if (FlxG.keys.Z && y > 10)
				velocity.y = -acceleration.y * 0.25;
			//if (FlxG.keys.justPressed("Z"))
			//	velocity.y = -acceleration.y * 0.35;
		}
	}
}