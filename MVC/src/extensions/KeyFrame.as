package extensions
{
	import starling.textures.Texture;

	public class KeyFrame
	{
		public var name:String;
		public var textures:Vector.<Texture>;
		
		public function KeyFrame(name:String, textures:Vector.<Texture>=null)
		{
			this.name = name;
			this.textures = textures;
		}
	}
}