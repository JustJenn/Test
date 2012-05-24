package
{
	import com.interfaces.IAssetFactory;
	import com.modules.login.LoginAssetFactory;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			Starling.current.stage.stageWidth  = 960;
			Starling.current.stage.stageHeight = 640;
			
			var factory:IAssetFactory = new LoginAssetFactory();
			var txture:Texture = factory.getTexture("background");
			var img:Image = new Image(txture);
			img.x = 0;
			img.y = 0;
			addChild(img);
		}
	}
}