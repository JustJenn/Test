package
{
	import com.xiaocai.components.Button;
	import com.xiaocai.components.Component;
	import com.xiaocai.components.List;
	import com.xiaocai.components.Panel;
	import com.xiaocai.components.ScrollablePanel;
	import com.xiaocai.components.Scroller;
	import com.xiaocai.skins.ButtonSkin;
	import com.xiaocai.skins.Skin;
	
	import flash.geom.Rectangle;
	
	import starling.display.BlendMode;
	import starling.display.Image;
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
		
		[Embed(source="assets/Lighthouse.jpg")]
		private var lightHouse:Class;
		
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
//			var down:Texture = Texture.fromBitmap(new downSkin());
//			var up:Texture = Texture.fromBitmap(new upSkin());
//			
//			var btn:Button = new Button(500,300,new ButtonSkin(up, down),"按钮");
//			addChild(btn);
//			
//			var stxt:Texture = Texture.fromBitmap(new selected());
//			var nstxt:Texture = Texture.fromBitmap(new notselected());
//			var boxSkin:CheckBoxSkin = new CheckBoxSkin(nstxt, stxt);
//			var checkBox:CheckBox = new CheckBox(150,200,boxSkin,"check");
//			addChild(checkBox);
			
			var txt:Texture = Texture.fromBitmap(new input());
			var skin:Skin = new Skin(txt);
			
			var select:Texture = Texture.fromBitmap(new lightHouse());
			var skin1:Skin = new Skin(select);
			
//			list = new Component(100,20, skin);
//			list.setSize(300,300);
//			addChild(list);
//			
//			host = new Component(0,0,skin1);
//			host.setSize(1024,768);
//			list.clipRect = new Rectangle(100,20,300,300);
//			list.addChild(host);
//			
//
//			var scroll:Scroller = new Scroller();
//			list.addChild(scroll);
//			scroll.hostComponent = host;
			
//			var panel:Panel = new ScrollablePanel(400, 100);
//			panel.setSize(400,290);
//			addChild(panel);
//			
//			var img:Image = new Image(select);
//			panel.addRawChild(img);
			
			var list:List = new List(30, 150, 100);
			addChild(list);
			
			var data:Array = new Array();
			for (var i:int=0;i<100;i++)
			{
				data.push("列表选项"+i);
			}
			list.data = data;
			list.setSize(100, 500);
//			var img2:Image = new Image(select);
//			img2.x = img.width;
//			panel.addRawChild(img2);
		
		}
	}
}