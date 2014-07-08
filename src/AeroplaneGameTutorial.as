package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	[SWF(width=440,height=480,frameRate=60)]
	public class AeroplaneGameTutorial extends Sprite
	{
		private var plane:PlayerPlaneRes = new PlayerPlaneRes();
		private var water:WaterTextureRes = new WaterTextureRes();
		
		private var keys:Vector.<int> = new Vector.<int>(255);
		private var SPEED:Number = 3;
		
		private var playerBullets:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var playerBulletsDelay:Number = 0;
		
		private var BULLET_SPEED:Number = 6;
		
		public function AeroplaneGameTutorial()
		{
			this.addChild(water);
			this.addChild(plane);
			
			for (var i:int = 0; i < 255; i++)
				keys[i] = false;
			
			plane.x = stage.stageWidth / 2;
			plane.y = stage.stageHeight - 50;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			this.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private var lastFrameTime:Number = (new Date()).getTime();
		
		private function enterFrame(e:Event):void
		{
			var thisFrame:Date = new Date();
			var dt:Number = (thisFrame.getTime() - lastFrameTime) / 1000;
			lastFrameTime = thisFrame.getTime();
			
			water.y += 1;
			if (water.y > 0)
				water.y -= 512;
			
			if (isUp()) plane.y = Math.max(plane.height / 2, plane.y - SPEED);
			if (isDown()) plane.y = Math.min(stage.stageHeight - plane.height / 2, plane.y + SPEED);
			if (isLeft()) plane.x = Math.max(plane.width / 2, plane.x - SPEED);;
			if (isRight()) plane.x = Math.min(stage.stageWidth - plane.width / 2, plane.x + SPEED);	
			
			// shoot
			playerBulletsDelay -= dt;
			if (isFire() 
				&& playerBulletsDelay <= 0)
			{
				playerBulletsDelay = 0.3;
				shootPlayerBullet();
			}		
			
			// update bulltes positions
			for each( var b:MovieClip in playerBullets)
			{
				b.y -= BULLET_SPEED;
			}
			
			// remove bullets which are getting out of the screen
			while(playerBullets.length > 0 && playerBullets[0].y < -10)
			{
				this.removeChild(playerBullets.shift());
			}
		}
		
		private function keyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
		private function keyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true;
		}
		
		private function isUp():Boolean{
			return (keys[38] || keys[87]);
		}
		
		private function isDown():Boolean{
			return (keys[40] || keys[83]);
		}
		
		private function isLeft():Boolean{
			return (keys[37] || keys[65]);
		}
		
		private function isRight():Boolean{
			return (keys[39] || keys[68]);
		}
		
		private function isFire():Boolean{
			return (keys[17]);
		}		
		
		private function shootPlayerBullet():void
		{
			var playerBullet:MovieClip = new BulletRes();
			
			playerBullet.x = plane.x;
			playerBullet.y = plane.y - plane.width / 2;
			
			this.addChild(playerBullet);
			
			playerBullets.push(playerBullet);
		}
		
		
	}
	
}