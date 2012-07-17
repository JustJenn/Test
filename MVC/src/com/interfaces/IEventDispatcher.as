package com.interfaces
{
	import starling.events.Event;

	public interface IEventDispatcher
	{
		function addEventListener(type:String, listener:Function):void;
		function dispatchEvent(event:Event):void;
		function hasEventListener(type:String):Boolean;
		function removeEventListener(type:String, listener:Function):void;
		function removeEventListeners(type:String = null):void;

	}
}