package com.xiaocai.components
{
	import com.xiaocai.components.supportClasses.IItemRenderer;
	
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	[Event(name="select", type="starling.events.Event")]
	public class List extends ClippedComponent
	{
		public static const SELECT:String = "select";
		protected var _content:Component;
		protected var _scroller:Scroller;
		protected var _itemRenderer:Class = LabelItemRenderer;
		protected var _items:Vector.<IItemRenderer>;
		protected var _itemsProxy:Vector.<ItemRendererProxy>;
		protected var _renderMap:Dictionary;
		
		protected var _selectedIndex:int = -1;
		protected var _lastIndex:int = 0;
		protected var _itemHeight:Number;
		protected var _itemNum:int;
		protected var _ignoreSelected:Boolean = false;
		
		public function List(itemHeight:Number, xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			_itemHeight = itemHeight;
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
			
			_items = new Vector.<IItemRenderer>();
			_itemsProxy = new Vector.<ItemRendererProxy>();
			_renderMap = new Dictionary();
			
			_content = new Component();
			addChild(_content);
			
			_scroller = new Scroller(false, true);
			_scroller.setSize(_width, _height);
			_scroller.hostComponent = _content;
			_scroller.addEventListener(Scroller.CHANGE, onChange);
			addChild(_scroller);
			
			addEventListener(Event.RESIZE, onResize);
		}
		
		protected function createItemProxy():void
		{
			var dataNum:int = _data.length;
			for (var i:int=0;i<dataNum;i++)
			{
				var proxy:ItemRendererProxy = new ItemRendererProxy(_data[i]);
				proxy.x = 0;
				proxy.y = i * _itemHeight;
				_itemsProxy.push(proxy);
			}
			_content.setSize(_width, dataNum*_itemHeight);
		}
		
		protected function createItemRenderer():void
		{
			_itemNum = Math.ceil(_height/_itemHeight);
			for (var i:int=0;i<=_itemNum;i++)
			{
				var itemRenderer:IItemRenderer = new _itemRenderer();
				(itemRenderer as DisplayObject).height = _itemHeight;
				(itemRenderer as DisplayObject).x = _itemsProxy[i].x;
				(itemRenderer as DisplayObject).y = _itemsProxy[i].y;
				itemRenderer.index = i;
				itemRenderer.data = _itemsProxy[i].data;
				_renderMap[i] = itemRenderer;
				
				_content.addChild(itemRenderer as DisplayObject);
				_items.push(itemRenderer);
				(itemRenderer as DisplayObject).addEventListener(TouchEvent.TOUCH, onTouchItem);
			}
		}
		
		protected function clearItemRenderer():void
		{
			if (_content.numChildren > 0)
				_content.removeChildren(0, _content.numChildren-1, true);
			
			_items.length = 0;
			_itemsProxy.length = 0;
		}
		
		protected function onResize(e:Event):void
		{
			_scroller.setSize(_width, _height);
			if (_data)
				createItemRenderer();
		}
		
		protected function onChange(e:Event):void
		{
			_ignoreSelected = true;
			invalidate();
		}
		
		protected function onTouchItem(e:TouchEvent):void
		{
			if(!_enabled)
				return;
			
			var renderer:IItemRenderer = IItemRenderer(e.currentTarget);
			var touch:Touch = e.getTouch(renderer as DisplayObject);
			if(touch && touch.phase == TouchPhase.BEGAN)
			{
				_ignoreSelected = false;
			}
			if (touch && touch.phase == TouchPhase.ENDED && !_ignoreSelected)
			{
				if (!renderer.selected)
				{
					trace("selected:", renderer.index);
					if (_selectedIndex != -1 && _renderMap[_selectedIndex]) //已经选择且在显示列表
						_renderMap[_selectedIndex].selected = false;
				
					_selectedIndex = renderer.index;
					renderer.selected = true;
					dispatchEventWith(SELECT);
				}
			}
		}
		
		protected function update(startIndex:int, endIndex:int):void
		{
			if (_lastIndex == startIndex)
				return ;
			
			var i:int;
			var offset:int = Math.abs(_lastIndex - startIndex);	//位置偏移
			if (_lastIndex > startIndex)	//向下滚动
			{
				for (i=0;i<offset;i++)
				{
					swapItem(startIndex + i, _lastIndex + _itemNum - i);
				}
			}
			else	//向上滚动
			{
				for (i=0;i<offset;i++)
				{
					swapItem(endIndex - i, _lastIndex + i);
				}
			}
			_lastIndex = startIndex;
		}
		
		protected function swapItem(index1:int, index2:int):void
		{
			var proxy:ItemRendererProxy = _itemsProxy[index1];
			var item:IItemRenderer = _renderMap[index2];
			if (item)
			{
				item.index = index1;
				item.data = proxy.data;
				item.selected = index1 == _selectedIndex;
				(item as DisplayObject).x = proxy.x;
				(item as DisplayObject).y = proxy.y;
			
				_renderMap[index1] = item;
				delete _renderMap[index2];
			}				
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		override public function draw():void
		{
			super.draw();
			
			var result:Point = _content.globalToLocal(_globalPt);
			var start:int = int(result.y / _itemHeight);
			
			if (start < 0)
				start = 0;
			else if(start > _data.length - _itemNum - 1)
				start = _data.length - _itemNum - 1;
			
			update(start, start + _itemNum);
		}
		
		override public function dispose():void
		{
			removeChild(_content, true);
			_content = null;
			removeChild(_scroller, true);
			_scroller = null;
			
			_itemRenderer = null;
			_renderMap = null;
			_items.length = 0;
			_itemsProxy.length = 0;
			
			super.dispose();
		}
		
		///////////////////////////////////
		// getters/setters
		///////////////////////////////////
		
		override public function set data(value:Object):void
		{
			super.data = value;
			clearItemRenderer();
			createItemProxy();
			createItemRenderer();
		}

	}
}
class ItemRendererProxy
{
	public var x:Number = 0;
	public var y:Number = 0;
	public var data:Object;
	public function ItemRendererProxy(data:Object)
	{
		this.data = data;
	}
}