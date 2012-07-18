package
{
	import com.managers.LayerManager;
	import com.modules.map.MapModule;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			LayerManager.instance.initialize(this);
			
//			new LoginModule().initialize();
//			new MapModule();
			
//			var name:String = NameUtils.getModuleDefinitionName(MapModule.NAME);
			
//			var cls:Class = getDefinitionByName(name) as Class;
//			new cls();
			
			new MapModule();
		}
	}
}