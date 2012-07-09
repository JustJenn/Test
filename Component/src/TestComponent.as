package
{
	import com.xiaocai.components.Label;
	
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TestComponent extends Sprite
	{
		public function TestComponent()
		{
			super();
			
			test();
		}
		
		private function test():void
		{
			var lbl:Label = new Label(200,100,"just test.",100,18);
			addChild(lbl);
		}
	}
}