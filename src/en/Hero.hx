package en;

class Hero extends Entity {

    static var SPEED    = 0.02;

    static var FRICT    = 0.80;

    var spr             : mt.heaps.slib.HSprite;

    public function new (ncx:Int, ncy:Int, type) {
        super(ncx, ncy, type);

        yr = 0.5;

        wid = hei = 1;

        spr = Const.SLB.h_get("hero", 0.5, 1);
        this.add(spr, 0);
    }

    override public function update() {
        {   // ------- PHYSICS -------
            if (Game.ME.heroCanMove()) {
                if (hxd.Key.isDown(hxd.Key.LEFT))
                    dx -= SPEED;
                else if (hxd.Key.isDown(hxd.Key.RIGHT))
                    dx += SPEED;

                if (hxd.Key.isDown(hxd.Key.UP))
                    dy -= SPEED;
                else if (hxd.Key.isDown(hxd.Key.DOWN))
                    dy += SPEED;
            }

            xr+=dx;
            dx *= FRICT;
            
            if( Game.ME.checkCol(cx+1,cy) && xr>=0.7 ) { 
                xr = 0.7;
                dx = 0;
            }
            if( Game.ME.checkCol(cx-1,cy) && xr<=0.3 ) { 
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

            if( Game.ME.checkCol(cx,cy-1) && yr<=0.7 ) {  
                dy = 0; 
                yr = 0.7; 
            }
            if( Game.ME.checkCol(cx,cy+1) && yr>=1 ) {
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
        }

        super.update();

        if (Game.ME.heroCanMove()) {
            var object = Game.ME.heroIsNearObject();
            if (hxd.Key.isPressed(Const.BTN_VALID) && object != null)
                ui.UI.ME.openObjectWindow(object);
        }
    }
}