package com.interfaces
{
	

	public interface IModule
	{
		function initialize():void;
		function destroy():void;
		function get assets():IAssetFactory;
		function get view():IView;
		function get controller():IController;
		function get model():IModel;
	}
}