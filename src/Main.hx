package;

import openfl.display.Sprite;
import openfl.Lib;
import  openfl.display.Bitmap;
import openfl.events.Event;

import android.AppAndroidInterface;


class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		Lib.current.stage.addEventListener( Event.ENTER_FRAME, this._onUpdate );
		
		trace("---------------Start   ----------------");
		
		var nativeAndroid = AppAndroidInterface.sharedInterface();
		trace('Android versionString: ' + nativeAndroid.androidVersionString());
		trace('Android versionNumber: ' + nativeAndroid.androidVersionNumber());

		    // Test various types
			var aBool = true;
			var anInt = 21;
			var aFloat = 451.1;
			var anArray:Array<Dynamic> = ['Once', null, 1, 'time', false];
			var aMap = {
				key1: 'value1',
				key2: 2,
				key3: true,
				key4: -65.76,
				key5: null
			};
			var result = nativeAndroid.testTypes(aBool, anInt, aFloat, anArray, aMap);
			trace('Result on Haxe side: ' + result);
	
			nativeAndroid.lastName = 'Java';
			trace('Did set last name to: Java, will say hello');
			nativeAndroid.hello('Dansons la', function() {
				// Done
				trace('Java done.');
			});
	
			trace('Will set onPause');
			// Add some callback when app gets paused/resumed
			nativeAndroid.onPause = function() {
				trace('Activity.onPause');
			};
			trace('Will set onResume');
			nativeAndroid.onResume = function() {
				trace('Activity.onResume');
			};
		
		trace("------------------------- END  --------------");
	}
	
	private function _onUpdate( e:Event ):Void
	{
		#if android
		bind.java.Support.flushRunnables();
		#end
	}

}
