package com.modules.map.part
{
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Background extends Sprite
	{
		private var parts:Vector.<Image>;
		private var offset:int;
		public function Background()
		{
			super();
			
			parts = new Vector.<Image>();
			offset = 0;
		}
		
		public function addPart(part:Image):void
		{
			part.x += offset;
			addChild(part);
			parts.push(part);
			
			offset += part.width;
		}
		public function get part3():Image
		{
			return parts[2];
		}
		
		public function destroy():void
		{
			var length:int = parts.length;
			for (var i:int=0;i<length;i++)
			{
				removeChild(parts[i]);
				parts[i].dispose();
			}
			parts = null;
		}
	}
}