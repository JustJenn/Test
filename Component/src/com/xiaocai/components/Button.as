package com.xiaocai.components
{
	import flash.geom.Rectangle;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Button extends Component
	{
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _isDown:Boolean = false;
		
		public function Button(xpos:Number=0, ypos:Number=0, skin:Object=null, label:String="")
		{
			_labelText = label;
			super(xpos, ypos, skin);
		}
		
		override protected function init():void
		{
			setSize(50,30);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_label = new Label(0, 0, _labelText);
			addChild(_label);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if (!enabled || touch == null) 
				return;
			
			if (touch.phase == TouchPhase.BEGAN && !_isDown)
			{
				if (_skin)
					_skin.currentState = "down";
				_label.y = 2;
				_isDown = true;
			}
			else if (touch.phase == TouchPhase.MOVED && _isDown)
			{
				var buttonRect:Rectangle = getBounds(stage);
				if (touch.globalX < buttonRect.x || touch.globalY < buttonRect.y ||
					touch.globalX > buttonRect.x + buttonRect.width ||
					touch.globalY > buttonRect.y + buttonRect.height )
				{
					onRollOut();
				}
			}
			else if (touch.phase == TouchPhase.ENDED && _isDown)
			{
				onRollOut();
				dispatchEventWith(Event.TRIGGERED, true);
			}
		}
		
		protected function onRollOut():void
		{
			_isDown = false;
			if (_skin)
				_skin.currentState = "up";
			_label.y = 0;
		}
		
		/////////////////////////////////
		// public methods
		/////////////////////////////////
		override public function draw():void
		{
			super.draw();
			
			_label.text = _labelText;
			_label.setSize(_width, _height);
		}
		
		override public function dispose():void
		{
			removeEventListener(TouchEvent.TOUCH, onTouch);
			removeChild(_label, true);
			_label = null;
			
			super.dispose();
		}
		
		////////////////////////////////
		// getters/setters
		////////////////////////////////
		
		public function set labelText(value:String):void
		{
			_labelText = value;
		}
		
		public function get labelText():String
		{
			return _labelText;
		}
		
		public function get label():Label
		{
			return _label;
		}
	}
}