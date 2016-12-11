class GD { // GameData

	public static var ME    : GD;

    public var LIB          : Float;
    public var HEA          : Float;
    public var MON          : Float;
    public var SOC          : Float;

    public function new() {
        ME = this;

        LIB = HEA = MON = SOC = 50;
    }

    public function AddXto(v:Float, gt:DCDB.Choice_effects_gauge) {
        var tw = Game.ME.tw;

        switch (gt) {
            case Libido :
                tw.createS(LIB, LIB + v, 1);
            case Health :
                tw.createS(HEA, HEA + v, 1);
            case Money :
                tw.createS(MON, MON + v, 1);
            case Social :
                tw.createS(SOC, SOC + v, 1);
        }

        if (LIB <= 0
        ||  HEA <= 0
        ||  MON <= 0
        ||  SOC <= 0)
            throw "GameOver";
    }
}