package com.rename.objects.interactables.physics_based.actor {
	
	import com.rename.objects.interactables.physics_based.actor.Actor;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import com.rename.worlds.Level;
	import com.rename.program.Sounds;
	import com.rename.Assets;
	import com.rename.objects.particles.Dust;
	import com.rename.objects.interactables.Coin;
	import com.rename.objects.interactables.SmallKey;
	import com.rename.program.Controller;
	
	public class Player extends Actor {
		
		private var dead:Boolean = false;
		private var form:int = 0;
		public var playerSquare:Spritemap = new Spritemap(Assets.SQUARE);
		public var playerBall:Spritemap = new Spritemap(Assets.BALL, 16, 16);
		
		public function Player() {
			
			//set the graphic
			this.graphic = playerSquare;
			
			setHitbox(16, 28);
			
			//set animations for ball
			playerBall.add("left", [0, 1, 2, 3], 16);
			playerBall.add("right", [0, 3, 2, 1], 16);
			playerBall.add("stand", [0]);
		}
		
		override public function update():void {
			super.update();
			
			// Assume no movement
			isMoving = false;
			
			//if we aren't moving, and we're a ball, stand still
			if (form == 1 && hsp == 0)
				playerBall.play("stand");
			
			//if on the ground...
			if (collide("Solid", x, y + 1)) {
				onGround = true;
			}
			
			//check all collisions
			checkCollisions();
			
			// Handle movement
			var moveInput:int = 0;
			if (Input.check(Key.RIGHT) || Input.check(Key.D)) {
				
				moveInput++;
				
				if (form == 1) {
					playerBall.play("right");
					
					//makes sure you're on the ground and gives you a 50% chance to put dust behind you
					if (onGround && FP.rand(100) < 50)
					{
						FP.world.add(new Dust(x - 8 -FP.rand(4), y + 2 - FP.rand(3)));
					}
				}
			}
			if (Input.check(Key.LEFT) || Input.check(Key.A)) { 
				
				moveInput--;
				
				if (form == 1) {
					playerBall.play("left");
					
					//makes sure you're on the ground and gives you a 50% chance to put dust behind you
					if (onGround && FP.rand(100) < 50)
					{
						FP.world.add(new Dust(x + 8 + FP.rand(4), y + 2 - FP.rand(3)));
					}
				}
			}
			move(moveInput);
			
			//jump if not a ball
			if ((Input.pressed(Key.UP) || Input.pressed(Key.W)) && onGround && form == 0)
				jump();	
				
			//shapeshift!
			if (Input.pressed(Key.SHIFT)) {
				switch(form) {
					case 0:
						doMorphBall();
						break;
					case 1:
						doMorphSquare();
						break;
					default:
						break;
				}
			}
			
			//reset the level
			if (Input.pressed(Key.R) && !dead) {
				dead = true;
			}
			
			//if dead, kill us
			if (dead)
				death();
				
			//CAMERA 
			doCamera();
		}
		
		private function checkCollisions():void
		{
			//if colliding with exit, go to next level!
			if (collide("exit", x, y)) {
				if (Input.pressed(Key.S) || Input.pressed(Key.DOWN))
				{
					Level.levelNum++;
					if(Assets.levels.length > Level.levelNum)
						FP.world = new Level(Level.levelNum);
				}
			}
			
			//if colliding with coin, collect it!
			if (collide("coin", x, y))
			{
				var collisionCoin:Coin = Coin(collide("coin", x, y));
				Level.instance.coins++; //increment coins collected in current level
				collisionCoin.collect();
				FP.world.remove(collisionCoin);
			}
			
			//if colliding with key, collect it!
			if (collide("key", x, y))
			{
				var collisionKey:SmallKey = SmallKey(collide("key", x, y));
				Level.instance.keys++; //increment coins collected in current level
				collisionKey.collect();
				FP.world.remove(collisionKey);
			}
			
			//if colliding with enemy, u ded m8!
			if (collide("enemy", x, y) && !dead)
			{	
				dead = true;
			}
			
			//if colliding with a locked door, if we have key, open door!
			if (collide("locked_door", x, y)) 
			{
				//if we have a key, destroy door!
				
				//else, it is solid
			}
		}
		
		private function doMorphBall():void
		{
			graphic = playerBall;
			form = 1;
			setHitbox(16, 16);
		}
		
		private function doMorphSquare():void
		{
			//make sure we don't collide with ceiling
			if (!collide("Solid", x, y-12)) {
				y = y - 12;
				graphic = playerSquare;
				form = 0;
				setHitbox(16, 28);
			}
		}
		
		public function doCamera():void
		{
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
		
		//kills player and decrements the coins attained in the level
		public function death():void
		{
			//stop movement in x direction
			hsp = 0;
			
			dead = false;
			for (var i:int = 0; i < Level.instance.coins; i++)
			{
				Controller.decrementCoins();
			}
			
			FP.world = new Level(Level.levelNum);
		}
	}
}