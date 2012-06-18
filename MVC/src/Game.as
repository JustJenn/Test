package
{
	import com.managers.LayerManager;
	import com.modules.map.MapAssetFactory;
	import com.modules.map.MapView;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			LayerManager.instance.initialize(this);
			
//			new LoginModule().initialize();

			var mapView:MapView = new MapView(new MapAssetFactory());
			addChild(mapView);
			mapView.initialize();
		}
	}
}