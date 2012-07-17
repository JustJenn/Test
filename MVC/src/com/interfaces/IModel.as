package com.interfaces
{
	import starling.events.Event;

	public interface IModel extends IEventDispatcher
	{
		function initialize():void;
		function destroy():void;
	}
}