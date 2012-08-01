package com.xiaocai.components
{
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
		}
		
		protected function onResize(e:Event):void
		{
			_scroller.setSize(_width, _height);
		}
	}
}