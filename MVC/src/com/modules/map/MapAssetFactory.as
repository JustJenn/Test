package com.modules.map
{
	import com.base.AssetFactory;
	
	public class MapAssetFactory extends AssetFactory
	{
		[Embed(source="assets/map/role.png")]
		private const roleAtlas:Class;
		[Embed(source="assets/map/role.xml", mimeType="application/octet-stream")]
		private const roleXml:Class;
		[Embed(source="assets/map/map_part1.png")]
		private const mapPart1:Class;
		[Embed(source="assets/map/map_part2.png")]
		private const mapPart2:Class;
		[Embed(source="assets/map/map_part3.png")]
		private const mapPart3:Class;
		
		public function MapAssetFactory()
		{
			super();
		}
		
		override protected function create(name:String):Object
		{
			return new this[name]();
		}
	}
}