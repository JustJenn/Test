package com.xiaocai.skins
{
	import starling.textures.Texture;
	
	public class ButtonSkin extends Skin
	{
		protected var _upState:Texture;
		protected var _downState:Texture;
		
		public function ButtonSkin(upTexture:Texture, downTexture:Texture = null)
		{
			super(upTexture);
			
			_currentState = "up";
			_upState = upTexture;
			_downState = downTexture || upTexture;
		}
		
		override protected function update(w:Number, h:Number):void
		{
			switch(_currentState)
			{
				case "up":
					texture = _upState;
					break;
				case "down":
					texture = _downState;
					break;
			}
			
			super.update(w, h);
		}
		
		override public function dispose():void
		{
			_upState = null;
			_downState = null;
			
			super.dispose();
		}
	}
}