package com.interfaces
{
	import starling.textures.Texture;

	public interface IAssetFactory
	{
		function getTexture(name:String):Texture;
		function destroyTexture(name:String):void;
		function destroyAllTexture():void;
	}
}