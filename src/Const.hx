class Const {

    public static var SLB               : mt.heaps.slib.SpriteLib;
    public static var FONT              : h2d.Font;

    public static var SCALE             = 4;

    public static var GRID              = 16;

    public static var BTN_VALID         = hxd.Key.W;
    public static var BTN_CANCEL        = hxd.Key.X;

    public static function INIT() {
        SLB = mt.heaps.slib.assets.Atlas.load("ss.atlas");
        
        FONT = hxd.Res.BetterPixels.build(32, { antiAliasing:false });
    }
}