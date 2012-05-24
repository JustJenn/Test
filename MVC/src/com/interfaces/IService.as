package com.interfaces
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;

	public interface IService
	{
		function request(bytes:ByteArray):void;
		function response(bytes:ByteArray):void;
		function destroy():void;
	}
}