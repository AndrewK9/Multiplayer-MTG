package as3 {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class PDot extends MovieClip {

		var speedX:Number = Math.floor(Math.random() * (3 - -3)) + -3;
		var speedY:Number = Math.floor(Math.random() * (3 - -3)) + -3;
		public var dead:Boolean = false;

		public function PDot(inputX, inputY) {
			x = inputX;
			y = inputY;
		}

		public function update(){
			y += speedY;
			x += speedX;
		}
	}
}