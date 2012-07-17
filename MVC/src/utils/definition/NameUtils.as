package utils.definition
{
	public class NameUtils
	{
		public function NameUtils()
		{
		}
		
		public static function getModuleDefinitionName(name:String):String
		{
			return "com.modules."+name.toLocaleLowerCase()+"::"+name+"Module";
		}
	}
}