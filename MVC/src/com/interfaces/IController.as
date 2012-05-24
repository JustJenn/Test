package com.interfaces
{
	public interface IController
	{
		function initialize():void;
		function set viewComponent(value:Object):void;
		function get viewComponent():Object;
		function destroy():void;
	}
}