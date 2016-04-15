package com.rename.objects.interactables.physics_based.actor {
	
	import com.rename.objects.interactables.physics_based.PhysicsObject;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;

	
	public class Actor extends PhysicsObject {
		
		[Embed(source = "/../res/dbg/Square.png")]
		public static const sprite:Class;
		
		private var acc_x:Number = 6;
		private var fric_x:Number = 96;
		private var JUMP_HEIGHT:Number = 7;
		protected var isMoving:Boolean = false;
		protected var onGround:Boolean = false;
		
		
		public function Actor(x:int = 0, y:int = 0, graphic:Graphic = null, mask:Mask = null):void { 
			this.graphic = new Image(sprite);
			
			setHitbox(16, 16);
		}
		
		override public function update():void { 
			super.update();
			
			if (!isMoving) { 
				applyFriction();
			}
		}
		
		public function move(dirSign:int):void { 
			
			if (dirSign != 0) {
				
				if (dirSign != FP.sign(hsp)) { 
					applyFriction();
				}
				
				isMoving = true;
				var xShift:Number = (dirSign * acc_x) * FP.elapsed;
				hsp = FP.clamp(hsp + xShift, -MAXSPEED_X, MAXSPEED_X);
			}
		}
		
		protected function jump():void {
			vsp = -JUMP_HEIGHT;
			
			//not working...(tryind to make it so jump doesn't continue when colliding with solid on roof
			if (collide("solid", x, y - 1))
				vsp = 0;
			
			onGround = false;
		}
		
		private function applyFriction():void { 
			hsp = FP.sign(hsp) * (Math.max(0, Math.abs(hsp) - fric_x * FP.elapsed));
		}
	}
}