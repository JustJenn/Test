package com.modules.map
{
	import com.base.View;
	import com.interfaces.IAssetFactory;
	import com.modules.map.part.Background;
	import com.modules.map.part.Role;
	
	import extensions.KeyFrame;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import utils.camera.StarlingCameraFocus;
	
	public class MapView extends View
	{
		private const MOVE_STEP:int = 5;
		private var background:Background;
		private var role:Role;
		private var camera:StarlingCameraFocus;
		private var target:Point;
		private var isRunning:Boolean = false;
		private var speed:Point;
		
		public function MapView(assetFactory:IAssetFactory=null)
		{
			super(assetFactory);
		}
		
		override public function initialize():void
		{
			createBackground();
			createRole();
			
			var layersInfo:Array = [{name:"background", instance:background, ratio:0},
									{name:'role', instance:role, ratio:0}];
			
			camera = new StarlingCameraFocus(Starling.current.stage, this, role, layersInfo);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
			camera.setBoundary(background);
			camera.start();
			
			target = role.position.clone();
		}
		
		private function onEnterFrame(e:Event):void
		{
			updateRole();
			
			camera.update();
		}
		
		private function updateRole():void
		{
			if (isRunning)
			{
				var dir:Point = target.subtract(role.position);
				var distance:Number = Math.sqrt(dir.x*dir.x+dir.y*dir.y);
				if (distance > MOVE_STEP)
				{
					role.x += speed.x;
					role.y += speed.y;
				}
				else
				{
					role.x = target.x;
					role.y = target.y;
					role.stand();
					isRunning = false;
				}
			}
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if (touch && touch.phase == TouchPhase.BEGAN)
			{
				target = touch.getLocation(background);
				speed = target.subtract(role.position);
				speed.normalize(MOVE_STEP);
				if (target.x > role.x)
					role.playFrame(Role.RUN_RIGHT);
				else
					role.playFrame(Role.RUN_LEFT);
				isRunning = true;
			}
		}
		
		private function createBackground():void
		{
			var part:Image;
			var texture:Texture;
			
			background = new Background();
			for (var i:int=1;i<4;i++)
			{
				texture = assetFactory.getTexture("mapPart"+i);
				part = new Image(texture);
				background.addPart(part);
			}
			background.flatten();
			addChild(background);
		}
		private function createRole():void
		{
			var textureAtlas:TextureAtlas = assetFactory.getTextureAtlas("role");
			var standRight:KeyFrame = new KeyFrame(Role.STAND_RIGHT, textureAtlas.getTextures("stand"));
			var runRight:KeyFrame = new KeyFrame(Role.RUN_RIGHT, textureAtlas.getTextures("run"));
			role = new Role(standRight,24);
			role.addKeyFrame(runRight);
			role.x = 400;
			role.y = 500;
			addChild(role);
			Starling.current.juggler.add(role.mc);
		}
	}
}