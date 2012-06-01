package com.managers
{
	import com.server.SocketConnection;
	
	import utils.debug.Logger;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class SocketManager
	{
		private static var dict:Dictionary = new Dictionary();
		
		public static function registerCallback(key:String, func:Function):void
		{
			if (!dict[key])
				dict[key] = func;
			else
				Logger.log("已经注册协议"+key+"回调函数.");
		}
		
		public static function removeCallback(key:String):void
		{
			delete dict[key];
		}
		
		public static function sendMessage(id:String, content:ByteArray):void
		{
			SocketConnection.instance.writeToSocket(id as uint, content);
		}
		
		public static function callback(key:String, content:ByteArray):void
		{
			if (dict[key])
				dict[key](content);
			else
				Logger.log("未注册协议"+key+"回调函数");
		}
	}
}