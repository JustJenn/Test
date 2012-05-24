package com.base
{
	import com.interfaces.IAssetFactory;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	public class AssetFactory implements IAssetFactory
	{
		private var textures:Dictionary;
		
		public function AssetFactory()
		{
			textures = new Dictionary();
		}
		
		public function getTexture(name:String):Texture
		{
			if (textures[name] == undefined)
			{
				var bitmap:Bitmap = create(name) as Bitmap;
				textures[name] = Texture.fromBitmap(bitmap);
				bitmap.bitmapData.dispose();
			}
			
			return textures[name];
		}
		
		protected function create(name:String):Object
		{
			return null;
		}
		
		public function destroyTexture(name:String):void
		{
			if (textures[name] != undefined)
			{
				textures[name].dispose();
				delete textures[name];
			}
		}
		
		public function destroyAllTexture():void
		{
			for (var name:String in textures)
			{
				destroyTexture(name);
			}
		}
	}
}