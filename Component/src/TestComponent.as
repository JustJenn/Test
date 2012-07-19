package
{
	import com.xiaocai.components.Button;
	import com.xiaocai.components.CheckBox;
	import com.xiaocai.components.Label;
	import com.xiaocai.components.TextInput;
	import com.xiaocai.skins.ButtonSkin;
	import com.xiaocai.skins.CheckBoxSkin;
	import com.xiaocai.skins.Skin;
	
	import flash.utils.setTimeout;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class TestComponent extends Sprite
	{
		[Embed(source="assets/loginDown.png")]
		private var downSkin:Class;
		
		[Embed(source="assets/loginUp.png")]
		private var upSkin:Class;
		
		[Embed(source="assets/textinput.jpg")]
		private var input:Class;
		
		[Embed(source="assets/selected.png")]
		private var selected:Class;
		[Embed(source="assets/notselected.png")]
		private var notselected:Class;
		
		public function TestComponent()
		{
			super();
			
			test();
		}
		
		private function test():void
		{
			var lbl:Label = new Label(300,200, "justtestasdad.");
			lbl.setSize(100,20);
			addChild(lbl);
			
			var txt:Texture = Texture.fromBitmap(new input());
			var skin:Skin = new Skin(txt);
			var input:TextInput = new TextInput(Math.random()*960,Math.random()*640,skin,"默认");
			addChild(input);
			
			var down:Texture = Texture.fromBitmap(new downSkin());
			var up:Texture = Texture.fromBitmap(new upSkin());
			
			var btn:Button = new Button(400,300,new ButtonSkin(up, down),"按钮");
			addChild(btn);
			
			var stxt:Texture = Texture.fromBitmap(new selected());
			var nstxt:Texture = Texture.fromBitmap(new notselected());
			var boxSkin:CheckBoxSkin = new CheckBoxSkin(nstxt, stxt);
			var checkBox:CheckBox = new CheckBox(150,200,boxSkin,"check");
			addChild(checkBox);
		}
	}
}