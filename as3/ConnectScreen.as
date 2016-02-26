package as3 {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.net.navigateToURL;//Needed for URL
	import flash.net.URLRequest;//More URL stuff
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.media.*;//Needed for sound
	
	public class ConnectScreen extends MovieClip {

		var buffer:String = "";
		var charSplit:String = "\n";

		//SFX Info
		var LPopNoise:LPop = new LPop();
		var HPopNoise:HPop = new HPop();
		var myChannel2:SoundChannel = new SoundChannel();
		var myTransform = new SoundTransform(1, 0);
		
		public function ConnectScreen() {
			input_IP.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			input_PORT.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			bttn_JOIN.addEventListener(MouseEvent.CLICK, handleClick);
			MainApp.socket.addEventListener(ProgressEvent.SOCKET_DATA, handleData);
			trace("=============[Loaded Connection Events]==============");
		}
		function handleData(e:ProgressEvent):void {
			buffer += MainApp.socket.readUTFBytes(MainApp.socket.bytesAvailable);
			var messages:Array = buffer.split(charSplit);
			buffer = messages.pop();

			trace(">Incoming Messages:");
			trace(">" + messages);
			trace(">End of Incoming Messages");

			for(var i = 0; i < messages.length; i++){
				var msg:String = messages[i];
            	if(msg.indexOf("EXIT:") == 0){
            		trace(">Sever returned EXIT");
            	    clearScreen();
            	    dispose();
            	    addChild(new MainApp());
            	}
            	if(msg.indexOf("GOOD:") == 0){
            		trace(">Server was taking new players, moving to name screen");
            	    clearScreen();
            	    dispose();
            	    addChild(new NameScreen());
            	}
			}		
		}
		function handleKey(e:KeyboardEvent):void {
			if(e.keyCode == 13) connect();
		}
		function handleClick(e:MouseEvent):void {
			connect();
		}
		function connect():void {
			LPopNoise.play(0, 1, myTransform);
			MainApp.socket.connect(input_IP.text, int(input_PORT.text));
			trace(">Sent server info");
		}		
		public function dispose():void {
			input_IP.removeEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			input_PORT.removeEventListener(KeyboardEvent.KEY_DOWN, handleKey);
			bttn_JOIN.removeEventListener(MouseEvent.CLICK, handleClick);
			MainApp.socket.removeEventListener(ProgressEvent.SOCKET_DATA, handleData);
			trace("=============[Unoaded Connection Events]==============");
		}
		public function clearScreen(){
			trace(">Clearing Stage Children");
			for(var i = numChildren - 1; i >= 0; i--){
				var child = getChildAt(i);
				if(child.hasOwnProperty("dispose")) child.dispose();
				removeChildAt(i);
			}
		}
	}
}
