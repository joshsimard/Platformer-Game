package com.rename.objects.interactables.physics_based.actor {
	
	
	import com.rename.objects.interactables.physics_based.actor.Actor;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import com.rename.worlds.Level;
	
	public class Player extends Actor {
		
		private var dead:Boolean = false;
		
		public function Player() {
		
		}
		
		override public function update():void {
			super.update();
			
			// Assume no movement
			isMoving = false;
			
			//if on the ground...
			if (collide("Solid", x, y + 1)) {
				onGround = true;
			}
			
			// Handle movement
			var moveInput:int = 0;
			if (Input.check(Key.RIGHT) || Input.check(Key.D)) { 
				moveInput++;
			}
			if (Input.check(Key.LEFT) || Input.check(Key.A)) { 
				moveInput--;
			}
			move(moveInput);
			
			//jump for now
			if (Input.pressed(Key.UP) || Input.pressed(Key.W) && onGround)
				jump();	
				
			if (Input.pressed(Key.R) && !dead)
				death();
			
			//set camera around character
			FP.camera.x = x - FP.halfWidth;
			FP.camera.y = y - FP.halfHeight;
			
			//makes sure the camera doesn't exit the boundaries of the level
			if (FP.camera.x < 0)
				FP.camera.x = 0;
				
			if (FP.camera.x > Level.instance.width - FP.width)
				FP.camera.x = Level.instance.width - FP.width;
				
			if (FP.camera.y < 0)
				FP.camera.y = 0;
				
			if (FP.camera.y > Level.instance.height - FP.height)
				FP.camera.y =  Level.instance.height - FP.height;
		}
		
		//Kills the player! HUZZAH!
		//Also decrements the coins attained in the level
		public function death():void
		{
			dead = false;
			/*for (var i:int = 0; i < Levels.instance.coins; i++)
			{
				Controller.decrementCoins();
			}*/
			FP.world = new Level(Level.levelNum);
		}
	}
}