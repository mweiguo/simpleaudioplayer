package {
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundLoaderContext;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class mp3player extends Sound {
	public static const MP3PLAY_COMPLETE:String = "mp3play_complete";
	public static const MP3PLAY_TIMEOUT:String = "mp3play_timeout";
	private var _r:URLRequest = null;
	private var _c:SoundChannel = null;
	private var _timer:Timer = null;

	public function mp3player () {
	    _timer = new Timer ( 5000, 1 );
	    _timer.addEventListener ( TimerEvent.TIMER_COMPLETE, onTimer );
	}
	private function onTimer (e:TimerEvent ) : void {
	    if ( bytesLoaded == 0 ) {
		dispatchEvent (new Event(mp3player.MP3PLAY_TIMEOUT));
	    }
	}
	public function open ( fp:String ) : void {
	    var buffer:SoundLoaderContext = new SoundLoaderContext(5000);
	    _r = new URLRequest (fp);
	    load ( _r, buffer );
	}
	public function start () : void {
	    if ( null != _c ) {
		_c.removeEventListener ( Event.SOUND_COMPLETE, onComplete );
	    }
	    _c = play();
	    _c.addEventListener ( Event.SOUND_COMPLETE, onComplete );
	}
	private function onComplete ( e:Event ) :void {
	    _c.removeEventListener ( Event.SOUND_COMPLETE, onComplete );
	    _c = null;
	    dispatchEvent (new Event(mp3player.MP3PLAY_COMPLETE));
	}
	public function resume () : void {
	    if ( null == _c ) start ();
	    else {
		_c.removeEventListener ( Event.SOUND_COMPLETE, onComplete );
		_c = play ( _c.position );
		_c.addEventListener ( Event.SOUND_COMPLETE, onComplete );
	    }
	}

	public function pause () : void {
	    if ( null != _c )
	    _c.stop();
	}

	public function getLoadedPos () : Number {
	    if ( 0 == bytesLoaded || 0 == bytesTotal ) return 0;
	    return bytesLoaded / bytesTotal;
	}

	public function getPlayPos () : Number {
	    if ( null == _c || _c.position * bytesLoaded==0)
	    return 0;
	    return (_c.position * bytesLoaded) / (length * bytesTotal);
	}
	public function getPlayTime () : String {
	    var t:uint = _c.position / 1000;
	    var s:uint = t % 60;
	    t = (uint)(t / 60);
	    var m:uint = t % 60;
	    t = (uint)(t / 60);
	    var h:uint = t;
	    return h+":"+m+":"+s;
	}
	public function getTotalTime () : String {
	    var t:uint = length * bytesTotal / (1000 * bytesLoaded);
	    var s:uint = t % 60;
	    t = (uint)(t / 60);
	    var m:uint = t % 60;
	    t = (uint)(t / 60);
	    var h:uint = t;
	    return h+":"+m+":"+s;
	}
    }    
}