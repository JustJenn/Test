package com.interfaces
{
	

	public interface IView extends IEventDispatcher
	{
		function initialize(model:IModel=null, assets:IAssetFactory=null):void;
		function destroy():void;
	}
}