package
{
	import org.flixel.*;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")] 
	
	public class Delivery extends FlxGame
	{
		public function Delivery()
		{
			super(640, 480, PlayState, 1);
			forceDebugger = true;
		}
	}
}