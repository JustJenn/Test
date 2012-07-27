package
{
	import com.xiaocai.components.Button;
	import com.xiaocai.components.Component;
	import com.xiaocai.components.Scroller;
	import com.xiaocai.skins.ButtonSkin;
	import com.xiaocai.skins.Skin;
	
	import flash.geom.Rectangle;
	
	import starling.display.BlendMode;
	import starling.display.Sprite;
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
		
		private var list:Component;
		private var host:Component;
		
		private function test():void
		{
//			var lbl:Label = new Label(300,200, "justtestasdad.");
//			lbl.setSize(100,20);
//			addChild(lbl);
//			
//			var txt:Texture = Texture.fromBitmap(new input());
//			var skin:Skin = new Skin(txt);
//			var input:TextInput = new TextInput(Math.random()*960,Math.random()*640,skin,"默认");
//			addChild(input);
//			
			var down:Texture = Texture.fromBitmap(new downSkin());
			var up:Texture = Texture.fromBitmap(new upSkin());
			
			var btn:Button = new Button(500,300,new ButtonSkin(up, down),"按钮");
			addChild(btn);
//			
//			var stxt:Texture = Texture.fromBitmap(new selected());
//			var nstxt:Texture = Texture.fromBitmap(new notselected());
//			var boxSkin:CheckBoxSkin = new CheckBoxSkin(nstxt, stxt);
//			var checkBox:CheckBox = new CheckBox(150,200,boxSkin,"check");
//			addChild(checkBox);
			
			
//			var scrollBar:ScrollBar = new ScrollBar(ScrollBar.HORIZONTAL, 200, 100);
//			scrollBar.maximum = 500;
//			addChild(scrollBar);
//			
//			var func:Function = function ():void
//			{
//				scrollBar.value += 5;
//				setTimeout(func, 100);
//			}
//			
//			setTimeout(func, 100);
			
			
			var txt:Texture = Texture.fromBitmap(new input());
			var skin:Skin = new Skin(txt);
			
			var select:Texture = Texture.fromBitmap(new selected());
			var skin1:Skin = new Skin(select);
			
			list = new Component(100,20, skin);
			list.setSize(300,300);
			list.clipRect = new Rectangle(100,20,300,300);
			addChild(list);
			
			host = new Component(0,0,skin1);
			host.setSize(1200,1200);
			list.addChild(host);
			
			
			
			var scroll:Scroller = new Scroller();
			list.addChild(scroll);
			scroll.hostComponent = host;
		}
	}
}