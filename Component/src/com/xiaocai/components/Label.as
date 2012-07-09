package com.xiaocai.components
{
	import starling.text.TextField;

	public class Label extends Component
	{
		protected var _tf:TextField;
		protected var _text:String = "";
		protected var _textWidth:Number;
		protected var _textHeight:Number;
		
		public function Label(xpos:Number = 0, ypos:Number = 0, text:String = "", textWidth:Number = 50, textHeight:Number = 18)
		{
			_text = text;
			_textWidth = textWidth;
			_textHeight = textHeight;
			super(xpos, ypos);
		}
		
		override protected function createChildren():void
		{
			_tf = new TextField(_textWidth, _textHeight, _text);
			_tf.touchable = false;
			addChild(_tf);
			draw();
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function draw():void
		{
			super.draw();
			
			_tf.text = _text;
			_tf.width = _textWidth;
			_tf.height = _textHeight;
			_width = _tf.width;
			_height = _tf.height;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_tf.removeFromParent(true);
			_tf = null;
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set text(value:String):void
		{
			_text = value;
			if (_text == null)
				_text = "";
			invalidate();
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function get textFiled():TextField
		{
			return _tf;
		}
	}
}