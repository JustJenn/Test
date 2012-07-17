package com.xiaocai.skins
{
	import com.xiaocai.components.Component;
	
	import flash.utils.getQualifiedClassName;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Skin extends Image implements ISkin
	{
		protected var _hostComponent:Component;
		protected var _currentState:String;
		
		public function Skin(defaultTexture:Texture)
		{
			super(defaultTexture);
		}
		
		protected function update(w:Number, h:Number):void
		{
			width = w;
			height = h;
		}
		
		protected function onResize(e:Event):void
		{
			validate();
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		public function validate():void
		{
			trace(getQualifiedClassName(_hostComponent), "skin updating...");
			update(_hostComponent.width, _hostComponent.height);
		}
		
		override public function dispose():void
		{
			_hostComponent.removeEventListener(Event.RESIZE, onResize);
			_hostComponent.removeChild(this);
			_hostComponent = null;
			
			super.dispose();
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		public function set hostComponent(value:Component):void
		{
			_hostComponent = value;
			_hostComponent.addEventListener(Event.RESIZE, onResize);
			_hostComponent.addChildAt(this, 0);
			validate();
		}
		
		public function get hostComponent():Component
		{
			return _hostComponent;
		}
		
		public function set currentState(value:String):void
		{
			if (_currentState != value)
			{
				_currentState = value;
				validate();
			}
		}
		
		public function get currentState():String
		{
			return _currentState;
		}
	}
}