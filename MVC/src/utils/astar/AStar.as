package utils.astar
{
	import flash.geom.Point;
	
	import utils.debug.Logger;

	public class AStar
	{
		private var _map:Vector.<Vector.<MapNode>>;
		private var _openNodeList:Vector.<MapNode>;
		private var _closeNodeList:Vector.<MapNode>;
		private var _adjacents:Vector.<Point>; //相邻节点
		
		private var _left:int;
		private var _top:int;
		private var _right:int;
		private var _bottom:int;
		
		public function AStar(map:Vector.<Vector.<MapNode>>)
		{
			_map = map;
			_openNodeList = new Vector.<MapNode>();
			_closeNodeList = new Vector.<MapNode>();
			_adjacents = getAdjacents();
			
			_left = _top = 0;
			_right = map[0].length - 1;
			_bottom = map.length - 1;
		}
		
		private function getAdjacents():Vector.<Point>
		{
			var adjs:Vector.<Point> = new Vector.<Point>();
			adjs[0] = new Point( 1,  0);
			adjs[1] = new Point( 1,  1);
			adjs[2] = new Point( 0,  1);
			adjs[3] = new Point(-1,  1);
			adjs[4] = new Point(-1,  0);
			adjs[5] = new Point(-1, -1);
			adjs[6] = new Point( 0, -1);
			adjs[7] = new Point( 1, -1);
			return adjs;
		}
		
		public function findPath(from:Point, to:Point):Vector.<Point>
		{
			Logger.record();
			var isFound:Boolean = finding(from, to);
			Logger.cost("寻路花费时间:");
			
			clear();
			if (isFound)
				return getPath(from, to);
			return null;
		}
		
		private function finding(from:Point, to:Point):Boolean
		{
			var node:MapNode = _map[from.x][from.y];
			node.g = 0;
			node.h = (Math.abs(to.x - from.x) + Math.abs(to.y - from.y))*10;
			node.f = node.g + node.h;
			
			_openNodeList.push(node);
			while(_openNodeList.length > 0)
			{
				_openNodeList.sort(costCompare);
				node = _openNodeList.shift();
				
				if (node.row == to.x && node.col == to.y)
					return true;
				
				_closeNodeList.push(node);
				checkAdjacent(node, to);
			}
			return false;
		}
		
		private function costCompare(node1:MapNode, node2:MapNode):int
		{
			return node1.f - node2.f;
		}
		
		private function clear():void
		{
			_openNodeList.splice(0, _openNodeList.length);
			_closeNodeList.splice(0, _closeNodeList.length);
		}
		
		private function checkAdjacent(node:MapNode, to:Point):void
		{
			var g:int;
			var h:int;
			var f:int;
			var child:MapNode;
			var pt:Point;
			
			for (var i:int=0;i<8;i++)
			{
				pt = getAdjacent(node.row, node.col, i);
				if (pt.x < _top || pt.x > _bottom || pt.y < _left || pt.y > _right)
					continue ;
				if (!_map[pt.x][pt.y].isBlock)
				{
					child = _map[pt.x][pt.y];
					g = node.g + (i % 2 == 0? 10 : 14);
					h = (Math.abs(to.x - pt.x) + Math.abs(to.y - pt.y))*10;
					f = g + h;
					
					checkNode(g, h, f, child, node);
				}
			}
		}
		
		private function getAdjacent(row:int, col:int, dir:int):Point
		{
			var pt:Point = new Point(row, col);
			return pt.add(_adjacents[dir]);
		}
		
		private function checkNode(g:int, h:int, f:int, node:MapNode, parent:MapNode):void
		{
			if (_openNodeList.indexOf(node) == -1)
			{
				if (_closeNodeList.indexOf(node) == -1)
				{
					node.g = g;
					node.h = h;
					node.f = f;
					node.parent = parent;
					_openNodeList.push(node);
				}
				else
				{
					if (node.g > g)
					{
						node.g = g;
						node.h = h;
						node.f = f;
						node.parent = parent;
						_openNodeList.push(node);
						_closeNodeList.splice(_closeNodeList.indexOf(node),1);
					}
				}
			}
			else
			{
				if (node.g > g)
				{
					node.g = g;
					node.h = h;
					node.f = f;
					node.parent = parent;
				}
			}
		}
		
		private function getPath(from:Point, to:Point):Vector.<Point>
		{
			var path:Vector.<Point> = new Vector.<Point>();
			var node:MapNode = _map[to.x][to.y];
			path.push(to);
			while (node.row != from.x || node.col != from.y)
			{
				node = node.parent;
				path.push(new Point(node.row, node.col));
			}
			return path;
		}
	}
}
