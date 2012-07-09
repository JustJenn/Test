package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width="960", height="640", frameRate="60", backgroundColor="#666666")]
	public class ComponentsTest extends Sprite
	{
		private var _starling:Starling;
		public function ComponentsTest()
		{
			_starling = new Starling(TestComponent, stage);
			_starling.showStats = true;
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = false;
			_starling.start();
		}
	}
}