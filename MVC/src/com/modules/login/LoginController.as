package com.modules.login
{
	import com.bases.Controller;
	import com.bases.Model;
	
	import starling.events.Event;
	
	public class LoginController extends Controller
	{
		public static const NAME:String = "LoginController";
		public function LoginController(model:Model=null, viewComponent:Object=null)
		{
			super(NAME, model, viewComponent);
		}
		
		private function get view():LoginView
		{
			return _viewComponent as LoginView;
		}
		private function get model():LoginModel
		{
			return _model as LoginModel;
		}
		
		override public function initialize():void
		{
			view.addEventListener(EventConts.LOGIN_REQUEST, loginRequestHandler);
			view.addEventListener(EventConts.REGISTER_REQUEST, registerRequestHandler);
			model.addEventListener(EventConts.LOGIN_RESPONSE, loginReturnHandler);
			model.addEventListener(EventConts.REGISTER_RESPONSE, registerReturnHandler);
		}
		
		private function loginRequestHandler(e:Event):void
		{
			model.loginRequest(view.account);
		}
		private function registerRequestHandler(e:Event):void
		{
			
		}
		
		private function loginReturnHandler(e:Event):void
		{
			
		}
		private function registerReturnHandler(e:Event):void
		{
			
		}
		
	}
}