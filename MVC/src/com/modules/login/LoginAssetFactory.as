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
		private static const background:Class;
		[Embed(source="assets/login/loginDown.png")]
		private static const loginDown:Class;
		[Embed(source="assets/login/loginUp.png")]
		private static const loginUp:Class;
		[Embed(source="assets/login/registerDown.png")]
		private static const registerDown:Class;
		[Embed(source="assets/login/registerUp.png")]
		private static const registerUp:Class;

		public function LoginAssetFactory()
		{
		}
		
		override protected function create(name:String):Object
		{
			return new LoginAssetFactory[name]();
		}
	}
}