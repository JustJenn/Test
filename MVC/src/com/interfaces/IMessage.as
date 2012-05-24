package com.interfaces
{
	import flash.utils.ByteArray;

	public interface IMessage
	{
		function bytesToObject(bytes:ByteArray):void;
		function objectToBytes():ByteArray;
	}
}