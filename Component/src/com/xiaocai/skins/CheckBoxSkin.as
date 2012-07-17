package com.xiaocai.skins
{
	import com.xiaocai.components.Component;
	
	import starling.textures.Texture;
	
	public class CheckBoxSkin extends Skin
	{
		protected var _notSelectedState:Texture;
		protected var _selectedState:Texture;
		
		public function CheckBoxSkin(notSelectedTexture:Texture, selectedTexture:Texture)
		{
			_notSelectedState = notSelectedTexture;
			_selectedState = selectedTexture;
			_currentState = "notSelected";
			super(notSelectedTexture);
		}
		
		override protected function update(w:Number, h:Number):void
		{
			switch (_currentState)
			{
				case "notSelected":
					texture = _notSelectedState;
					break;
				case "selected":
					texture = _selectedState;
					break;
			}
			
			x = 3;
			y = (_hostComponent.height - height)/2;
		}
		
		override public function dispose():void
		{
			_notSelectedState = null;
			_selectedState = null;
			
			super.dispose();
		}
	}
}