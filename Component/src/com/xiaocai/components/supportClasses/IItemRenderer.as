package com.xiaocai.components.supportClasses
{
	public interface IItemRenderer
	{
		function get data():Object;
		function set data(value:Object):void;
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		function get index():int;
		function set index(value:int):void;
	}
}