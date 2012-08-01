package com.xiaocai.components
{
	import flash.display.BitmapData;
	import flash.events.FocusEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.StageText;
	import flash.text.StageTextInitOptions;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.MatrixUtil;

	public class TextInput extends Component
	{
		private static const helperMatrix:Matrix = new Matrix();
		private static const helperPoint:Point = new Point();
		
		private static const PADDING_LEFT:Number = 2;
		private static const PADDING_TOP:Number = 1;
		
		protected var _stageText:StageText;
		protected var _snapshotImage:Image;
		protected var _snapshotBitmapData:BitmapData;
		
		protected var _stageTextHasFocus:Boolean = false;
		protected var _text:String = "";
		protected var _editable:Boolean = true;
		
		public function TextInput(xpos:Number=0, ypos:Number=0,skin:Object=null, text:String="")
		{
			_text = text;
			super(xpos, ypos, skin);
		}
		
		override protected function init():void
		{
			setSize(100,20);
			super.init();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			var initOptions:StageTextInitOptions = new StageTextInitOptions(false);
			_stageText = new StageText(initOptions);
			_stageText.addEventListener(FocusEvent.FOCUS_IN, onStageTextFocusIn);
			_stageText.addEventListener(FocusEvent.FOCUS_OUT, onStageTextFocusOut);
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		protected function onStageTextFocusIn(e:FocusEvent):void
		{
			_stageTextHasFocus = true;
			
			if (_snapshotImage)
				_snapshotImage.visible = false;
			
			var index:int = _stageText.text.length;
			_stageText.selectRange(index, index);
		}
		
		protected function onStageTextFocusOut(e:FocusEvent):void
		{
			_stageTextHasFocus = false;
			
			if (_snapshotImage)
				_snapshotImage.visible = true;
			
			_stageText.stage = null;
			
			text = _stageText.text;
		}
		
		protected function onTouch(e:TouchEvent):void
		{
			if (!_editable || _stageTextHasFocus || !_enabled)
				return;
			
			const touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			
			if (touch)
			{
				_stageText.stage = Starling.current.nativeStage;
				_stageText.assignFocus();
			}
		}
		
		protected function refreshSnapshot():void
		{
			const viewPort:Rectangle = _stageText.viewPort;
			if(viewPort.width == 0 || viewPort.height == 0)
				return;
				
			if(!_snapshotBitmapData || _snapshotBitmapData.width != viewPort.width || _snapshotBitmapData.height != viewPort.height)
			{
				if(_snapshotBitmapData)
					_snapshotBitmapData.dispose();
				_snapshotBitmapData = new BitmapData(viewPort.width, viewPort.height, true, 0x00ff00ff);
			}
			
			
			if(!_snapshotBitmapData)
				return;
			
			_snapshotBitmapData.fillRect(_snapshotBitmapData.rect, 0x00ff00ff);
			_stageText.drawViewPortToBitmapData(_snapshotBitmapData);
			
			if(!_snapshotImage)
			{
				_snapshotImage = new Image(starling.textures.Texture.fromBitmapData(_snapshotBitmapData, false, false, Starling.contentScaleFactor));
				_snapshotImage.x = PADDING_LEFT;
				_snapshotImage.y = PADDING_TOP;
				addChild(_snapshotImage);
			}
			else
			{
				_snapshotImage.texture.dispose();
				_snapshotImage.texture = starling.textures.Texture.fromBitmapData(_snapshotBitmapData, false, false, Starling.contentScaleFactor);
				_snapshotImage.readjustSize();
			}
		}
		
		//////////////////////
		// public methods
		////////////////////
		
		override public function draw():void
		{
			super.draw();
			
			if (_stageText.text != _text)
				_stageText.text = _text;
			
			var viewPort:Rectangle = _stageText.viewPort;
			if(!viewPort)
				viewPort = new Rectangle();
			
			helperPoint.x = helperPoint.y = 0;
			getTransformationMatrix(stage, helperMatrix);
			MatrixUtil.transformCoords(helperMatrix, 0, 0, helperPoint);
			
			viewPort.x = Math.round((helperPoint.x + PADDING_LEFT * scaleX) * Starling.contentScaleFactor);
			viewPort.y = Math.round((helperPoint.y + PADDING_TOP * scaleY) * Starling.contentScaleFactor);
			viewPort.width = Math.round(Math.max(1, (_width - PADDING_LEFT * scaleX) * Starling.contentScaleFactor * scaleX));
			viewPort.height = Math.round(Math.max(1, (_height - PADDING_TOP * scaleY) * Starling.contentScaleFactor * scaleY));
			
			if(isNaN(viewPort.width) || isNaN(viewPort.height))
			{
				viewPort.width = 1;
				viewPort.height = 1;
			}
			_stageText.viewPort = viewPort;
			
			refreshSnapshot();
		}
		
		override public function dispose():void
		{
			_stageText.removeEventListener(FocusEvent.FOCUS_IN, onStageTextFocusIn);
			_stageText.removeEventListener(FocusEvent.FOCUS_OUT, onStageTextFocusOut);
			_stageText.dispose();
			_stageText = null;
			
			if (_snapshotBitmapData)
			{
				_snapshotBitmapData.dispose();
				_snapshotBitmapData = null;
			}
			
			if (_snapshotImage)
			{
				_snapshotImage.texture.dispose();
				removeChild(_snapshotImage, true);
				_snapshotImage = null;
			}
			super.dispose();
		}
		
		//////////////////////
		// getters/setters
		/////////////////////
		
		public function set text(value:String):void
		{
			if (!value)
				value = "";
			
			if (_text != value)
			{
				_text = value;
				invalidate();
			}
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set fontSize(value:int):void
		{
			_stageText.fontSize = value;
			invalidate();
		}
		
		public function set fontColor(value:uint):void
		{
			_stageText.color = value;
			invalidate();
		}
		
		public function set displayAsPassword(value:Boolean):void
		{
			_stageText.displayAsPassword = value;
			invalidate();
		}
		
		public function set ediator(value:Boolean):void
		{
			_editable = value;
		}
		
		public function set maxChars(value:int):void
		{
			_stageText.maxChars = value;
		}
		
		public function set returnKeyLabel(value:String):void
		{
			_stageText.returnKeyLabel = value;
		}
	}
}