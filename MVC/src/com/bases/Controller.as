package com.bases
{
	import com.interfaces.IController;
	import com.interfaces.IModel;
	import com.interfaces.IView;
	
	import starling.display.Sprite;

	public class Controller implements IController
	{
		private var _name:String;
		
		protected var _model:IModel;
		protected var _view:IView;
		
		public function Controller()
		{
		}
		
		public function initialize(view:IView=null, model:IModel=null):void
		{
			
		}
		
		public function get view():IView
		{
			return _view;
		}

		public function destroy():void
		{
			_model = null;
			_view = null;
		}

	}
}