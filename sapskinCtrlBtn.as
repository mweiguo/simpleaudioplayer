package {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class sapskinCtrlBtn extends Sprite {
	private var _ctrlShapePlay:Shape = null;
	private var _ctrlShapeStop:Shape = null;
	private var _btn:SimpleButton = null;
	private var _vx:int = 0;
	private var _mask1:Sprite = null;

	public function sapskinCtrlBtn () {
	    _btn = new SimpleButton();
	    _ctrlShapePlay = createCtrlShapePlay ( sap.CTRLBTNCOLOR );
	    _ctrlShapeStop = createCtrlShapeStop ( sap.CTRLBTNCOLOR );
	    _btn.overState = _btn.downState = _btn.hitTestState = _btn.upState = _ctrlShapePlay;

	    var mask:Sprite = new Sprite ();
	    mask.graphics.lineStyle(1);
	    mask.graphics.beginFill (0xffffff);
	    mask.graphics.drawRoundRect ( -sap.STATUSBTNWIDTH/4, 0, sap.STATUSBTNWIDTH/4 + sap.CTRLBTNWIDTH, sap.SAPHEIGHT, sap.CTRLBTNWIDTH / 2);
	    mask.graphics.endFill();

	    // another mask 
	    _mask1 = new Sprite();
	    _mask1.graphics.lineStyle(1);
	    _mask1.graphics.beginFill(0xff0000);
	    _mask1.graphics.moveTo ( -sap.STATUSRUNLENGTH, 0);
	    _mask1.graphics.lineTo ( 0, 0);
	    _mask1.graphics.lineTo ( 0, sap.SAPHEIGHT);
	    _mask1.graphics.lineTo ( -sap.STATUSRUNLENGTH, sap.SAPHEIGHT);
	    _mask1.graphics.lineTo ( -sap.STATUSBTNWIDTH / 4 - sap.STATUSRUNLENGTH, sap.SAPHEIGHT / 2 );
	    _mask1.graphics.lineTo ( -sap.STATUSRUNLENGTH, 0);
	    _mask1.graphics.endFill();
	    _mask1.x = sap.STATUSBTNWIDTH;

	    _btn.mask = mask;
	    
	    addChild ( mask );
	    addChild ( _btn );

	    _btn.addEventListener ( MouseEvent.CLICK, onCtrlClicked );
	}

	public function onCtrlClicked ( e:MouseEvent ) : void {
	    if ( !isPlayStatus() && !isStopStatus() ) return;
	    _vx = sap.DEFAULTSPEED;
	    _btn.addEventListener ( Event.ENTER_FRAME, onEnterFrame );
	    _btn.removeEventListener ( MouseEvent.CLICK, onCtrlClicked );
	}

	private function onEnterFrame (e:Event) : void {
	    if ( isPlayStatus() ) {
		_mask1.x = _mask1.x+_vx >= sap.STATUSRUNLENGTH+sap.STATUSBTNWIDTH ? sap.STATUSRUNLENGTH+sap.STATUSBTNWIDTH : _mask1.x+_vx;
		x = x+_vx >= sap.STATUSRUNLENGTH+sap.STATUSBTNWIDTH ? sap.STATUSRUNLENGTH+sap.STATUSBTNWIDTH : x+_vx;
		if ( sap.STATUSRUNLENGTH+sap.STATUSBTNWIDTH == x ) {
		    _btn.removeEventListener ( Event.ENTER_FRAME, onEnterFrame );
		    showStop();
		    _btn.addEventListener ( MouseEvent.CLICK, onCtrlClicked );
		} else {
		    _vx++;
		}

	    } else if ( isStopStatus() ) {
		_mask1.x = _mask1.x-_vx <=sap.STATUSBTNWIDTH ? sap.STATUSBTNWIDTH : _mask1.x-_vx;
		x = x-_vx <=sap.STATUSBTNWIDTH ? sap.STATUSBTNWIDTH : x-_vx;
		if ( sap.STATUSBTNWIDTH == x ) {
		    _btn.removeEventListener ( Event.ENTER_FRAME, onEnterFrame );
		    showPlay();
		    _btn.addEventListener ( MouseEvent.CLICK, onCtrlClicked );
		} else {
		    _vx++;
		}
	    }
	}

	public function getMask1 () : Sprite {
	    return _mask1;
	}
	public function showPlay() : void {
	    _btn.overState = _btn.downState = _btn.hitTestState = _btn.upState = _ctrlShapePlay;
	}

	public function showStop() : void {
	    _btn.overState = _btn.downState = _btn.hitTestState = _btn.upState = _ctrlShapeStop;
	}

	public function isPlayStatus() : Boolean {
	    return (_btn.upState == _ctrlShapePlay);
	}
	public function isStopStatus() : Boolean {
	    return (_btn.upState == _ctrlShapeStop);
	}


	private function createCtrlShapeStop ( color:uint ) : Shape {
	    var s:Shape = new Shape();
	    s.graphics.lineStyle();
	    s.graphics.beginFill(color);
	    s.graphics.moveTo (0,  0);
	    s.graphics.lineTo (sap.CTRLBTNWIDTH, 0);
	    s.graphics.lineTo (sap.CTRLBTNWIDTH, sap.SAPHEIGHT );
	    s.graphics.lineTo (0, sap.SAPHEIGHT);
	    s.graphics.lineTo (-sap.STATUSBTNWIDTH / 4, sap.SAPHEIGHT / 2);
	    s.graphics.endFill();

	    s.graphics.lineStyle(7);
	    s.graphics.beginFill(0x0);
	    s.graphics.moveTo ( sap.CTRLBTNWIDTH / 3, sap.SAPHEIGHT / 4 );
	    s.graphics.lineTo ( sap.CTRLBTNWIDTH / 3, 3 * sap.SAPHEIGHT / 4 );
	    s.graphics.moveTo ( 2 * sap.CTRLBTNWIDTH / 3, sap.SAPHEIGHT / 4 );
	    s.graphics.lineTo ( 2 * sap.CTRLBTNWIDTH / 3, 3 * sap.SAPHEIGHT / 4 );
	    s.graphics.endFill();
	    return s;
	}	
	private function createCtrlShapePlay ( color:uint ) : Shape {
	    var s:Shape = new Shape();
	    s.graphics.lineStyle();
	    s.graphics.beginFill(color);
	    s.graphics.moveTo (0, 0);
	    s.graphics.lineTo (sap.CTRLBTNWIDTH, 0);
	    s.graphics.lineTo (sap.CTRLBTNWIDTH, sap.SAPHEIGHT);
	    s.graphics.lineTo (0, sap.SAPHEIGHT);
	    s.graphics.lineTo (-sap.STATUSBTNWIDTH / 4, sap.SAPHEIGHT / 2);
	    s.graphics.endFill();

	    s.graphics.lineStyle(4);
	    s.graphics.beginFill(0x0);
	    s.graphics.moveTo (sap.CTRLBTNWIDTH / 3,   sap.SAPHEIGHT / 4 );
	    s.graphics.lineTo (2*sap.CTRLBTNWIDTH / 3, sap.SAPHEIGHT / 2 );
	    s.graphics.lineTo (sap.CTRLBTNWIDTH / 3,   3*sap.SAPHEIGHT / 4 );
	    s.graphics.lineTo (sap.CTRLBTNWIDTH / 3,   sap.SAPHEIGHT / 4 );
	    s.graphics.endFill();
	    return s;
	}	
    }

}