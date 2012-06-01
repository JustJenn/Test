package com.interfaces
{
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public interface IAssetFactory
	{
		function getTexture(name:String):Texture;
		function getTextureAtlas(name:String):TextureAtlas;
		function destroyTexture(name:String):void;
		function destroyAllTexture():void;
	}
}