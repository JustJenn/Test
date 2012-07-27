package com.xiaocai.components
{
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Scroller extends Component
	{
		private static const MINIMUM_DRAG_DISTANCE:Number = 0.04;
		
		protected var _horizontalScrollBar:ScrollBar;
		protected var _verticalScrollBar:ScrollBar;
		protected var _hostComponent:Component;
		protected var _maxHorizontalScrollPosition:Number;
		protected var _maxVerticalScrollPosition:Number;
		
		protected var _horizontalScrollBarHeightOffset:Number;
		protected var _verticalScrollBarWidthOffset:Number;
		
		private var _touchPointID:int = -1;
		private var _startTouchX:Number;
		private var _startTouchY:Number;
		private var _startHorizontalScrollPosition:Number;
		private var _startVerticalScrollPosition:Number;
		private var _currentTouchX:Number;
		private var _currentTouchY:Number;
		
		private var _isDraggingHorizontally:Boolean = false;
		private var _isDraggingVertically:Boolean = false;
		private var _isScrollingStopped:Boolean = false;
		
		private var _horizontalScrollPosition:Number = 0;
		private var _verticalScrollPosition:Number = 0;
		
		public function Scroller(xpos:Number=0, ypos:Number=0, skin:Object=null)
		{
			super(xpos, ypos, skin);
		}
		
		override protected function init():void
		{
			setSize(300, 300);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			_horizontalScrollBar = new ScrollBar(ScrollBar.HORIZONTAL);
			_horizontalScrollBar.y = _height - _horizontalScrollBar.height;
			_horizontalScrollBar.width = _width;
			addChild(_horizontalScrollBar);
			
			_verticalScrollBar = new ScrollBar(ScrollBar.VERTICAL);
			_verticalScrollBar.x = _width - _verticalScrollBar.width;
			_verticalScrollBar.height = _height;
			addChild(_verticalScrollBar);
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			if(!_enabled || _touchPointID >= 0)
			{
				return;
			}
			const touch:Touch = e.getTouch(_hostComponent);
			
			if(!touch || touch.phase != TouchPhase.BEGAN)
			{
				return;
			}
			const location:Point = touch.getLocation(this);
			
			_touchPointID = touch.id;
			_startTouchX = _currentTouchX = location.x;
			_startTouchY = _currentTouchY = location.y;
			_startHorizontalScrollPosition = _horizontalScrollPosition;
			_startVerticalScrollPosition = _verticalScrollPosition;
			_isDraggingHorizontally = false;
			_isDraggingVertically = false;
			_isScrollingStopped = false;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
		}
		
		protected function onEnterFrame(e:Event):void
		{
			if(_isScrollingStopped)
				return;
			
			const horizontalInchesMoved:Number = Math.abs(_currentTouchX - _startTouchX) / Capabilities.screenDPI;
			const verticalInchesMoved:Number = Math.abs(_currentTouchY - _startTouchY) / Capabilities.screenDPI;
			if(!_isDraggingHorizontally && horizontalInchesMoved >= MINIMUM_DRAG_DISTANCE)
			{
				if(_horizontalScrollBar)
				{
					_horizontalScrollBar.alpha = 1;
				}
				_isDraggingHorizontally = true;
			}
			if(!_isDraggingVertically && verticalInchesMoved >= MINIMUM_DRAG_DISTANCE)
			{
				if(!_isDraggingHorizontally)
				{
					if(_verticalScrollBar)
					{
						_verticalScrollBar.alpha = 1;
					}
				}
				_isDraggingVertically = true;
			}
			if(_isDraggingHorizontally)
			{
				updateHorizontalScrollFromTouchPosition(_currentTouchX);
			}
			if(_isDraggingVertically)
			{
				updateVerticalScrollFromTouchPosition(_currentTouchY);
			}
		}
		
		protected function onStageTouch(e:TouchEvent):void
		{
			const touch:Touch = e.getTouch(stage);
			if(!touch || (touch.phase != TouchPhase.MOVED && touch.phase != TouchPhase.ENDED) || (_touchPointID >= 0 && touch.id != _touchPointID))
				return;
			
			if(touch.phase == TouchPhase.MOVED)
			{
				const location:Point = touch.getLocation(this);
				_currentTouchX = location.x;
				_currentTouchY = location.y;
			}
			else if(touch.phase == TouchPhase.ENDED)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.removeEventListener(TouchEvent.TOUCH, onStageTouch);
				_touchPointID = -1;
				var isFinishingHorizontally:Boolean = false;
				var isFinishingVertically:Boolean = false;
				if(_horizontalScrollPosition < 0 || _horizontalScrollPosition > _maxHorizontalScrollPosition)
				{
					isFinishingHorizontally = true;
					finishScrollingHorizontally();
				}
				if(_verticalScrollPosition < 0 || _verticalScrollPosition > _maxVerticalScrollPosition)
				{
					isFinishingVertically = true;
					finishScrollingVertically();
				}
				if(isFinishingHorizontally && isFinishingVertically)
				{
					return;
				}
				
				if(!isFinishingHorizontally && _isDraggingHorizontally)
				{
				}
				else
				{
					hideHorizontalScrollBar();
				}
				
				if(!isFinishingVertically && _isDraggingVertically)
				{
				}
				else
				{
					hideVerticalScrollBar();
				}
			}
		}
		
		protected function updateHorizontalScrollFromTouchPosition(touchX:Number):void
		{
			const offset:Number = _startTouchX - touchX;
			var position:Number = _startHorizontalScrollPosition + offset;
			if(position < 0)
			{
				position /= 2;
			}
			else if(position > _maxHorizontalScrollPosition)
			{
				position -= (position - _maxHorizontalScrollPosition) / 2;
			}
			
			horizontalScrollPosition = position;
		}
		
		protected function updateVerticalScrollFromTouchPosition(touchY:Number):void
		{
			const offset:Number = _startTouchY - touchY;
			var position:Number = _startVerticalScrollPosition + offset;
			if(position < 0)
			{
				position /= 2;
			}
			else if(position > _maxVerticalScrollPosition)
			{
				position -= (position - _maxVerticalScrollPosition) / 2;
			}
			
			verticalScrollPosition = position;
		}
		
		private function finishScrollingHorizontally():void
		{
			var targetHorizontalScrollPosition:Number = NaN;
			if(_horizontalScrollPosition < 0)
			{
				targetHorizontalScrollPosition = 0;
			}
			else if(_horizontalScrollPosition > _maxHorizontalScrollPosition)
			{
				targetHorizontalScrollPosition = _maxHorizontalScrollPosition;
			}
			_isDraggingHorizontally = false;
			horizontalScrollPosition = targetHorizontalScrollPosition;
		}
		
		private function finishScrollingVertically():void
		{
			var targetVerticalScrollPosition:Number = NaN;
			if(_verticalScrollPosition < 0)
			{
				targetVerticalScrollPosition = 0;
			}
			else if(_verticalScrollPosition > _maxVerticalScrollPosition)
			{
				targetVerticalScrollPosition = _maxVerticalScrollPosition;
			}
			
			_isDraggingVertically = false;
			verticalScrollPosition = targetVerticalScrollPosition;
		}
		
		public function throwTo(targetHorizontalScrollPosition:Number = NaN, targetVerticalScrollPosition:Number = NaN, duration:Number = 0.25):void
		{
		}
		
		protected function hideVerticalScrollBar():void
		{
		}
		
		protected function hideHorizontalScrollBar():void
		{
		}
		
		override public function draw():void
		{
			super.draw();
			
			_horizontalScrollBar.maximum = _maxHorizontalScrollPosition + _width;
			_verticalScrollBar.maximum = _maxVerticalScrollPosition + _height;
			_horizontalScrollBar.value = _horizontalScrollPosition;
			_verticalScrollBar.value = _verticalScrollPosition;
			
			_hostComponent.x = - _horizontalScrollPosition;
			_hostComponent.y = - _verticalScrollPosition;
		}
		
		public function set hostComponent(value:Component):void
		{
			if (_hostComponent)
				_hostComponent.removeEventListener(TouchEvent.TOUCH, onTouch);
			
			_hostComponent = value;
			_hostComponent.addEventListener(TouchEvent.TOUCH, onTouch);
			_hostComponent.addEventListener(Event.RESIZE, onHostComponentResize);
			_maxHorizontalScrollPosition = _hostComponent.width - _width;
			_maxVerticalScrollPosition = _hostComponent.height - _height;
		}
		
		protected function onHostComponentResize(e:Event):void
		{
			_maxHorizontalScrollPosition = _hostComponent.width - _width;
			_maxVerticalScrollPosition = _hostComponent.height - _height;
			invalidate();
		}
		
		public function get hostComponent():Component
		{
			return _hostComponent;
		}
		
		public function set horizontalScrollPosition(value:Number):void
		{
			if(_horizontalScrollPosition != value)
			{
				_horizontalScrollPosition = value;
				invalidate();
			}
		}
		
		public function get horizontalScrollPosition():Number
		{
			return _horizontalScrollPosition;
		}
		
		
		public function set verticalScrollPosition(value:Number):void
		{
			if(_verticalScrollPosition != value)
			{
				_verticalScrollPosition = value;
				invalidate();
			}
		}
		
		public function get verticalScrollPosition():Number
		{
			return _verticalScrollPosition;
		}
	}
}