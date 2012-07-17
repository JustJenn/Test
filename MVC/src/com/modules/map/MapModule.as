package com.modules.map
{
	import com.bases.Module;
	import com.managers.LayerManager;
	
	import starling.display.DisplayObject;
	
	public class MapModule extends Module
	{
		public static const NAME:String = "Map";
		public function MapModule()
		{
			super(NAME);
			
			initialize();
		}
		
		override public function initialize():void
		{
			_assets = new MapAssetFactory();
			_view = new MapView();
			
			LayerManager.instance.scene.addChild(_view as DisplayObject);
			
			_view.initialize(null, _assets);
		}
		
		override public function destroy():void
		{
			_view.destroy();
			super.destroy();
		}
	}
}