package com.xiaocai.components
{
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;

	public class Panel extends Component
	{
		protected var _content:Component;
		protected var _clipRect:Rectangle;
		protected var _boundsRect:Rectangle;
		protected var _changeClip:Boolean = false;
		
		public function Panel(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			_clipRect = new Rectangle();
			_boundsRect = new Rectangle();
			super(xpos, ypos, skin);
		}
		
		override protected function init():void
		{
			setSize(100, 100);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_content = new Component();
			addChild(_content);
		}
		
		public function addRawChild(child:DisplayObject):DisplayObject
		{
			var children:DisplayObject = _content.addChild(child);
			getBounds(_content, _boundsRect);
			return children;
		}
		
		public function addRawChildAt(child:DisplayObject, index:int):DisplayObject
		{
			var children:DisplayObject = _content.addChildAt(child, index);
			getBounds(_content, _boundsRect);
			return children;
		}
		
		public function removeRawChild(child:DisplayObject, dispose:Boolean=false):DisplayObject
		{
			var children:DisplayObject = _content.removeChild(child, dispose);
			getBounds(_content, _boundsRect);
			return children;
		}
		
		public function removeRawChildAt(index:int, dispose:Boolean=false):DisplayObject
		{
			var children:DisplayObject = _content.removeChildAt(index, dispose);
			getBounds(_content, _boundsRect);
			return children;
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
				_content.clipRect = _clipRect;
				_changeClip = false;
			}
			_content.setSize(_boundsRect.width, _boundsRect.height);
		}
		
		public function get content():Component
		{
			return _content;
		}
		
		override public function set x(value:Number):void
		{
			super.x = value;
			_clipRect.x = value;
			_changeClip = true;
		}
		
		override public function set y(value:Number):void
		{
			super.y = value;
			_clipRect.y = value;
			_changeClip = true;
		}
		
		override public function set width(w:Number):void
		{
			super.width = w;
			_clipRect.width = w;
			_changeClip = true;
		}
		
		override public function set height(h:Number):void
		{
			super.height = h;
			_clipRect.height = h;
			_changeClip = true;
		}
	}
}