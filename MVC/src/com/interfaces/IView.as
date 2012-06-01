package com.interfaces
{
	public interface IView
	{
		function initialize():void;
		function get assetFactory():IAssetFactory;
		function destroy():void;
	}
}