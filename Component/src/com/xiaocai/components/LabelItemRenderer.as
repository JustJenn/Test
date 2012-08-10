package com.xiaocai.components
{
	import com.xiaocai.components.supportClasses.IItemRenderer;
	import com.xiaocai.skins.ItemRendererSkin;
	
	import flash.display.BitmapData;
	
	import starling.textures.Texture;
	
	public class LabelItemRenderer extends Component implements IItemRenderer
	{
		protected var _label:Label;
		protected var _selected:Boolean = false;
		protected var _index:int = -1;
		public function LabelItemRenderer(xpos:Number=0, ypos:Number=0)
		{
			super(xpos, ypos);
		}
		
		override protected function init():void
		{
			setSize(100,30);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var notSelected:BitmapData = new BitmapData(_width, _height, false, 0xffffff);
			var selected:BitmapData = new BitmapData(_width, _height, false, 0xff7100);
			
			skin = new ItemRendererSkin(Texture.fromBitmapData(notSelected), Texture.fromBitmapData(selected));
			
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
			if (_skin)
				_skin.currentState = _selected? "selected":"notSelected";
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