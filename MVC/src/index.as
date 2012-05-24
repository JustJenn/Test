package
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(width="960", height="640", frameRate="60", backgroundColor="#333333")]
	public class index extends Sprite
	{
		private var _starling:Starling;
		public function index()
		{
			super();
			
			Starling.multitouchEnabled = true;
			Starling.handleLostContext = false;
			
//			var viewPort:Rectangle =  new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			var viewPort:Rectangle =  new Rectangle(0, 0, 960, 640);
			
			if (viewPort.height == 768) // iPad 1+2
				viewPort.setTo(32, 64, 960, 640);
			else if (viewPort.height == 1536) // iPad 3
				viewPort.setTo(64, 128, 1920, 1280);
			
			_starling = new Starling(Game, stage, viewPort);
			_starling.showStats = true;
			_starling.simulateMultitouch = false;
			_starling.enableErrorChecking = false;
			_starling.start();
		}
	}
}