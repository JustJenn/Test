package com.bases
{
	import com.interfaces.IAssetFactory;
	import com.interfaces.IModel;
	import com.interfaces.IView;
	
	import starling.display.Sprite;
	
	public class View extends Sprite implements IView
	{
		protected var _assets:IAssetFactory;
		protected var _model:IModel;
		
		public function View()
		{
			super();
		}
		
		public function initialize(model:IModel=null, assets:IAssetFactory=null):void
		{
			_model = model;
			_assets = assets;
		}
		
		public function destroy():void
		{
			_assets = null;
			_model = null;
		}
	}
}