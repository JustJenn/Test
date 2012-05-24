package com.modules.login
{
	import com.base.Model;
	import com.base.Service;
	import com.interfaces.IMessage;
	import com.interfaces.IService;
	import com.protocols.ActionResult;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	public class LoginModel extends Model
	{
		public static const NAME:String = "LoginModel";
		
		protected var _loginService:IService;
		protected var _registerService:IService;
		protected var _loginResult:ActionResult;
		protected var _registerResult:ActionResult;
		
		public function LoginModel()
		{
			super(NAME);
		}
		
		override protected function initialize():void
		{
			_loginService = new Service("65537", loginResponse);
			_registerService = new Service("65551", registerResponse);
			_loginResult = new ActionResult();
			_registerResult = new ActionResult();
		}
		
		private function loginResponse(bytes:ByteArray):void
		{
			_loginResult.bytesToObject(bytes);
			dispatchEvent(new Event(EventConts.LOGIN_RETURN));
		}
		private function registerResponse(bytes:ByteArray):void
		{
			_loginResult.bytesToObject(bytes);
			dispatchEvent(new Event(EventConts.REGISTER_RETURN));
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