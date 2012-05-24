package com.protocols
{
	
	import com.interfaces.IMessage;
	
	import flash.utils.ByteArray;
	
	public class ActionResult implements IMessage
	{
		private var _result:int;
		
		public function ActionResult()
		{
		}
		
		public function get result():int
		{
			return _result;
		}

		public function objectToBytes():ByteArray
		{
			return null;
		}
		
		public function bytesToObject(bytes:ByteArray):void
		{
			_result = bytes.readInt();
		}
	}
}