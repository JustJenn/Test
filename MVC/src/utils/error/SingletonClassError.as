package utils.error
{
	public class SingletonClassError extends Error
	{
		public function SingletonClassError(message:*="", id:*=0)
		{
			super("只能拥有一个实例.", id);
		}
	}
}