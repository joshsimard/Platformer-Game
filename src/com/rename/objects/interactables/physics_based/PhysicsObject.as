package com.rename.objects.interactables.physics_based {
	
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	public class PhysicsObject extends Entity { 
		
		protected static const GRAVITY:Number = 24;
		
		protected var isGravityActive:Boolean = true;
		
		protected var mass:int = 4;
		protected var FRICTION_X:Number = 0;
		protected var FRICTION_Y:Number = 0;
		protected var MAXSPEED_X:Number = 4;
		protected var MAXSPEED_Y:Number = 16;
		
		public var vsp:Number = 0;
		public var hsp:Number = 0;
		
		public function PhysicsObject() {
	
		}
	
		override public function update():void { 
			
			// Gravity...
			doGravity();
				
			// Update position
			moveTo(x + hsp, y + vsp, "Solid", true);
			
			if (collide("Solid", x + 1, y)) { 
				hsp = 0;
			}
			if (collide("Solid", x, y + 1)) { 
				vsp = 0;
			}
			
		}
		
		protected function doGravity():void {
			
			if (!collide("Solid", x, y + 1)) { 
				vsp = FP.clamp(vsp + (GRAVITY * FP.elapsed), -MAXSPEED_Y, MAXSPEED_Y);
			}
			
		}
	}
}