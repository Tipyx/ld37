class Entity extends h2d.Layers {

    public static var ALL           : Array<Entity>         = [];
    
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

    public var wid         : Int;
    public var hei         : Int;

    public var type        : Null<DCDB.Choice_object>;

    public function new (ncx:Int, ncy:Int, type:Null<DCDB.Choice_object>) {
        super();

        cx = ncx;
        cy = ncy;
        xr = yr = 0;
        dx = dy = 0;

        this.type = type;

        var dbg = new h2d.Graphics(this);
        dbg.lineStyle(1, 0xFF0000);
        dbg.drawRect(0, 0, 1, 1);
        this.add(dbg, 999);

        ALL.push(this);
    }

    public function update() {
        xx = (cx + xr) * Const.GRID;
        yy = (cy + yr) * Const.GRID;

        this.x = xx;
        this.y = yy;
    }
}