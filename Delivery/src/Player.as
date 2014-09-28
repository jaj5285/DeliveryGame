package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			makeGraphic(16, 16, 0xff696969);
			maxVelocity.x = 100;			//walking speed
			acceleration.y = 360;			//gravity
			drag.x = maxVelocity.x*4;		//deceleration (sliding to a stop)
		}
		
		override public function update():void
		{
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