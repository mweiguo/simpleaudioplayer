
function getFlash(name) {   
    var isIE = navigator.appName.indexOf("Microsoft") != -1; 
    return (isIE) ? window[name] : document[name];
}  

function indexof_array ( myarr, value ) {
    for ( var i=0; i<myarr.length; i++ ) 
    {
	if ( myarr[i] === value )
	    return i;
	return -1;
    }
}

var playerlist = ["player1", "player2"];
var curidx = -1;

function sap_loadioerror( id ) {
    alert ( "sap_loadioerror : " + id );
}

function sap_startplay( id ) {
//    alert ( "sap_startplay : " + id );
    if ( -1 != curidx ) {
	if ( playerlist[curidx] == id )
	    return;
    }
    var idx = indexof_array ( playerlist, id );
    if ( -1 == idx ) {
	idx = playerlist.length;
	playerlist.push ( id );
    }

    // stop current player
    if ( -1 != curidx )
	getFlash ( playerlist[curidx] ).toggle();
    curidx = idx;
}

function sap_loadtimeout( id ) {
    alert ( "sap_loadtimeout : " + id );
}

function sap_playover( id ) {
//    alert ( "sap_playover : " + id );
    curidx++;
    if ( curidx == playerlist.length )
	curidx = 0;

    if ( -1 != curidx )
	getFlash ( playerlist[curidx] ).toggle();
}
