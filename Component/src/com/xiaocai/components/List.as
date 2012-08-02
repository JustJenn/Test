package com.xiaocai.components
{
	import starling.events.Event;
	import starling.events.TouchEvent;

	public class List extends ClippedComponent
	{
		protected var _content:Component;
		protected var _scroller:Scroller;
		
		protected var _dataProvider:Array;
		public function List(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
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
			
			_scroller = new Scroller(false, true);
			_scroller.setSize(_width, _height);
			_scroller.hostComponent = _content;
			_scroller.addEventListener(Scroller.CHANGE, onChange);
			addChild(_scroller);
			
			addEventListener(Event.RESIZE, onResize);
		}
		
		protected function onResize(e:Event):void
		{
			_scroller.setSize(_width, _height);
		}
		
		protected function onChange(e:Event):void
		{
			
		}
		
		override public function draw():void
		{
			super.draw();
		}

		public function get dataProvider():Array
		{
			return _dataProvider;
		}

		public function set dataProvider(value:Array):void
		{
			_dataProvider = value;
		}

	}
}