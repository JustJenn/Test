package com.managers
{
	import com.server.SocketConnection;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import utils.debug.Logger;

	public class SocketManager
	{
		private static var dict:Dictionary = new Dictionary();
		
		public static function registerCallback(dest:uint, cmd:uint, func:Function):void
		{
			var key:String = dest + "-" + cmd;
			if (!dict[key])
				dict[key] = func;
			else
				Logger.log("已经注册协议"+key+"回调函数.");
		}
		
		public static function removeCallback(dest:uint, cmd:uint):void
		{
			delete dict[dest+"-"+cmd];
		}
		
		public static function sendMessage(dest:uint, cmd:uint, content:ByteArray):void
		{
			SocketConnection.instance.writeToSocket(dest, cmd, content);
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