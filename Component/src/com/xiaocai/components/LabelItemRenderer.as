package com.xiaocai.components
{
	import com.xiaocai.components.supportClasses.IItemRenderer;
	
	import starling.display.Quad;
	
	public class LabelItemRenderer extends Component implements IItemRenderer
	{
		protected var _label:Label;
		protected var _selected:Boolean = false;
		protected var _index:int = 0;
		protected var _bg:Quad;
		public function LabelItemRenderer(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			super(xpos, ypos, skin);
		}
		
		override protected function init():void
		{
			setSize(100,30);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			_bg = new Quad(_width, _height, 0xffffff);
			addChild(_bg);
			
			_label = new Label();
			_label.setSize(_width, _height);
			addChild(_label);
		}
		
		override public function draw():void
		{
			super.draw();
			
			if (_data is String)
				_label.text = _data as String;
			
			_label.setSize(_width, _height);
			_bg.width = _width;
			_bg.height = _height;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			invalidate();
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
	}
}