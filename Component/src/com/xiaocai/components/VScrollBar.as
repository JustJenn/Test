package com.xiaocai.components
{
	public class VScrollBar extends ScrollBar
	{
		public function VScrollBar(xpos:Number=0, ypos:Number=0)
		{
			super(xpos, ypos);
		}
		
		override protected function init():void
		{
			setSize(10, 100);
			super.init();
		}
		
		override public function draw():void
		{
			super.draw();
			
			var thumbHeight:Number = Math.round((_height - 2*PADDING_TOP) * (_height / _maximum));
			var thumbY:Number = Math.round(_value / (_maximum - _height) * (_height - 2*PADDING_TOP - thumbHeight)) + PADDING_TOP;
			
			if(thumbY < PADDING_TOP)
			{
				thumbHeight -= (PADDING_TOP - thumbY);
				thumbY = PADDING_TOP;
			}
			if(thumbY > _height - PADDING_TOP - thumbHeight)
			{
				thumbHeight -= thumbY + thumbHeight - (_height - PADDING_TOP);
			}
			
			_thumb.width = _width - PADDING_LEFT;
			_thumb.height = thumbHeight;
			_thumb.y = thumbY;
		}
	}
}