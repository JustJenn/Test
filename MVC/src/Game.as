package
{
	import com.modules.login.LoginController;
	import com.modules.login.LoginModel;
	import com.modules.login.LoginView;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			var view:LoginView = new LoginView();
			view.initialize();
			addChild(view);
			var model:LoginModel = new LoginModel();
			model.initialize();
			var ctrl:LoginController = new LoginController(model, view);
			ctrl.initialize();
		}
	}
}