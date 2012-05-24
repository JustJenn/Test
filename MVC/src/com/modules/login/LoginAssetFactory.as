package com.modules.login
{
	import com.base.AssetFactory;
	import com.interfaces.IAssetFactory;
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	public class LoginAssetFactory extends AssetFactory
	{
		[Embed(source="assets/login/background.png")]
		private const background:Class;

		public function LoginAssetFactory()
		{
		}
		
		override protected function create(name:String):Bitmap
		{
			return new this[name]() as Bitmap;
		}
	}
}