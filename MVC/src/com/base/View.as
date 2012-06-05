package com.base
{
	import com.interfaces.IAssetFactory;
	import com.interfaces.IView;
	
	import starling.display.Sprite;
	
	public class View extends Sprite implements IView
	{
		protected var _assetFactory:IAssetFactory;
		
		public function View(assetFactory:IAssetFactory=null)
		{
			_assetFactory = assetFactory;
			super();
		}
		
		public function initialize():void
		{
		}
		
		public function get assetFactory():IAssetFactory
		{
			return _assetFactory;
		}
		
		public function destroy():void
		{
			_assetFactory = null;
		}
	}
}