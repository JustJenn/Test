package com.modules.login
{
	import com.interfaces.IModule;
	import com.managers.LayerManager;
	
	public class LoginModule implements IModule
	{
		public function LoginModule()
		{
		}
		
		public function initialize():void
		{
			var view:LoginView = new LoginView(new LoginAssetFactory());
			view.initialize();
			view.flatten();
			LayerManager.instance.uiLayer.addChild(view);
			
			var model:LoginModel = new LoginModel();
			model.initialize();
			
			var ctrl:LoginController = new LoginController(model, view);
			ctrl.initialize();
		}
	}
}