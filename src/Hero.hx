class Hero extends h2d.Sprite {

    static var SPEED    = 0.02;

    static var FRICT    = 0.80;

    var spr             : mt.heaps.slib.HSprite;
    
    // Base coordinates
    public var cx : Int;
    public var cy : Int;
    public var xr : Float;
    public var yr : Float;
 
    // Resulting coordinates
    public var xx : Float;
    public var yy : Float;
 
    // Movements
    public var dx : Float;
    public var dy : Float;

    public function new (ncx:Int, ncy:Int) {
        super();

        cx = 7;
        cy = 7;
        xr = 0.5;
        yr = 0;
        dx = dy = 0;

        spr = Const.SLB.h_get("hero", 0.5, 1);
        this.addChild(spr);

        // var dbg = new h2d.Graphics(this);
        // dbg.lineStyle(1, 0xFF0000);
        // dbg.drawRect(0, 0, 16, 16);
    }

    public function checkCol(ncx:Float, ncy:Float):Bool {
        for (col in Game.ME.arCol) {
            if (ncx == col.x && ncy == col.y) {
                return true;
            }
        }

        return false;
    }

    public function update() {
        {   // ------- PHYSICS -------
            if (hxd.Key.isDown(hxd.Key.LEFT))
                dx -= SPEED;
            else if (hxd.Key.isDown(hxd.Key.RIGHT))
                dx += SPEED;

            if (hxd.Key.isDown(hxd.Key.UP))
                dy -= SPEED;
            else if (hxd.Key.isDown(hxd.Key.DOWN))
                dy += SPEED;

            xr+=dx;
            dx *= FRICT;
            
            if( checkCol(cx+1,cy) && xr>=0.7 ) { 
                xr = 0.7;
                dx = 0;
            }
            if( checkCol(cx-1,cy) && xr<=0.3 ) { 
                xr = 0.3;
                dx = 0; 
            } 

            while( xr>1 ) {
                xr --;
                cx ++;
            }
            while( xr<0 ) {
                xr ++;
                cx --;
            }

            yr+=dy;
            dy *= FRICT;

            if( checkCol(cx,cy-1) && yr<=0.7 ) {  
                dy = 0; 
                yr = 0.7; 
            }
            if( checkCol(cx,cy+1) && yr>=1 ) {
                dy = 0;
                yr = 1;
            } 

            while( yr>1 ) {
                cy++;
                yr--;
            }
            while( yr<0 ) {
                cy--;
                yr++;
            }

            this.x = (cx + xr) * 16;
            this.y = (cy + yr) * 16;
        }


    }
}