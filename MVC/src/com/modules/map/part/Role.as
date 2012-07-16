package com.modules.map.part
{
	import extensions.KeyFrame;
	import extensions.MultiStateMovieClip;
	
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	import utils.debug.Logger;
	
	public class Role extends Sprite
	{
		public static const STAND_RIGHT:String = "stand_right";
		public static const STAND_LEFT:String = "stand_left";
		public static const RUN_RIGHT:String = "run_right";
		public static const RUN_LEFT:String = "run_left";
		
		private static const MOVE_STEP:int = 5;
		
		private var _position:Point;
		private var _direction:String;
		private var _mc:MultiStateMovieClip;
		private var _target:Point;
		private var _speed:Point;
		private var _isRunning:Boolean = false;
		
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
			_target = position.clone();
			
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
			removeChild(_mc, true);
			_mc = null;
			
			super.dispose();
		}
		
		public function move(target:Point):void
		{
			if (!_target.equals(target))
			{
				_target = target.clone();
				
				_speed = _target.subtract(position);
				_speed.normalize(MOVE_STEP);
				if (target.x > x)
					playFrame(Role.RUN_RIGHT);
				else
					playFrame(Role.RUN_LEFT);
				_isRunning = true;
			}
		}
		
		public function update():void
		{
			if (_isRunning)
			{
				var dir:Point = _target.subtract(position);
				var distance:Number = Math.sqrt(dir.x*dir.x + dir.y*dir.y);
				if (distance > MOVE_STEP)
				{
					x += _speed.x;
					y += _speed.y;
				}
				else
				{
					x = _target.x;
					y = _target.y;
					_isRunning = false;
					stand();
				}
			}
		}
		
		public function randMove():void
		{
			var m:Boolean = Math.random()>0.5;
			if (m)
			{
				var tg:Point = new Point(int(Math.random()*2600),int(340+Math.random()*160));
				move(tg);
			}
		}
	}
}