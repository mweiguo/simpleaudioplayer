package {
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.display.Shape;
    import flash.text.TextField;

    public class sapskinStatus extends Sprite
    {
	private var _txt:TextField = null;
	private var _cursor:SimpleButton = null;
	private var _dataloadrgn:SimpleButton = null;
	public function sapskinStatus(color:uint, alpha:Number) {
	    // background shape
	    this.graphics.lineStyle();
	    this.graphics.beginFill(color,alpha);
	    this.graphics.moveTo ( 0, 0);
	    this.graphics.lineTo ( sap.STATUSRUNLENGTH, 0);
	    this.graphics.lineTo ( sap.STATUSRUNLENGTH, sap.SAPHEIGHT );
	    this.graphics.lineTo ( 0, 40);
	    this.graphics.lineTo ( -sap.STATUSBTNWIDTH/4, sap.SAPHEIGHT / 2);
	    this.graphics.lineTo ( 0, 0);
	    this.graphics.endFill();

	    // status line
	    this.graphics.lineStyle(1);
	    this.graphics.drawRect ( 3 * sap.SAPHEIGHT / 8, sap.SAPHEIGHT / 2, sap.RUNLENGTH, sap.SAPHEIGHT / 4 );

	    // display time
	    _txt = new TextField ();
	    _txt.x = sap.STATUSRUNLENGTH - 100;
	    _txt.y = sap.SAPHEIGHT / 8;
	    _txt.text = "00:00:00";
	    addChild ( _txt );

	    // cursor
	    var s:Shape = new Shape();
	    s.graphics.lineStyle();
	    s.graphics.beginFill( sap.CURSORCOLOR, sap.CURSORALPHA );
	    s.graphics.drawRect ( 3 * sap.SAPHEIGHT / 8, sap.SAPHEIGHT / 2 - 3, 10, 3 * sap.SAPHEIGHT / 8 );
	    s.graphics.endFill();
	    _cursor = new SimpleButton();
	    _cursor.upState = _cursor.downState = _cursor.overState = _cursor.hitTestState = s;
	    addChild ( _cursor );

	    // data loaded region
	    _dataloadrgn = new SimpleButton();
	    addChild ( _dataloadrgn );
	}
	public function setTime ( s:String ) : void {
	    _txt.text = s;
	}
	public function setCursorPos ( f:Number ) : void {
	    if ( f<0 && f>1 ) return;
	    _cursor.x = f * sap.RUNLENGTH;
	}
	public function setLoadedRgn ( f:Number ) : void {
	    if ( f<0 && f>1 ) return;
	    var s:Shape = new Shape ();
	    s.graphics.lineStyle(10, 0x0, 0.3);
	    s.graphics.moveTo ( 18, 25 );
	    s.graphics.lineTo ( 18 + f * sap.RUNLENGTH - 6, 25);
	    _dataloadrgn.upState = s;

	}
	
    }
}