package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		public var present:Present;
		[Embed(source="assets/birb-spritemap.png")] public static var ImgBirb:Class;
		
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			//makeGraphic(16, 16, 0xff0094FF);
			loadGraphic(ImgBirb, true, true, 108, 119);
			offset.x += 25;
			offset.y += 40;
			width = 75;
			height = 50;
			
			addAnimation("flap", [0, 1, 2, 3], 10);
			play("flap");
			
			maxVelocity.x = 200;			//walking speed
			acceleration.y = 660;			//gravity
			drag.x = maxVelocity.x * 4;		//deceleration (sliding to a stop)
			present = null;
		}
		
		public function getPresent():void {
			//Adjust the bounding box of the player
			height = 95;
			y -= 25;
		}
		
		override public function hurt(Damage:Number):void {
			if (!flickering) {
				super.hurt(Damage);
				flicker(1);
				
				if (present != null) {
					present.drop();
					height = 50;
				}
			}
		}
		
		override public function update():void {
			//Smooth slidey walking controls
			acceleration.x = 0;
			if(FlxG.keys.LEFT) {
				acceleration.x -= drag.x;
				facing = LEFT;
			}
			if(FlxG.keys.RIGHT) {
				acceleration.x += drag.x;
				facing = RIGHT;
			}
			
			//Flight controls
			if (FlxG.keys.Z && y > 10)
				velocity.y = -acceleration.y * 0.25;
			//if (FlxG.keys.justPressed("Z"))
			//	velocity.y = -acceleration.y * 0.35;
		}
	}
}