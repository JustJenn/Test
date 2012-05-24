package com.protocols
{
	import com.interfaces.IMessage;
	
	import core.utils.StringConverter;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class Account implements IMessage
	{
		private var _username:String;
		private var _password:String;
		
		public function Account()
		{
		}
		
		public function set username(value:String):void
		{
			_username = value;
		}
		
		public function set password(value:String):void
		{
			_password = value;
		}
		
		public function bytesToObject(bytes:ByteArray):void
		{
			var buff:ByteArray = new ByteArray();
			buff.endian = Endian.LITTLE_ENDIAN;
			buff.writeBytes(StringConverter.StringToByteArray(_username, 16));
			buff.writeBytes(StringConverter.StringToByteArray(_password, 20));
			return buff;
		}
		
		public function objectToBytes():ByteArray
		{
			return null;
		}
	}
}