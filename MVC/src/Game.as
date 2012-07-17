package
{
	import com.managers.LayerManager;
	import com.modules.map.MapAssetFactory;
	import com.modules.map.MapModule;
	import com.modules.map.MapView;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	
	import utils.definition.NameUtils;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			LayerManager.instance.initialize(this);
			
//			new LoginModule().initialize();
//			new MapModule();
			
			var name:String = NameUtils.getModuleDefinitionName(MapModule.NAME);
			
			var cls:Class = getDefinitionByName(name) as Class;
			new cls();
		}
	}
}