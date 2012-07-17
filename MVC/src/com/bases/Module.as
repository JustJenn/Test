package com.bases
{
	import com.interfaces.IAssetFactory;
	import com.interfaces.IController;
	import com.interfaces.IModel;
	import com.interfaces.IModule;
	import com.interfaces.IView;
	import com.managers.ModuleManager;
	
	import starling.display.Sprite;
	
	public class Module implements IModule
	{
		private var _name:String;
		
		protected var _assets:IAssetFactory;
		protected var _view:IView;
		protected var _controller:IController;
		protected var _model:IModel;
		
		public function Module(name:String)
		{
			_name = name;
			ModuleManager.registerModule(_name, this);
		}
		
		public function initialize():void
		{
		}
		
		public function destroy():void
		{
			ModuleManager.removeModule(_name);
		}
		
		public function get assets():IAssetFactory
		{
			return _assets;
		}
		
		public function get view():IView
		{
			return _view;
		}
		
		public function get controller():IController
		{
			return _controller;
		}
		
		public function get model():IModel
		{
			return _model;
		}
	}
}