package com.xiaocai.components
{
	import starling.text.TextField;

	public class Label extends Component
	{
		protected var _textField:TextField;
		protected var _text:String = "";
		
		public function Label(xpos:Number = 0, ypos:Number = 0, text:String = "")
		{
			_text = text;
			super(xpos, ypos);
		}
		
		override protected function init():void
		{
			setSize(50, 20);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_textField = new TextField(_width, _height, _text);
			addChild(_textField);

			touchable = false;
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function draw():void
		{
			super.draw();
			
			_textField.text = _text;
			_textField.width = _width;
			_textField.height = _height;
		}
		
		override public function dispose():void
		{
			removeChild(_textField, true);
			
			super.dispose();
		}
		
		///////////////////////////////////
		// getters/setters
		///////////////////////////////////
		
		override public function set touchable(value:Boolean):void
		{
			super.touchable = value;
			_textField.touchable = value;
		}
		
		public function set text(value:String):void
		{
			_text = value || "";
			invalidate();
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set fontName(value:String):void
		{
			_textField.fontName = value;
		}
		
		public function set fontSize(value:Number):void
		{
			_textField.fontSize = value;
		}
		
		public function set fontColor(value:uint):void
		{
			_textField.color = value;
		}
		
		public function set fontBold(value:Boolean):void
		{
			_textField.bold = value;
		}
		
		public function set fontItalic(value:Boolean):void
		{
			_textField.italic = value;
		}
		
		public function set fontUnderline(value:Boolean):void
		{
			_textField.underline = value;
		}
		
		public function set vAlign(value:String):void
		{
			_textField.vAlign = value;
		}
		
		public function set hAlign(value:String):void
		{
			_textField.hAlign = value;
		}
		
		public function get textField():TextField
		{
			return _textField;
		}
	}
}