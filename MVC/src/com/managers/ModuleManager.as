package com.managers
{
	import com.interfaces.IModule;
	
	import flash.utils.Dictionary;
	
	import utils.debug.Logger;

	public class ModuleManager
	{
		private static var dict:Dictionary = new Dictionary();
		public function ModuleManager()
		{
		}
		
		public static function registerModule(name:String, module:IModule):void
		{
			if (dict[name] != undefined)
			{
				Logger.log("模块-->"+name+"已注册.");
				return ;
			}
			dict[name] = module;
		}
		
		public static function removeModule(name:String):void
		{
			if (dict[name] != undefined)
				delete dict[name];
			else
				Logger.log("模块-->"+name+"未注册.");
		}
		
		public static function getModuleByName(name:String):IModule
		{
			if (dict[name] != undefined)
				return dict[name] as IModule;
			
			Logger.log("模块-->"+name+"未注册.");
			return null;
		}
	}
}