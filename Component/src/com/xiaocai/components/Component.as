package com.xiaocai.components
{
	import com.xiaocai.skins.ISkin;
	
	import flash.utils.getQualifiedClassName;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.ClippedSprite;
	
	[Event(name="resize", type="starling.events.Event")]
	[Event(name="draw", type="starling.events.Event")]
	public class Component extends ClippedSprite
	{
		public static const DRAW:String = "draw";
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _enabled:Boolean = true;
		protected var _skin:ISkin = null;
		protected var _data:Object = null;
		
		protected var _isInvalid:Boolean = false;
		
		public function Component(xpos:Number = 0, ypos:Number = 0, skin:Object=null)
		{
			super();
			move(xpos, ypos);
			init();
			
			if (skin)
				this.skin = skin;
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
			if (!_isInvalid)
			{
				addEventListener(Event.ENTER_FRAME, onInvalidate);
				_isInvalid = true;
			}
		}
		
		protected function onInvalidate(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
			_isInvalid = false;
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function draw():void
		{
			trace(getQualifiedClassName(this),"drawing...");
			dispatchEvent(new Event(DRAW));
		}
		
		public function setSize(w:Number, h:Number):void
		{
			if (_width != w || _height != h)
			{
				_width = w;
				_height = h;
				dispatchEvent(new Event(Event.RESIZE));
				invalidate();
			}
		}
		
		public function move(xpos:Number, ypos:Number):void
		{
			super.x = Math.round(xpos);
			super.y = Math.round(ypos);
		}
		
		override public function dispose():void
		{
			if (_skin)
				_skin.dispose();
			
			_skin = null;
			_data = null;
			
			super.dispose();
		}
		
		///////////////////////////////////
		// getters/setters
		///////////////////////////////////
		
		override public function set width(w:Number):void
		{
			if (_width != w)
			{
				_width = w;
				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(h:Number):void
		{
			if (_height != h)
			{
				_height = h;
				invalidate();
				dispatchEvent(new Event(Event.RESIZE));
			}
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		public function set skin(value:Object):void
		{
			if (_skin)
				_skin.dispose();
			
			if (value is Class)
			{
				_skin = new value() as ISkin;
				_skin.hostComponent = this;
			}
			else if(value is ISkin)
			{
				_skin = value as ISkin;
				_skin.hostComponent = this;
			}
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