package com.base
{
	import com.interfaces.IAssetFactory;
	
	import utils.debug.Logger;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
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
				try
				{
					var bitmap:Bitmap = create(name) as Bitmap;
					textures[name] = Texture.fromBitmap(bitmap);
					bitmap.bitmapData.dispose();
				}
				catch(e:Error)
				{
					Logger.log(e.message);
				}
			}
			return textures[name];
		}
		
		public function getTextureAtlas(name:String):TextureAtlas
		{
			if (textures[name] == undefined)
			{
				try
				{
					var bitmap:Bitmap = create(name+"Atlas") as Bitmap;
					var texture:Texture = Texture.fromBitmap(bitmap);
					var xml:XML = XML(create(name+"Xml"));
					textures[name] = new TextureAtlas(texture, xml);
					bitmap.bitmapData.dispose();
				}
				catch(e:Error)
				{
					Logger.log(e.message);
				}
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