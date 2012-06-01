package com.base
{
	import com.interfaces.IMessage;
	import com.interfaces.IService;
	import com.managers.SocketManager;
	
	import utils.debug.Logger;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	[Event(name="responseData",type="flash.events.Event")]
	
	public class Service implements IService
	{
		private var _msgID:String;
		private var _callback:Function;
		
		public function Service(msgID:String, callback:Function=null)
		{
			_msgID = msgID;
			_callback = callback;
			SocketManager.registerCallback(_msgID, response);
		}
		
		public function request(bytes:ByteArray):void
		{
			SocketManager.sendMessage(_msgID, bytes);
		}
		
		public function response(bytes:ByteArray):void
		{
			if (_callback != null)
				_callback(bytes);
			else
				Logger.log("Service:id->"+_msgID+" 没有注册回调函数.");
		}
		
		public function destroy():void
		{
			SocketManager.removeCallback(_msgID);
		}
	}
}