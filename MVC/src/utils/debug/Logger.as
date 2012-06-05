package utils.debug
{
	public class Logger
	{
		public function Logger()
		{
		}
		
		public static function log(info:Object):void
		{
			trace(info.toString());
		}
	}
}