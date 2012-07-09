package com.xiaocai.components
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	[Event(name="resize", type="starling.events.Event")]
	[Event(name="draw", type="starling.events.Event")]
	public class Component extends Sprite
	{
		public static const DRAW:String = "draw";
		
		protected var _width:Number;
		protected var _height:Number;
		protected var _tag:int = -1;
		protected var _enabled:Boolean = true;
		protected var _data:Object = null;
		
		public function Component(xpos:Number = 0, ypos:Number = 0)
		{
			super();
			move(xpos, ypos);
			init();
		}
		
		protected function init():void
		{
			createChildren();
			invalidate();
		}
		
		protected function createChildren():void
		{
			
		}
		
		protected function invalidate():void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}
		
		protected function onInvalidate(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function draw():void
		{
			dispatchEvent(new Event(DRAW));
		}
		
		public function setSize(w:Number, h:Number):void
		{
			_width = w;
			_height = h;
			dispatchEvent(new Event(Event.RESIZE));
			invalidate();
		}
		
		public function move(xpos:Number, ypos:Number):void
		{
			x = Math.round(xpos);
			y = Math.round(ypos);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_data = null;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		override public function set width(w:Number):void
		{
			_width = w;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(h:Number):void
		{
			_height = h;
			invalidate();
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
			touchable = _enabled;
			alpha = _enabled ? 1.0 : 0.5;
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}