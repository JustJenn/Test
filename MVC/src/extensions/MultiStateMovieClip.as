package extensions
{
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	import utils.debug.Logger;
	
	public class MultiStateMovieClip extends MovieClip
	{
		protected var keyFrames:Vector.<KeyFrame>;
		protected var curKeyFrame:KeyFrame;
		
		public function MultiStateMovieClip(defaultFrame:KeyFrame, fps:Number=12)
		{
			super(defaultFrame.textures, fps);
			initialize(defaultFrame);
		}
		
		private function initialize(defaultFrame:KeyFrame):void
		{
			keyFrames = new Vector.<KeyFrame>();
			curKeyFrame = defaultFrame;
			addKeyFrame(defaultFrame);
		}
		
		public function addKeyFrame(frame:KeyFrame):void
		{
			if (indexOfFrame(frame.name) == -1)
				keyFrames.push(frame);
		}
		
		public function removeKeyFrame(name:String):void
		{
			var index:int = indexOfFrame(name);
			if (index != -1)
				keyFrames.splice(index, 1);
		}
		
		protected function indexOfFrame(name:String):int
		{
			var length:int = keyFrames.length;
			var index:int = -1;
			for (var i:int=0; i<length; i++)
			{
				if (keyFrames[i].name == name)
				{
					index = i;
					break;
				}
			}
			return index;
		}
		
		public function playFrame(name:String):void
		{
			var frame:KeyFrame = getKeyFrame(name);
			if (frame != null)
				changeTextures(frame.textures);
		}
		
		protected function changeTextures(textures:Vector.<Texture>):void
		{
			stop();
			var length:int = textures.length;
			for (var i:int=0; i<length; i++)
			{
				if (i < numFrames)
					setFrameTexture(i, textures[i]);
				else
					addFrameAt(i, textures[i]);
			}
			
			var num:int = numFrames;
			for (var j:int=length; j<num; j++)
			{
				removeFrameAt(length);
			}
			texture = textures[0];
			width = texture.width;
			height = texture.height;
			play();
		}
		
		public function getKeyFrame(name:String):KeyFrame
		{
			var index:int = indexOfFrame(name);
			if (index != -1)
				return keyFrames[index];
			return null;
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			keyFrames.splice(0,keyFrames.length);
			curKeyFrame = null;
		}
	}
}