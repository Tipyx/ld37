class Const {

    public static var SLB               : mt.heaps.slib.SpriteLib;

    public static function INIT() {
        SLB = mt.heaps.slib.assets.Atlas.load("ss.atlas");
    }
}