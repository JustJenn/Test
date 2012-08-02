package com.xiaocai.components
{
	import com.xiaocai.components.supportClasses.ScrollBar;

	public class HScrollBar extends ScrollBar
	{
		public function HScrollBar(xpos:Number=0, ypos:Number=0)
		{
			super(xpos, ypos);
		}
		
		override protected function init():void
		{
			setSize(100, 10);
			super.init();
		}
		
		override public function draw():void
		{
			super.draw();
			
			var thumbWidth:Number = Math.round((_width - 2*PADDING_LEFT) * (_width / _maximum));
			var thumbX:Number = Math.round(_value / (_maximum - _width) * (_width - 2*PADDING_LEFT - thumbWidth)) + PADDING_LEFT;
			
			if(thumbX < PADDING_LEFT)
			{
				thumbWidth -= (PADDING_LEFT - thumbX);
				thumbX = PADDING_LEFT;
			}
			if(thumbX > _width - PADDING_LEFT - thumbWidth)
			{
				thumbWidth -= thumbX + thumbWidth - (_width - PADDING_LEFT);
				if (thumbX > _width - 2*PADDING_LEFT)
					thumbX = _width - 2*PADDING_LEFT;
			}
			
			if (thumbWidth < PADDING_LEFT)
				thumbWidth = PADDING_LEFT;
			
			_thumb.width = thumbWidth;
			_thumb.height = _height - PADDING_TOP;
			_thumb.x = thumbX;
		}
	}
}