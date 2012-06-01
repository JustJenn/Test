package com.base
{
	import com.interfaces.IController;
	import com.managers.ControllerManager;

	public class Controller implements IController
	{
		private var _name:String;
		
		protected var _model:Model;
		protected var _viewComponent:Object;
		
		public function Controller(name:String, model:Model=null, viewComponent:Object=null)
		{
			_name = name;
			_viewComponent = viewComponent;
			_model = model;
			ControllerManager.addController(name, this);
		}
		
		public function initialize():void
		{
			
		}
		
		public function get viewComponent():Object
		{
			return _viewComponent;
		}

		public function destroy():void
		{
			ControllerManager.removeController(_name);
			_model = null;
			_viewComponent = null;
		}

	}
}