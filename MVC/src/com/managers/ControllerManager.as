package com.managers
{
	import com.base.Controller;
	
	import utils.debug.Logger;
	
	import flash.utils.Dictionary;

	public class ControllerManager
	{
		private static var dict:Dictionary = new Dictionary();
		public static function addController(name:String, ctrl:Controller):void
		{
			if (!dict[name])
				dict[name] = ctrl;
			else
				Logger.log("Controller->"+name+"已经注册.");
		}
		
		public static function removeController(name:String):void
		{
			delete dict[name];
		}
		
		public static function getControllerByName(name:String):Controller
		{
			if (dict[name])
				return dict[name];
			
			Logger.log("Controller->"+name+"未注册.");
			return null;
		}
	}
}