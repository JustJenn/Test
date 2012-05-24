package com.common
{
	import com.base.AssetFactory;
	import com.interfaces.IAssetFactory;
	
	import starling.textures.Texture;
	
	public class ButtonAssetFactory extends AssetFactory
	{
		[Embed(source="assets/button/loginDown.png")]
		private var loginDown:Class;
		[Embed(source="assets/button/loginUp.png")]
		private var loginUp:Class;
		[Embed(source="assets/button/registerDown.png")]
		private var registerDown:Class;
		[Embed(source="assets/button/registerUp.png")]
		private var registerUp:Class;
		
		public function ButtonAssetFactory()
		{
		}
	}
}