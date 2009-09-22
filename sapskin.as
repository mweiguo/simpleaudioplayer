package {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.LoaderInfo;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;

    public class sapskin extends Sprite {
	private var _statusBtn:sapskinStatusBtn = null;
	private var _statusBar:sapskinStatus = null;
	private var _statusBarMask:Sprite = null;
	private var _ctrlBtn:sapskinCtrlBtn = null;
	private var _ctrlShapePlay:Shape = null;
	private var _ctrlShapeStop:Shape = null;
	private var _vx:int = 0;

	private var _player:mp3player = null;
	public function sapskin ( path:String ) {
	    _statusBtn = new sapskinStatusBtn(0xcccccc);
	    _ctrlBtn = new sapskinCtrlBtn();
	    _ctrlBtn.x = sap.STATUSBTNWIDTH;

	    _statusBar = new sapskinStatus(sap.STATUSCOLOR, sap.STATUSALPHA);
	    _statusBar.x = sap.STATUSBTNWIDTH;
	    _statusBarMask = _ctrlBtn.getMask1();
	    _statusBar.mask = _ctrlBtn.getMask1();

	    addChild ( _statusBar );
	    addChild ( _statusBtn ); 
	    addChild ( _ctrlBtn ); 
	    addChild ( _statusBarMask ); 

	    _player = new mp3player();
	    _player.open ( path );
	    _ctrlBtn.addEventListener ( MouseEvent.CLICK, onCtrlClicked );
	    _player.addEventListener ( mp3player.MP3PLAY_COMPLETE, onPlayComplete );

	    // add javascript interface
	    ExternalInterface.addCallback ( "toggle", toggle );
	}
	private function toggle() :void {
	    onCtrlClicked(null); 
	    _ctrlBtn.onCtrlClicked(null);
	}
	private function onPlayComplete ( e:Event ):void {
	    ExternalInterface.call ("alert", "播放结束");
	    _ctrlBtn.onCtrlClicked ( null );
	    removeEventListener ( Event.ENTER_FRAME, onEnterFrame );
	}

	private function onCtrlClicked ( e:Event ):void {
	    if ( _ctrlBtn.isPlayStatus() ) {
		_player.resume();
		addEventListener ( Event.ENTER_FRAME, onEnterFrame );
	    } else if ( _ctrlBtn.isStopStatus() ) {
		_player.pause();
		removeEventListener ( Event.ENTER_FRAME, onEnterFrame );
	    }
	}
	
	private function onEnterFrame ( e:Event ):void {
	    setLoadedRgn ( _player.getLoadedPos() );
	    setCursorPos ( _player.getPlayPos() );
	    setTime ( _player.getPlayTime() + " / " + _player.getTotalTime() );
	}

	public function setTime ( s:String ) : void {
	    _statusBar.setTime ( s );
	}
	public function setCursorPos ( f:Number ) : void {
	    _statusBar.setCursorPos ( f );
	}
	public function setLoadedRgn ( f:Number ) : void {
	    _statusBar.setLoadedRgn ( f );
	}
    }
}