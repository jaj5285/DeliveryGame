package  
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		
		public function Bullet():void 
		{
			super();
			makeGraphic(3, 3, 0xFFF9F9F9);
			exists = false;
			
			velCheck = 0;
		}
		
		public function modify(w:uint, h:uint, invin:Boolean = false):void {
			invincible = invin;
			makeGraphic(w, h, 0xFFF9F9F9);
		}
		
		override public function update():void {
			super.update();
			// No point in using the bullet if it is off the screen
			if (!onScreen() || velocity.x != velCheck || velocity.y != 0) {
				// Reset the speed of the bullet if it is invivible
				if (invincible && onScreen()) {		// ( Logic is faulty, but it will suffice for this prototype )
					velocity.x = velCheck;
					velocity.y = 0;
				} else
					kill();
			}
			// This check is a dirty fix because overlap between a bullet and a FlxTilemap is buggy
		}
		
		public function shoot(vel:Number):void {
			velocity.x = vel;
			velCheck = vel;
		}
		
		override public function kill():void {
			// Add information like animations when the bullet hits something
			super.kill();
		}
	}

}