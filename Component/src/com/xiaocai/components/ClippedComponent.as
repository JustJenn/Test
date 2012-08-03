package com.xiaocai.components
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ClippedComponent extends Component
	{
		protected var _clipRect:Rectangle;
		protected var _localPt:Point;
		protected var _globalPt:Point;
		protected var _changeClip:Boolean = false;
		public function ClippedComponent(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			_clipRect = new Rectangle();
			_localPt = new Point(0, 0);
			_globalPt = new Point(0, 0);
			super(xpos, ypos, skin);
		}
		
		override public function move(xpos:Number, ypos:Number):void
		{
			if (x != xpos || y != ypos)
			{
				_changeClip = true;
				super.move(xpos, ypos);
				invalidate();
			}
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			if (_width != w || _height != h)
			{
				_changeClip = true;
				super.setSize(w, h);
			}
		}
		
		override public function draw():void
		{
			super.draw();
			if (_changeClip)
			{
				localToGlobal(_localPt, _globalPt);
				
				_clipRect.setTo(_globalPt.x, _globalPt.y, _width, _height);
				clipRect = _clipRect;
				_changeClip = false;
			}
		}
		
		override public function set x(value:Number):void
		{
			if (x != value)
			{
				_changeClip = true;
				super.x = value;
				invalidate();
			}
		}
		
		override public function set y(value:Number):void
		{
			if (y != value)
			{
				_changeClip = true;
				super.y = value;
				invalidate();
			}
		}
		
		override public function set width(w:Number):void
		{
			if (_width != w)
			{
				_changeClip = true;
				super.width = w;
			}
		}
		
		override public function set height(h:Number):void
		{
			if (_height != h)
			{
				_changeClip = true;
				super.height = h;
			}
		}
	}
}