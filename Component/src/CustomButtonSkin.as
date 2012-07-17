package
{
	import com.xiaocai.skins.ButtonSkin;
	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	
	public class CustomButtonSkin extends ButtonSkin
	{
		[Embed(source="assets/loginDown.png")]
		private var downSkin:Class;
		
		[Embed(source="assets/loginUp.png")]
		private var upSkin:Class;
		
		
		public function CustomButtonSkin()
		{
			var down:Bitmap = new downSkin();
			var up:Bitmap = new upSkin();
			var downTxt:Texture = Texture.fromBitmap(down);
			var upTxt:Texture = Texture.fromBitmap(up);
			super(upTxt, downTxt);
		}
	}
}