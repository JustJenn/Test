package com.xiaocai.components
{
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;

	public class Panel extends ClippedComponent
	{
		protected var _content:Component;
		protected var _boundsRect:Rectangle;
		
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
		
		override public function draw():void
		{
			super.draw();
			_content.setSize(_boundsRect.width, _boundsRect.height);
		}
		
		public function get content():Component
		{
			return _content;
		}
	}
}