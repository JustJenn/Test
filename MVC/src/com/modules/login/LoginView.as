package com.modules.login
{
	import com.base.View;
	import com.interfaces.IAssetFactory;
	import com.interfaces.IMessage;
	import com.protocols.Account;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class LoginView extends View
	{
		private var _background:Image;
		private var _loginBtn:Button;
		private var _registerBtn:Button;
		private var _usernameIpt:TextField;
		private var _passwordIpt:TextField;
		private var _account:Account;
		
		private var _loginRequestEvent:Event;
		private var _registerRequestEvent:Event;
		
		public function LoginView(assetFactory:IAssetFactory=null)
		{
			super(assetFactory);
		}
		
		override public function initialize():void
		{
			createText();
			createBackground();
			createLoginButton();
			createRegisterButton();
			
			_account = new Account();
			_loginRequestEvent = new Event(EventConts.LOGIN_REQUEST);
			_registerRequestEvent = new Event(EventConts.REGISTER_REQUEST);
		}
		
		private function createText():void
		{
			var textformat:TextFormat = new TextFormat(null, 20);
			_usernameIpt = new TextField();
			_usernameIpt.x = 500;
			_usernameIpt.y = 245;
			_usernameIpt.width = 210;
			_usernameIpt.height = 30;
			_usernameIpt.defaultTextFormat = textformat;
			_usernameIpt.type = TextFieldType.INPUT;
			
			_passwordIpt = new TextField();
			_passwordIpt.x = 500;
			_passwordIpt.y = 320;
			_passwordIpt.width = 210;
			_passwordIpt.height = 30;
			_passwordIpt.defaultTextFormat = textformat;
			_passwordIpt.type = TextFieldType.INPUT;
			_passwordIpt.displayAsPassword = true;
			
			Starling.current.nativeStage.addChild(_usernameIpt);
			Starling.current.nativeStage.addChild(_passwordIpt);
		}
		
		private function createBackground():void
		{
			_background = new Image(_assetFactory.getTexture("background"));
			_background.blendMode = BlendMode.NONE;
			addChild(_background);
		}
		
		private function createLoginButton():void
		{
			var upSkin:Texture = _assetFactory.getTexture("loginUp");
			var downSkin:Texture = _assetFactory.getTexture("loginDown");
			
			_loginBtn = new Button(upSkin,"",downSkin);
			_loginBtn.x = 558;
			_loginBtn.y = 430;
			_loginBtn.addEventListener(Event.TRIGGERED, onLoginButtonTriggered);
			addChild(_loginBtn);
		}
		private function onLoginButtonTriggered(e:Event):void
		{
			dispatchEvent(_loginRequestEvent);
		}
		
		private function createRegisterButton():void
		{
			var upSkin:Texture = _assetFactory.getTexture("registerUp");
			var downSkin:Texture = _assetFactory.getTexture("registerDown");
			
			_registerBtn = new Button(upSkin,"",downSkin);
			_registerBtn.x = 330;
			_registerBtn.y = 430;
			_registerBtn.addEventListener(Event.TRIGGERED, onRegisterButtonTriggered);
			addChild(_registerBtn);
		}
		private function onRegisterButtonTriggered(e:Event):void
		{
			dispatchEvent(_registerRequestEvent);
		}
		
		public function get account():IMessage
		{
			_account.username = _usernameIpt.text;
			_account.password = _usernameIpt.text;
			return _account;
		}
		
		override public function destroy():void
		{
			Starling.current.nativeStage.removeChild(_usernameIpt);
			Starling.current.nativeStage.removeChild(_passwordIpt);
			removeChild(_background);
			removeChild(_loginBtn);
			removeChild(_registerBtn);
			
			_background.dispose();
			_loginBtn.dispose();
			_registerBtn.dispose();
		}
	}
}