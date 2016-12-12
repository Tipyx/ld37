package en;

class Hero extends Entity {

    static var SPEED    = 0.02;

    static var FRICT    = 0.80;

    var spr             : mt.heaps.slib.HSprite;

    var nearObject      : Null<DCDB.Choice_object>;
    var textQM          : h2d.Text;

    public function new (ncx:Int, ncy:Int, type) {
        super(ncx, ncy, type);

        yr = 0.5;

        wid = hei = 1;

        nearObject = null;

        spr = Const.SLB.h_get("hero", 0.5, 1);
        // spr.anim.regi
        this.add(spr, 0);

        textQM = new h2d.Text(Const.FONT);
        textQM.text = "?";
        textQM.x = (-textQM.textWidth >> 1) +1;
        textQM.textColor = 0;
        textQM.alpha = 0;
        this.add(textQM, 0);
    }

    override public function update() {
        {   // ------- PHYSICS -------
            if (Game.ME.heroCanMove()) {
                if (hxd.Key.isDown(hxd.Key.LEFT)) {
                    dx -= SPEED;
                    spr.set("heroSide");
                    spr.scaleX = 1;
                }
                else if (hxd.Key.isDown(hxd.Key.RIGHT)) {
                    dx += SPEED;
                    spr.set("heroSide");
                    spr.scaleX = -1;
                }

                if (hxd.Key.isDown(hxd.Key.UP)) {
                    dy -= SPEED;
                    if (!hxd.Key.isDown(hxd.Key.LEFT) && !hxd.Key.isDown(hxd.Key.RIGHT))
                        spr.set("heroBack");
                }
                else if (hxd.Key.isDown(hxd.Key.DOWN)) {
                    dy += SPEED;
                    spr.set("hero");
                }
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

            if (dx >= -0.01 && dx <= 0.01)
                dx = 0;
            if (dy >= -0.01 && dy <= 0.01)
                dy = 0;
        }

        super.update();

        nearObject = Game.ME.heroIsNearObject();

        if (Game.ME.tw.count() == 0) {
            if (nearObject != null && textQM.alpha == 0) {
                Game.ME.tw.createS(textQM.alpha, 1, 0.2);
                textQM.y = -spr.tile.height - Const.GRID;
                Game.ME.tw.createS(textQM.y, -spr.tile.height - Const.GRID - 5, 0.2);
            }
            else if (nearObject == null && textQM.alpha == 1) {
                Game.ME.tw.createS(textQM.alpha, 0, 0.2);
            }
        }

        if (Game.ME.heroCanMove()) {
            if ((hxd.Key.isPressed(Const.BTN_VALID_1) || hxd.Key.isPressed(Const.BTN_VALID_2)) && nearObject != null)
                ui.UI.ME.openObjectWindow(nearObject);
        }
    }
}