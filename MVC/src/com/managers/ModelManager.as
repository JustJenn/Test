package com.managers
{
	import com.base.Model;
	
	import utils.debug.Logger;
	
	import flash.utils.Dictionary;

	public class ModelManager
	{
		private static var dict:Dictionary = new Dictionary();
		public static function addModel(name:String, model:Model):void
		{
			if (!dict[name])
				dict[name] = model;
			else
				Logger.log("model->"+name+"已经注册.");
		}
		
		public static function removeModel(name:String):void
		{
			delete dict[name];
		}
		
		public static function getModelByName(name:String):Model
		{
			if (dict[name])
				return dict[name];
			
			Logger.log("model->"+name+"未注册.");
			return null;
		}
	}
}