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
        switch (gt) {
            case Libido :
            case Health :
            case Money :
            case Social :
        }
    }
}