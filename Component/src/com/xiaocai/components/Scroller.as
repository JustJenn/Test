package com.xiaocai.components
{
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import gs.TweenLite;
	
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Scroller extends Component
	{
		private static const MINIMUM_DRAG_DISTANCE:Number = 0.04;
		
		protected var _horizontalScrollBar:HScrollBar;
		protected var _verticalScrollBar:VScrollBar;
		protected var _hostComponent:Component;
		protected var _maxHorizontalScrollPosition:Number;
		protected var _maxVerticalScrollPosition:Number;
		
		protected var _horizontalScrollEnabled:Boolean = true;
		protected var _verticalScrollEnabled:Boolean = true;
		
		protected var _touchPointID:int = -1;
		protected var _startTouchX:Number;
		protected var _startTouchY:Number;
		protected var _startHorizontalScrollPosition:Number;
		protected var _startVerticalScrollPosition:Number;
		protected var _currentTouchX:Number;
		protected var _currentTouchY:Number;
		
		protected var _isDraggingHorizontally:Boolean = false;
		protected var _isDraggingVertically:Boolean = false;
		
		protected var _horizontalScrollPosition:Number = 0;
		protected var _verticalScrollPosition:Number = 0;
		
		protected var _horizontalScrollBarHideTween:TweenLite;
		protected var _verticalScrollBarHideTween:TweenLite;
		
		public function Scroller(hScrollEnabled:Boolean=true, vScrollEnable:Boolean=true)
		{
			_horizontalScrollEnabled = hScrollEnabled;
			_verticalScrollEnabled = vScrollEnable;
			
			super();
		}
		
		override protected function init():void
		{
			setSize(100, 100);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if (_horizontalScrollEnabled)
			{
				_horizontalScrollBar = new HScrollBar();
				_horizontalScrollBar.alpha = 0;
				addChild(_horizontalScrollBar);
			}
			if (_verticalScrollEnabled)
			{
				_verticalScrollBar = new VScrollBar();
				_verticalScrollBar.alpha = 0;
				addChild(_verticalScrollBar);
			}
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			if(!_enabled || _touchPointID >= 0)
			{
				return;
			}
			var touch:Touch = e.getTouch(_hostComponent);
			
			if(!touch || touch.phase != TouchPhase.BEGAN)
			{
				return;
			}
			var location:Point = touch.getLocation(this);
			
			_touchPointID = touch.id;
			_startTouchX = _currentTouchX = location.x;
			_startTouchY = _currentTouchY = location.y;
			_startHorizontalScrollPosition = _horizontalScrollPosition;
			_startVerticalScrollPosition = _verticalScrollPosition;
			_isDraggingHorizontally = false;
			_isDraggingVertically = false;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			stage.addEventListener(TouchEvent.TOUCH, onStageTouch);
		}
		
		protected function onEnterFrame(e:Event):void
		{
			var horizontalInchesMoved:Number = Math.abs(_currentTouchX - _startTouchX) / Capabilities.screenDPI;
			var verticalInchesMoved:Number = Math.abs(_currentTouchY - _startTouchY) / Capabilities.screenDPI;
			if(!_isDraggingHorizontally && horizontalInchesMoved >= MINIMUM_DRAG_DISTANCE)
			{
				if(_horizontalScrollEnabled)
				{
					if (_horizontalScrollBarHideTween)
					{
						TweenLite.removeTween(_horizontalScrollBarHideTween);
						_horizontalScrollBarHideTween = null;
					}
					_horizontalScrollBar.alpha = 1;
					_isDraggingHorizontally = true;
				}
			}
			if(!_isDraggingVertically && verticalInchesMoved >= MINIMUM_DRAG_DISTANCE)
			{
				if(_verticalScrollEnabled)
				{
					if (_verticalScrollBarHideTween)
					{
						TweenLite.removeTween(_verticalScrollBarHideTween);
						_verticalScrollBarHideTween = null;
					}
					_verticalScrollBar.alpha = 1;
					_isDraggingVertically = true;
				}
			}
			if(_isDraggingHorizontally && _horizontalScrollEnabled)
			{
				updateHorizontalScrollPosition(_currentTouchX);
			}
			if(_isDraggingVertically && _verticalScrollEnabled)
			{
				updateVerticalScrollPosition(_currentTouchY);
			}
		}
		
		protected function onStageTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(!touch || (touch.phase != TouchPhase.MOVED && touch.phase != TouchPhase.ENDED) || (_touchPointID >= 0 && touch.id != _touchPointID))
				return;
			
			if(touch.phase == TouchPhase.MOVED)
			{
				var location:Point = touch.getLocation(this);
				_currentTouchX = location.x;
				_currentTouchY = location.y;
			}
			else if(touch.phase == TouchPhase.ENDED)
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				stage.removeEventListener(TouchEvent.TOUCH, onStageTouch);
				_touchPointID = -1;
				
				checkHorizontalScrollPosition();
				checkVerticalScrollPosition();
			}
		}
		
		protected function checkHorizontalScrollPosition():void
		{
			if (_horizontalScrollEnabled)
			{
				finishScrollingHorizontally();
				hideHorizontalScrollBar();
			}
		}
		
		protected function checkVerticalScrollPosition():void
		{
			if (_verticalScrollEnabled)
			{
				finishScrollingVertically();
				hideVerticalScrollBar();
			}
		}
		
		protected function updateHorizontalScrollPosition(touchX:Number):void
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
		
		protected function updateVerticalScrollPosition(touchY:Number):void
		{
			var offset:Number = _startTouchY - touchY;
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
		
		protected function finishScrollingHorizontally():void
		{
			var targetHorizontalScrollPosition:Number = _horizontalScrollPosition;
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
		
		protected function finishScrollingVertically():void
		{
			var targetVerticalScrollPosition:Number = _verticalScrollPosition;
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
		
		protected function hideHorizontalScrollBar():void
		{
			_horizontalScrollBarHideTween = TweenLite.to(_horizontalScrollBar, 0.3, {alpha:0, onComplete:hideHorizontalScrollBarComplete});
		}
		
		protected function hideVerticalScrollBar():void
		{
			_verticalScrollBarHideTween = TweenLite.to(_verticalScrollBar, 0.3, {alpha:0, onComplete:hideVerticalScrollBarComplete});
		}
		
		protected function hideHorizontalScrollBarComplete():void
		{
			TweenLite.removeTween(_horizontalScrollBarHideTween);
			_horizontalScrollBarHideTween = null;
		}
		
		protected function hideVerticalScrollBarComplete():void
		{
			TweenLite.removeTween(_verticalScrollBarHideTween);
			_verticalScrollBarHideTween = null;
		}
		
		protected function onHostComponentResize(e:Event):void
		{
			_maxHorizontalScrollPosition = _hostComponent.width - _width;
			_maxVerticalScrollPosition = _hostComponent.height - _height;
			invalidate();
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		override public function draw():void
		{
			super.draw();
			
			if (_horizontalScrollEnabled)
			{
				_horizontalScrollBar.y = _height - _horizontalScrollBar.height;
				_horizontalScrollBar.width = _width - 10;
				_horizontalScrollBar.maximum = _maxHorizontalScrollPosition + _horizontalScrollBar.width;
				_horizontalScrollBar.value = _horizontalScrollPosition;
				_hostComponent.x = - _horizontalScrollPosition;
			}
			if (_verticalScrollBar)
			{
				_verticalScrollBar.x = _width - _verticalScrollBar.width;
				_verticalScrollBar.height = _height - 10;
				_verticalScrollBar.maximum = _maxVerticalScrollPosition + _verticalScrollBar.height;
				_verticalScrollBar.value = _verticalScrollPosition;
				_hostComponent.y = - _verticalScrollPosition;
			}
		}
		
		override public function dispose():void
		{
			if (_horizontalScrollEnabled)
			{
				removeChild(_horizontalScrollBar, true);
				_horizontalScrollBar = null;
			}
			if (_verticalScrollEnabled)
			{
				removeChild(_verticalScrollBar, true);
				_verticalScrollBar = null;
			}
			if (_hostComponent)
			{
				_hostComponent.removeEventListener(TouchEvent.TOUCH, onTouch);
				_hostComponent.removeEventListener(Event.RESIZE, onHostComponentResize);
				_hostComponent = null;
			}
			super.dispose();
		}
		
		///////////////////////////////////
		// getters/setters
		///////////////////////////////////
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