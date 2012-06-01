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
		[Embed(source="assets/login/loginDown.png")]
		private const loginDown:Class;
		[Embed(source="assets/login/loginUp.png")]
		private const loginUp:Class;
		[Embed(source="assets/login/registerDown.png")]
		private const registerDown:Class;
		[Embed(source="assets/login/registerUp.png")]
		private const registerUp:Class;

		public function LoginAssetFactory()
		{
		}
		
		override protected function create(name:String):Object
		{
			return new this[name]();
		}
	}
}