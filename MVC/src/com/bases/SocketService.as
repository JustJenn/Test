package com.bases
{
	import com.interfaces.IMessage;
	import com.interfaces.IService;
	import com.managers.SocketManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	
	import utils.debug.Logger;
	
	[Event(name="responseData",type="flash.events.Event")]
	
	public class SocketService implements IService
	{
		protected var _dest:uint;
		protected var _cmd:uint;
		protected var _callback:Function;
		
		public function SocketService(dest:uint, cmd:uint, callback:Function=null)
		{
			_dest = dest;
			_cmd = cmd;
			_callback = callback;
			SocketManager.registerCallback(_dest, _cmd, response);
		}
		
		public function request(msg:IMessage):void
		{
			SocketManager.sendMessage(_dest, _cmd, msg.objectToBytes());
		}
		
		public function response(bytes:ByteArray):void
		{
			if (_callback != null)
				_callback(bytes);
			else
				Logger.log("Service:id->"+_dest+"-"+_cmd+" 没有注册回调函数.");
		}
		
		public function destroy():void
		{
			SocketManager.removeCallback(_dest, _cmd);
		}
	}
}