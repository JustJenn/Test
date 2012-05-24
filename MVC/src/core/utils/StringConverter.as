package core.utils 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class StringConverter 
	{
		private static var _writeBuff:ByteArray = new ByteArray();
		private static var _readBuff:ByteArray = new ByteArray();
		
		public static function ByteArrayToString(bytes:ByteArray, length:uint):String
		{
			_readBuff.endian = Endian.LITTLE_ENDIAN;
			
			var output:String = "";
			for (var i:int=0;i<length;i++)
			{
				var code:int = bytes.readByte();
				
				if (code == 0)
				{
					continue;
				}
				else
				{
					_readBuff.clear();
					_readBuff.writeByte(code);
					_readBuff.position = 0;

					var temp:String = _readBuff.readMultiByte(1, "us-ascii");
					output += temp;
				}
			}
			
			return output;
		}
		
		public static function StringToByteArray(input:String, length:uint):ByteArray
		{
			_writeBuff.endian = Endian.LITTLE_ENDIAN;
			_writeBuff.clear();
			
			var len:uint = input.length;
			var i:uint;
			for (i=0;i<len;i++)
			{
				_writeBuff.writeByte(input.charCodeAt(i));
			}
			for (i=0;i<(length-len);i++)
			{
				_writeBuff.writeByte(0);
			}
			return _writeBuff;
		}
	}
}