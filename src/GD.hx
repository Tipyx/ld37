class GD { // GameData

	public static var ME    : GD;

    public var LIB          : Float;
    public var HEA          : Float;
    public var MON          : Float;
    public var FRI          : Float;

    public var day          : Int;

    public function new() {
        ME = this;

        day = 1;

        LIB = HEA = MON = FRI = 50;
    }

    public function addXto(v:Float, gt:DCDB.Choice_effects_gauge) {
        var tw = Game.ME.tw;

        switch (gt) {
            case Libido :
                tw.createS(LIB, LIB + v, 1).onEnd = function () { LIB = Std.int(LIB); };
            case Health :
                tw.createS(HEA, HEA + v, 1).onEnd = function () { HEA = Std.int(HEA); };
            case Money :
                tw.createS(MON, MON + v, 1).onEnd = function () { MON = Std.int(MON); };
            case Friends :
                tw.createS(FRI, FRI + v, 1).onEnd = function () { FRI = Std.int(FRI); };
        }

        ui.UI.ME.hlGauge(gt, v > 0);
    }

    public function onEndDay() {
        var irnd = mt.deepnight.Lib.irnd;

        addXto(-irnd(5, 20), Libido);
        addXto(-irnd(5, 20), Health);
        addXto(-irnd(5, 20), Money);
        addXto(-irnd(5, 20), Friends);

        day++;
    }

    public function checkGameOver():Bool {
        if (LIB <= 0
        ||  HEA <= 0
        ||  MON <= 0
        ||  FRI <= 0)
            return true;

        return false;
    }
}