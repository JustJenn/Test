package com.xiaocai.components
{
	import flash.geom.Point;
	
	import starling.events.Event;

	public class ScrollablePanel extends Panel
	{
		protected var _scroller:Scroller;
		
		public function ScrollablePanel(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			super(xpos, ypos, skin);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_scroller = new Scroller();
			_scroller.setSize(_width, _height);
			_scroller.hostComponent = _content;
			addChild(_scroller);
			
			addEventListener(Event.RESIZE, onResize);
			
			_scroller.addEventListener(Scroller.CHANGE, onChange);
		}
		
		protected function onResize(e:Event):void
		{
			_scroller.setSize(_width, _height);
		}
		
		private function onChange(e:Event):void
		{
			var pt:Point = new Point(_clipRect.x, clipRect.y);
			var result:Point = _content.globalToLocal(pt);
			var needStart:int = int(result.y/100);
			var needEnd:int = Math.ceil((result.y+_height)/100);
			trace("start:", needStart, "end:", needEnd);
		}
	}
}