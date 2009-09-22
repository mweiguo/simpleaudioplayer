package {
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class sapskinStatusBtn extends Sprite {
	private var _statusBtn:SimpleButton = null;
	public function sapskinStatusBtn ( color:uint ) {
	    var btn:SimpleButton = new SimpleButton();
	    btn.upState = createStatusShape ( sap.STATUSBTNCOLOR );

	    var mask:Sprite = new Sprite ();
	    mask.graphics.lineStyle();
	    mask.graphics.beginFill( color );
	    mask.graphics.drawRoundRect ( 0, 0, sap.STATUSBTNWIDTH + 20, sap.SAPHEIGHT, sap.SAPHEIGHT / 2);
	    mask.graphics.endFill();

	    btn.mask = mask;
	    addChild ( btn );
	    addChild ( mask );
	}
	
	private function createStatusShape ( color:uint ) : Shape {
	    var s:Shape = new Shape();
	    s.graphics.lineStyle();
	    s.graphics.beginFill(color);
	    s.graphics.moveTo ( 0, 0);
	    s.graphics.lineTo ( sap.STATUSBTNWIDTH, 0);
	    s.graphics.lineTo ( 3 * sap.STATUSBTNWIDTH / 4, sap.SAPHEIGHT / 2);
	    s.graphics.lineTo ( sap.STATUSBTNWIDTH, sap.SAPHEIGHT );
	    s.graphics.lineTo ( 0, sap.SAPHEIGHT );
	    s.graphics.lineTo ( 0, 0);
	    s.graphics.endFill();
	    return s;
	}
    }
}
