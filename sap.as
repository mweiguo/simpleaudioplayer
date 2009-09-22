package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.display.LoaderInfo;
    import flash.errors.IOError;

    public class sap extends Sprite {
	static public const SAPHEIGHT:uint = 40;
	static public const STATUSBTNWIDTH:uint = 60;
	static public const CTRLBTNWIDTH:uint = 40;

	static public const STATUSRUNLENGTH:uint = 200;
	static public const RUNLENGTH:uint = STATUSRUNLENGTH-30;
	static public const DEFAULTSPEED:uint = 42;

	static public const STATUSBTNCOLOR:uint = 0xcccccc;
	static public const STATUSCOLOR:uint = 0x777777;
	static public const CTRLBTNCOLOR:uint = 0xaaaaaa;
	static public const CURSORCOLOR:uint = 0x0;

	static public const CURSORALPHA:Number = 0.8;
	static public const STATUSALPHA:Number = 0.3;

	private var _skin:sapskin = null;
	public function sap () {
	    try {
		var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;
		var path:String = String(paramObj['mp3path']);
		_skin = new sapskin(path);
		addChild ( _skin );
	    } catch ( e:IOError ) {
	    } catch ( e:Error ) {
		trace ( e.message );
	    }
	}
    }
}