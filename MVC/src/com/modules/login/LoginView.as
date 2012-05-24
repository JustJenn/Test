package com.modules.login
{
	import com.interfaces.IView;
	
	import flash.text.TextField;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class LoginView extends Sprite implements IView
	{
		private var _background:Image;
		private var _loginBtn:Button;
		private var _registerBtn:Button;
		private var _usernameIpt:TextField;
		private var _passwordIpt:TextField;
		
		public function LoginView()
		{
			super();
		}
		
		public function initialize():void
		{
			_background = new Image();
		}
		public function destroy():void
		{
			
		}
	}
}