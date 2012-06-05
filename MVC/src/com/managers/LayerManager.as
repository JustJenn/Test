package com.managers
{
	import utils.error.SingletonClassError;
	
	import starling.display.Sprite;

	public class LayerManager
	{
		private static var _instance:LayerManager
		
		private var _map:Sprite;
		private var _ui:Sprite;
		private var _fight:Sprite;
		private var _popup:Sprite;
		
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
			_map = new Sprite();
			_ui = new Sprite();
			_fight = new Sprite();
			_popup = new Sprite();
			
			root.addChild(_map);
			root.addChild(_ui);
			root.addChild(_fight);
			root.addChild(_popup);
		}
		
		public function get mapLayer():Sprite
		{
			return _map;
		}
		
		public function get uiLayer():Sprite
		{
			return _ui;
		}
		
		public function get fightLayer():Sprite
		{
			return _fight;
		}
		
		public function get popupLayer():Sprite
		{
			return _popup;
		}
	}
}