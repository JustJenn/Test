package utils.astar
{
	public class MapNode
	{
		private var _flag:int;
		private var _row:int;
		private var _col:int;
		private var _g:int;
		private var _h:int;
		private var _f:int;
		private var _parent:MapNode;
		
		public function MapNode(row:int,col:int,flag:int)
		{
			_row = row;
			_col = col;
			_flag = flag;
		}
		
		public function get isBlock():Boolean
		{
			return !Boolean(_flag);
		}
		
		public function get row():int
		{
			return _row
		}
		
		public function get col():int
		{
			return _col;
		}
		
		public function set g(value:int):void
		{
			_g = value;
		}
		public function get g():int
		{
			return _g;
		}
		
		public function set h(value:int):void
		{
			_h = value;
		}
		public function get h():int
		{
			return _h;
		}
		
		public function set f(value:int):void
		{
			_f = value;
		}
		public function get f():int
		{
			return _f;
		}
		
		public function set parent(value:MapNode):void
		{
			_parent = value;
		}
		public function get parent():MapNode
		{
			return  _parent;
		}
	}
}