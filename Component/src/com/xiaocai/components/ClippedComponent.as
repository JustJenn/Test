package com.xiaocai.components
{
	import flash.geom.Rectangle;

	public class ClippedComponent extends Component
	{
		protected var _clipRect:Rectangle;
		protected var _changeClip:Boolean = false;
		public function ClippedComponent(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			_clipRect = new Rectangle();
			super(xpos, ypos, skin);
		}
		
		override public function move(xpos:Number, ypos:Number):void
		{
			super.move(xpos, ypos);
			_clipRect.x = xpos;
			_clipRect.y = ypos;
			_changeClip = true;
		}
		
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w, h);
			_clipRect.width = w;
			_clipRect.height = h;
			_changeClip = true;
		}
		
		override public function draw():void
		{
			super.draw();
			if (_changeClip)
			{
				clipRect = _clipRect;
				_changeClip = false;
			}
		}
		
		override public function set x(value:Number):void
		{
			if (x != value)
			{
				super.x = value;
				_clipRect.x = value;
				_changeClip = true;
				invalidate();
			}
		}
		
		override public function set y(value:Number):void
		{
			if (y != value)
			{
				super.y = value;
				_clipRect.y = value;
				_changeClip = true;
				invalidate();
			}
		}
		
		override public function set width(w:Number):void
		{
			if (_width != w)
			{
				super.width = w;
				_clipRect.width = w;
				_changeClip = true;
			}
		}
		
		override public function set height(h:Number):void
		{
			if (_height != h)
			{
				super.height = h;
				_clipRect.height = h;
				_changeClip = true;
			}
		}
	}
}