package com.xiaocai.skins
{
	import com.xiaocai.components.Component;

	public interface ISkin
	{
		function set hostComponent(value:Component):void;
		function get hostComponent():Component;
		function set currentState(value:String):void;
		function get currentState():String;
		function validate():void;
		function dispose():void;
	}
}