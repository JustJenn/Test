package com.modules.login
{
	import com.base.Model;
	import com.base.Service;
	import com.interfaces.IMessage;
	import com.interfaces.IService;
	import com.protocols.ActionResult;
	
	import flash.utils.ByteArray;
	
	import starling.events.Event;
	
	public class LoginModel extends Model
	{
		public static const NAME:String = "LoginModel";
		
		private var _loginService:IService;
		private var _registerService:IService;
		private var _loginResult:ActionResult;
		private var _registerResult:ActionResult;
		
		private var _loginResponseEvent:Event;
		private var _registerResponseEvent:Event;
		public function LoginModel()
		{
			super(NAME);
		}
		
		override public function initialize():void
		{
			_loginService = new Service("65537", loginResponse);
			_registerService = new Service("65551", registerResponse);
			_loginResult = new ActionResult();
			_registerResult = new ActionResult();
			_loginResponseEvent = new Event(EventConts.LOGIN_RESPONSE);
			_registerResponseEvent = new Event(EventConts.REGISTER_RESPONSE);
		}
		
		private function loginResponse(bytes:ByteArray):void
		{
			_loginResult.bytesToObject(bytes);
			dispatchEvent(_loginResponseEvent);
		}
		private function registerResponse(bytes:ByteArray):void
		{
			_loginResult.bytesToObject(bytes);
			dispatchEvent(_registerResponseEvent);
		}
		
		public function loginRequest(msg:IMessage):void
		{
			_loginService.request(msg.objectToBytes());
		}
		public function registerRequest(msg:IMessage):void
		{
			_registerService.request(msg.objectToBytes());
		}
		
		public function get registerResult():ActionResult
		{
			return _registerResult;
		}
		
		public function get loginResult():ActionResult
		{
			return _loginResult;
		}

	}
}