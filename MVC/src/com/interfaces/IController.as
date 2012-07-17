package com.interfaces
{
	
	
	public interface IController
	{
		function initialize(view:IView, model:IModel=null):void;
		function get view():IView;
		function destroy():void;
	}
}