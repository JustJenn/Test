package com.xiaocai.components
{
	import starling.display.Quad;

	public class ScrollBar extends Component
	{
		public static const HORIZONTAL:String = "horizontal";
		public static const VERTICAL:String = "vertical";
		
		private static const PADDING_LEFT:int = 1;
		private static const PADDING_TOP:int = 1;
		
		protected var _thumb:Quad;
		protected var _track:Quad;
		protected var _orientation:String;
		protected var _maximum:Number = 1;
		protected var _minimum:Number = 0;
		protected var _value:Number = 0;
		
		public function ScrollBar(orientation:String=ScrollBar.VERTICAL, xpos:Number=0, ypos:Number=0)
		{
			_orientation = orientation;
			super(xpos, ypos);
		}
		
		override protected function init():void
		{
			super.init();
			if (_orientation == VERTICAL)
			{
				setSize(10, 100);
			}
			else
			{
				setSize(100, 10);
			}
			touchable = false;
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_track = new Quad(10, 10, 0x000000);
			_track.alpha = 0.5;
			addChild(_track);
			
			_thumb = new Quad(8, 10, 0xFFFFFF);
			_thumb.x = PADDING_LEFT;
			_thumb.y = PADDING_TOP;
			addChild(_thumb);
		}
		
		override public function draw():void
		{
			super.draw();
			
			_track.width = _width;
			_track.height = _height;
			
			if (_orientation == VERTICAL)
			{
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
			else
			{
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
				}
				
				_thumb.width = thumbWidth;
				_thumb.height = _height - PADDING_TOP;
				_thumb.x = thumbX;
			}
		}
		
		override public function dispose():void
		{
			removeChild(_track, true);
			removeChild(_thumb, true);
			
			super.dispose();
		}
		
		public function set value(num:Number):void
		{
			if (_value != num)
			{
				_value = num;
				invalidate();
			}
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		public function set maximum(value:Number):void
		{
			if (_maximum != value)
			{
				_maximum = value;
				invalidate();
			}
		}
		
		public function get maximum():Number
		{
			return _maximum;
		}
		
		public function set minimum(value:Number):void
		{
			if (_minimum != value)
			{
				_minimum = value;
				invalidate();
			}
		}
		
		public function get minimum():Number
		{
			return _minimum;
		}
	}
}