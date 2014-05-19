package
{
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
		
		private function enterFrame(e:Event):void
		{
			water.y += 1;
			if (water.y > 0)
				water.y -= 512;
			
			if (isUp()) plane.y = Math.max(plane.height / 2, plane.y - SPEED);
			if (isDown()) plane.y = Math.min(stage.stageHeight - plane.height / 2, plane.y + SPEED);
			if (isLeft()) plane.x = Math.max(plane.width / 2, plane.x - SPEED);;
			if (isRight()) plane.x = Math.min(stage.stageWidth - plane.width / 2, plane.x + SPEED);			
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
		
		
	}
	
}