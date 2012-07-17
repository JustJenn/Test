package com.modules.map
{
	import com.bases.View;
	import com.interfaces.IAssetFactory;
	import com.interfaces.IModel;
	import com.modules.map.part.Background;
	import com.modules.map.part.Role;
	
	import extensions.KeyFrame;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import utils.camera.StarlingCameraFocus;
	
	public class MapView extends View
	{
		private const MOVE_STEP:int = 5;
		private var background:Background;
		private var role:Role;
		private var camera:StarlingCameraFocus;
		
		private var textureAtlas:TextureAtlas;
		private var roleList:Vector.<Role>;
		
		[Embed(source="assets/map/up.png")]
		private var up:Class;
		[Embed(source="assets/map/down.png")]
		private var down:Class;
		
		private var tf:TextField;
		
		public function MapView()
		{
			super();
		}
		
		override public function initialize(model:IModel=null, assets:IAssetFactory=null):void
		{
			super.initialize(model, assets);
			createBackground();
			
			textureAtlas = _assets.getTextureAtlas("role");
			roleList = new Vector.<Role>();
			
			role = createRole();
			role.x = 300;
			role.y = 400;
			createCamera();
			
			for (var i:int=0;i<10;i++)
			{
				roleList.push(createRole());
			}
			
			var timer:Timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			
			var downTxt:Texture = Texture.fromBitmap(new down());
			var upTxt:Texture = Texture.fromBitmap(new up());
			var btn:Button = new Button(upTxt, "增加10个", downTxt);
			btn.fontColor = 0xffffff;
			btn.width = 110;
			btn.height = 50;
			btn.fontSize = 20;
			btn.x = 100;
			btn.y = 580;
			btn.addEventListener(Event.TRIGGERED, onTriggered);
			parent.addChild(btn);
			
			tf = new TextField(300,30,"");
			tf.x = 210;
			tf.y = 590;
			tf.fontSize = 20;
			tf.color = 0xff0000;
			parent.addChild(tf);
			tf.text = "当前人数："+(roleList.length+1);
		}
		
		private function onEnterFrame(e:Event):void
		{
			updateRole();
			
			camera.update();
		}
		
		private function updateRole():void
		{
			var length:int = roleList.length;
			
			for (var i:int=0;i<length;i++)
			{
				roleList[i].update();
			}
			
			role.update();
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this, TouchPhase.ENDED);
			if (touch)
			{
				role.move(touch.getLocation(background));
			}
		}
		
		private function createBackground():void
		{
			var part:Image;
			var texture:Texture;
			
			background = new Background();
			for (var i:int=1;i<4;i++)
			{
				texture = _assets.getTexture("mapPart"+i);
				part = new Image(texture);
				background.addPart(part);
			}
			background.flatten();
			addChild(background);
		}
		
		private function createRole():Role
		{
			var standRight:KeyFrame = new KeyFrame(Role.STAND_RIGHT, textureAtlas.getTextures("stand"));
			var runRight:KeyFrame = new KeyFrame(Role.RUN_RIGHT, textureAtlas.getTextures("run"));
			var man:Role = new Role(standRight,24);
			man.addKeyFrame(runRight);
			man.x = Math.random()*2600;
			man.y = int(340+Math.random()*260);
			addChildAt(man, 1);
			Starling.current.juggler.add(man.mc);
			
			return man;
		}
		
		private function createCamera():void
		{
			var layersInfo:Array = [{name:"background", instance:background, ratio:0},
				{name:'role', instance:role, ratio:0}];
			
			camera = new StarlingCameraFocus(Starling.current.stage, this, role, layersInfo);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
			camera.setBoundary(background);
			camera.start();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			var length:int = roleList.length;
			
			for (var i:int=0;i<length;i++)
			{
				roleList[i].randMove();
			}
		}
		
		private function onTriggered(e:Event):void
		{
			for (var i:int=0;i<10;i++)
			{
				roleList.push(createRole());
			}
			tf.text = "当前人数："+(roleList.length+1);
		}
	}
}