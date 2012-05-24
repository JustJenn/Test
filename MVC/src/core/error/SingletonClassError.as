package core.error
{
	public class SingletonClassError extends Error
	{
		public function SingletonClassError(message:*="", id:*=0)
		{
			super(message, id);
		}
	}
}