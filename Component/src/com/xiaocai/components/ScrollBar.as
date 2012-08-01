package com.xiaocai.components
{
	import starling.display.Quad;

	public class ScrollBar extends Component
	{
		protected static const PADDING_LEFT:int = 1;
		protected static const PADDING_TOP:int = 1;
		
		protected var _thumb:Quad;
		protected var _track:Quad;
		protected var _maximum:Number = 1;
		protected var _minimum:Number = 0;
		protected var _value:Number = 0;
		
		public function ScrollBar(xpos:Number=0, ypos:Number=0)
		{
			super(xpos, ypos);
		}
		
		override protected function init():void
		{
			super.init();
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
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		override public function draw():void
		{
			super.draw();
			
			_track.width = _width;
			_track.height = _height;
		}
		
		override public function dispose():void
		{
			removeChild(_track, true);
			_track = null;
			
			removeChild(_thumb, true);
			_thumb = null;
			
			super.dispose();
		}
		
		///////////////////////////////////
		// getters/setters
		///////////////////////////////////
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