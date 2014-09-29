package  
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{
		public var dying:Boolean;
		protected var moving:Boolean;
		protected var viewRange:FlxSprite;
		
		protected var coolDown:uint;			// Time before the enemy can start shooting/moving again
		protected var warmUp:uint;			// Preps the enemy to shoot a bullet (avoid instantaneous reaction times)
		protected var resetPath:Boolean;
		
		protected var updateView:Boolean;
		
		protected var RANGE:Number = 64;
		protected var BULLET_SPEED:int = 200;
		
		protected var WARM_VAL:int = 30;
		protected var COOL_START:int = 20;
		
		public function Enemy(X:Number, Y:Number, Image:Class, movable:Boolean, faceLeft:Boolean)  {
			super(X, Y);
			loadGraphic(Image, true, false, 16, 16);
			acceleration.y = 400;
			drag.x = Infinity;
			
			offset.x += 2;
			offset.y += 4;
			width = 13; height = 12;
			
			moving = movable;
			resetPath = false;
			if (moving) {
				var ptA:FlxPoint = getMidpoint();
				ptA.y += offset.y; ptA.x += 32; 
				var ptB:FlxPoint = getMidpoint();
				ptB.y += offset.y;
				path = new FlxPath([ptA, ptB]);
				followPath(path, 50, FlxObject.PATH_YOYO);
			}
			
			updateView = true;
			coolDown = 0;
			warmUp = 0;
			health = 5;
			dying  = false;
			
			viewRange = new FlxSprite(x + width, y).makeGraphic(RANGE, height);
			viewRange.solid = false;
			viewRange.alpha = 0;
			(FlxG.state as PlayState).add(viewRange);
			
			addAnimation("idle_" + RIGHT, [0], 0, false);
			addAnimation("idle_" + LEFT, [4], 0, false);
			addAnimation("fall_" + RIGHT, [1], 0, false);
			addAnimation("fall_" + LEFT, [5], 0, false);
			
			addAnimation("shoot_" + RIGHT, [3, 0], 1, false);
			addAnimation("shoot_" + LEFT, [7, 4], 1, false);
			addAnimation("walk_" + RIGHT, [0, 1, 0, 2], 7, true);
			addAnimation("walk_" + LEFT, [4, 5, 4, 6], 7, true);
			
			if (faceLeft)
				facing = LEFT;
			else facing = RIGHT;
		}
		
		protected function shootBullet():void {
			// Get the next avaiable bullet and shoot it
			var bullet:Bullet = (FlxG.state as PlayState)._badBullets.recycle() as Bullet;
			if (facing == LEFT) {
				bullet.reset(x - 1, y + 6);
				bullet.shoot(-BULLET_SPEED);
			} else {
				bullet.reset(x + width + 1, y + 6);
				bullet.shoot(BULLET_SPEED);
			}
			play("shoot_" + facing);
			coolDown = COOL_START;
		}
		
		protected function updateActions():void {
			if (velocity.y > 0) {
				play("fall_" + facing);
			}
			else if (!flickering && velocity.x != 0) {
				if (velocity.x < 0)
					facing = LEFT;
				else if (velocity.x > 0)
					facing = RIGHT;
				play("walk_" + facing);
			}
			else {
				if (flickering) {
					if (velocity.x < 0)
						facing = RIGHT;
					else if (velocity.x > 0)
						facing = LEFT;
				}
				if (coolDown == 0)
					play("idle_" + facing);
			}
		}
		
		override public function update():void {
			super.update();
			
			// Update animations of the enemy
			updateActions();
			// Update the view range of the enemy
			if (updateView) {
				if (facing == RIGHT) {
					viewRange.x = x + width;
					viewRange.y = y;
				}
				else { // facing == LEFT
					viewRange.x = x - RANGE;
					viewRange.y = y;
				}
			}
			
			// Shoot a bullet
			if (warmUp > WARM_VAL) {
				warmUp = 0;
				shootBullet();
			}
			// Cooldown from shooting a bullet
			else if (coolDown == 0) {
				if (viewRange.overlaps((FlxG.state as PlayState)._player)) {
					warmUp++;
					if (moving) {
						stopFollowingPath(false);
						resetPath = true;
					}
				}	// Resume walking
				else if (resetPath) {
					followPath(path, 50, FlxObject.PATH_YOYO);
					resetPath = false;
				}
			}
				
			// Update coolDown and warmUp
			if (warmUp > 0) warmUp ++;
			else if (coolDown > 0) coolDown --;
			
			if (dying) {
				if (moving) {
					stopFollowingPath(true);
					moving = false;
				}
				if (alpha > 0) alpha -= .1;
				else  {
					viewRange.kill();
					super.kill();
				}
			}
		}
		
		override public function hurt(damage:Number):void {
			if (flickering) return;
			
			flicker(.1);
			super.hurt(damage);
			if (moving) {
				stopFollowingPath(false);
				resetPath = true;
			}
			coolDown = COOL_START;
		}
		
		override public function kill():void {
			solid = false;
			acceleration.y = 200;
			dying = true;
			//super.kill();
		}
	}

}