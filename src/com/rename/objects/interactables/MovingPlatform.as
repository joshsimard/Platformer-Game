package com.rename.objects.interactables 
{
	import com.rename.ogmoloader.IOgmoNodeHandler;
	import flash.geom.Point;
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import com.rename.Assets;

    public class MovingPlatform extends Entity implements IOgmoNodeHandler
    {
        private var nodes:Array;
        private var from:Point;
        public var to:Point;
        
        public var speed:Number = 2;
		
		public var platform:Image = new Image(Assets.MOVING_PLATFORM);
    
        public function MovingPlatform()
        {
            nodes = [];
        }
        
        public function nodeHandler(node:XML):void
        {
			graphic = platform;
			
            for each (var subNode:XML in node.node)
            {
                nodes.push(new Point(subNode.@x, subNode.@y));
            }
            
            if (nodes.length > 1)
            {
                from = nodes[0];
                to = nodes[1];
                
                x = from.x;
                y = from.y;
            }
			
			//change to type "movingPlatform"
			type = "solid";
			setHitbox(48, 8);
        }
        
        override public function update():void
        {
            if (from == null || to == null)
                return;
                
            moveTowards(to.x, to.y, speed);
            if (distanceToPoint(to.x, to.y) < speed)
            {
                var temp:Point = to;
                to = FP.next(to, nodes, true);
                from = temp;
            }
			
			//move 1 pixel in a loop. Check collision on top of it.
			//if we collide, make sure to move player 1 pixel too.
        }
    }
}