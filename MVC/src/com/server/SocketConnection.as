package com.server
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import utils.debug.Logger;
	import utils.error.SingletonClassError;
	
	public class SocketConnection
	{
		private static const PACKAGE_HEAD:uint = 0xffff;
		private const MIN_AVAILABLE:int = 10;//信息头长度
		
		protected static var _instance:SocketConnection;
		
		protected var _socket:Socket;
		protected var _host:String;
		protected var _port:int;
		protected var _readBuff:ByteArray;
		protected var _contentBuff:ByteArray;
		public function SocketConnection(host:String, port:int)
		{
			if (_instance != null)
				throw new SingletonClassError();
			_readBuff = new ByteArray();
			_contentBuff = new ByteArray();
			_host = host;
			_port = port;
			
			Logger.log("xmlsocket://" + _host + ":" + _port);
			Security.loadPolicyFile("xmlsocket://" + _host + ":" + _port);
			
			_socket = new Socket();	
			_socket.addEventListener(Event.CONNECT,onConnect);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			_socket.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
		}
		
		public static function get instance():SocketConnection
		{
			if (_instance == null)
				_instance = new SocketConnection();
			return _instance;
		}
		
		public function connect():void
		{
			if (!_socket.connected)
			{
				_socket.connect(_host,_port);
				Logger.log("connecting:"+_host+":"+_port);
			}
		}
		private function onConnect(event:Event):void
		{
			Logger.log("connect succeed.");
			
			_socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_socket.addEventListener(Event.CLOSE,onDisconnect);
		}
		private function onSecurityError(event:SecurityErrorEvent):void
		{
			Logger.log("connect security error.");
		}
		private function onIoError(event:IOErrorEvent):void
		{
			Logger.log("connect io error.");
		}
		
		private function onSocketData(event:ProgressEvent):void
		{
			var available:uint = _socket.bytesAvailable;
			_socket.readBytes(_readBuff,0,available);
			
			var head:uint;
			var length:uint;
			var id:uint;
			while(_readBuff.bytesAvailable >= MIN_AVAILABLE)
			{
				head = _readBuff.readUnsignedShort();
				if (head != PACKAGE_HEAD)
					continue;
				
				length = _readBuff.readUnsignedInt();
				id = _readBuff.readInt();
				if (_readBuff.bytesAvailable >= length-MIN_AVAILABLE)
				{
					_readBuff.readBytes(_contentBuff);
					doResponse(id, _contentBuff);
				}
			}
			_contentBuff.clear();
			_readBuff.clear();
		}
		
		private function onDisconnect(event:Event):void
		{
			Logger.log("socket disconnect.");
		}
		
		public function writeToSocket(dest:uint, cmd:uint, content:ByteArray=null):void
		{
			var length:int = 0;
			if (_socket.connected)
			{
				try
				{
					Logger.log("send message to server: id-->"+dest+"-"+cmd+" content-->"+content.toString());
					_socket.writeShort(PACKAGE_HEAD);
					length = content.length+10;
					_socket.writeUnsignedInt(length);
					_socket.writeUnsignedInt(dest);
					_socket.writeUnsignedInt(cmd);
					_socket.writeBytes(content,0,content.length);
					_socket.flush();
				}
				catch (err:Error)
				{
					Logger.log(err.message);
				}
			}
		}
		
		private function doResponse(id:uint, buff:ByteArray):void
		{
			//根据消息id获取对应的Responder解析buff.
			Logger.log("response: id-->"+id.toString()+" content-->"+buff.toString());
		}
	}
}