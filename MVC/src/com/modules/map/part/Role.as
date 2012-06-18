package com.modules.map.part
{
	import extensions.KeyFrame;
	import extensions.MultiStateMovieClip;
	
	import flash.geom.Point;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	import utils.debug.Logger;
	
	public class Role extends Sprite
	{
		public static const STAND_RIGHT:String = "stand_right";
		public static const STAND_LEFT:String = "stand_left";
		public static const RUN_RIGHT:String = "run_right";
		public static const RUN_LEFT:String = "run_left";
		
		private var _position:Point;
		private var _direction:String;
		private var _mc:MultiStateMovieClip;
		
		public function Role(defaultFrame:KeyFrame, fps:int=12)
		{
			super();
			initialize(defaultFrame, fps);
		}
		
		private function initialize(defaultFrame:KeyFrame, fps:int):void
		{
			_mc = new MultiStateMovieClip(defaultFrame, fps);
			_mc.x = -_mc.width/2;
			_mc.y = -_mc.height;
			addChild(_mc);
			
			_direction = defaultFrame.name;
			_position = new Point(x,y);
			
			touchable = false;
		}
		
		public function addKeyFrame(frame:KeyFrame):void
		{
			_mc.addKeyFrame(frame);
		}
		
		public function playFrame(dir:String):void
		{
			if (dir == _direction)
				return;
			
			_direction = dir;
			if (dir == STAND_RIGHT || dir == RUN_RIGHT)
			{
				_mc.playFrame(dir);
				if (_mc.scaleX < 0)
				{
					_mc.scaleX = -_mc.scaleX;
					_mc.x = -_mc.width/2;
				}
			}
			else
			{
				dir = dir.replace("left",'right');
				_mc.playFrame(dir);
				if (_mc.scaleX > 0)
				{
					_mc.scaleX = -_mc.scaleX;
					_mc.x = _mc.width/2;
				}
			}
//			Logger.log("action:"+_direction);
		}
		
		public function stand():void
		{
			var dir:String = _direction.replace("run","stand");
			playFrame(dir);
		}
		
		public function get mc():MovieClip
		{
			return _mc as MovieClip;
		}
		
		public function get position():Point
		{
			_position.x = x;
			_position.y = y;
			return _position;
		}
		
		override public function dispose():void
		{
			super.dispose();
			_mc.dispose();
			_mc = null;
		}
		
		
	}
}