package com.base
{
	import com.interfaces.IModel;
	import com.managers.ModelManager;
	
	import flash.events.EventDispatcher;

	public class Model extends EventDispatcher implements IModel
	{
		private var _name:String;
		public function Model(name:String)
		{
			ModelManager.addModel(name, this);
			_name = name;
		}
		
		public function initialize():void
		{
			
		}
		
		public function destroy():void
		{
			ModelManager.removeModel(_name);
		}
	}
}