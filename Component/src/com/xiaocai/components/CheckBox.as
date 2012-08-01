package com.xiaocai.components
{
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	[Event(name="state_change", type="starling.events.Event")]
	public class CheckBox extends Component
	{
		public static const STATE_CHANGE:String = "state_change";
		
		private static const PADDING_LEFT:Number = 20;
		private static const PADDING_TOP:Number = 0;
		
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _selected:Boolean = false;
		
		public function CheckBox(xpos:Number=0, ypos:Number=0,skin:Object=null, label:String="")
		{
			_labelText = label;
			super(xpos, ypos, skin);
		}
		
		override protected function init():void
		{
			setSize(70,20);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_label = new Label(20,0,_labelText);
			_label.hAlign = HAlign.LEFT;
			_label.touchable = true;
			addChild(_label);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch && enabled)
			{
				_selected = !_selected;
				updateState();
				if (hasEventListener(STATE_CHANGE))
					dispatchEvent(new Event(STATE_CHANGE));
			}
		}
		
		protected function updateState():void
		{
			if (_skin)
				_skin.currentState = _selected ? "selected":"notSelected";
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function draw():void
		{
			super.draw();
			
			_label.text = _labelText;
			_label.setSize(_width - PADDING_LEFT, _height - PADDING_TOP);
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
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			updateState();
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
	}
}