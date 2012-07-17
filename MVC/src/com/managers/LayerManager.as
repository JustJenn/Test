package com.managers
{
	import com.layers.BaseLayer;
	import com.layers.ModalLayer;
	import com.layers.SceneLayer;
	import com.layers.UILayer;
	import com.layers.WindowLayer;
	
	import starling.display.Sprite;
	
	import utils.error.SingletonClassError;

	public class LayerManager
	{
		private static var _instance:LayerManager = null;
		
		private var _scene:BaseLayer;
		private var _ui:BaseLayer;
		private var _window:BaseLayer;
		private var _modal:BaseLayer;
		
		public function LayerManager()
		{
			if (_instance != null)
				throw new SingletonClassError();
		}
		
		public static function get instance():LayerManager
		{
			if (_instance == null)
				_instance = new LayerManager();
			return _instance;
		}
		
		public function initialize(root:Sprite):void
		{
			_scene = new SceneLayer();
			_ui = new UILayer();
			_window = new WindowLayer();
			_modal = new ModalLayer();
			
			root.addChild(_scene);
			root.addChild(_ui);
			root.addChild(_window);
			root.addChild(_modal);
		}
		
		public function get scene():BaseLayer
		{
			return _scene;
		}
		
		public function get ui():BaseLayer
		{
			return _ui;
		}
		
		public function get window():BaseLayer
		{
			return _window;
		}
		
		public function get modal():BaseLayer
		{
			return _modal;
		}
	}
}