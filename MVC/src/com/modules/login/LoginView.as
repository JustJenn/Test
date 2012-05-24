package com.modules.login
{
	import com.interfaces.IAssetFactory;
	import com.interfaces.IView;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class LoginView extends Sprite implements IView
	{
		private var _background:Image;
		private var _loginBtn:Button;
		private var _registerBtn:Button;
		private var _usernameIpt:TextField;
		private var _passwordIpt:TextField;
		private var _factory:IAssetFactory;
		
		public function LoginView()
		{
			super();
		}
		
		public function initialize():void
		{
			_factory = new LoginAssetFactory();
			createBackground();
			createLoginButton();
			createRegisterButton();
			createText();
		}
		
		private function createBackground():void
		{
			_background = new Image(_factory.getTexture("background"));
			addChild(_background);
		}
		
		private function createLoginButton():void
		{
			_loginBtn = new Button(_factory.getTexture("loginUp"),"",_factory.getTexture("loginDown"));
			_loginBtn.x = 558;
			_loginBtn.y = 430;
			_loginBtn.addEventListener(Event.TRIGGERED, onLoginButtonTriggered);
			addChild(_loginBtn);
		}
		private function onLoginButtonTriggered(e:Event):void
		{
			dispatchEvent(new Event(EventConts.LOGIN_REQUEST));
		}
		
		private function createRegisterButton():void
		{
			_registerBtn = new Button(_factory.getTexture("registerUp"),"",_factory.getTexture("registerDown"));
			_registerBtn.x = 330;
			_registerBtn.y = 430;
			_registerBtn.addEventListener(Event.TRIGGERED, onRegisterButtonTriggered);
			addChild(_registerBtn);
		}
		private function onRegisterButtonTriggered(e:Event):void
		{
			dispatchEvent(new Event(EventConts.REGISTER_REQUEST));
		}
		
		private function createText():void
		{
			_usernameIpt = new TextField();
			_usernameIpt.x = 528;
			_usernameIpt.y = 250;
			_usernameIpt.type = TextFieldType.INPUT;
			
			_passwordIpt = new TextField();
			_passwordIpt.x = 526;
			_passwordIpt.y = 382;
			_passwordIpt.text = "asdadf";
			_passwordIpt.type = TextFieldType.INPUT;
			_passwordIpt.displayAsPassword = true;
			
			Starling.current.nativeStage.addChild(_usernameIpt);
			Starling.current.nativeStage.addChild(_passwordIpt);
		}
		
		public function destroy():void
		{
			removeChild(_background);
			removeChild(_loginBtn);
			removeChild(_registerBtn);
			
			_background.dispose();
			_loginBtn.dispose();
			_registerBtn.dispose();
		}
	}
}