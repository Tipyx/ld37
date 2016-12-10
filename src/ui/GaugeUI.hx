package ui;

class GaugeUI extends h2d.Layers {

    var gt              : DCDB.Choice_effects_gauge;
    var isOnLeft        : Bool;

    public static var WID = Const.GRID * 2.5 * Const.SCALE;

    public var point    : Float;

    var gauge           : h2d.Graphics;

    public function new(gt:DCDB.Choice_effects_gauge, isOnLeft:Bool) {
        super();

        this.gt = gt;
        this.isOnLeft = isOnLeft;

        var gaugeBG = new h2d.Graphics();
        gaugeBG.beginFill(0xFFFFFF);
        gaugeBG.drawRect(0, 0, WID, Const.GRID);
        this.addChild(gaugeBG);

        gauge = new h2d.Graphics();
        gauge.beginFill(0x00AA00);
        gauge.drawRect(0, 0, WID, Const.GRID);
        gauge.scaleX = 0.5;
        this.addChild(gauge);

        var outline = new h2d.Graphics();
        outline.lineStyle(4, 0);
        outline.drawRect(0, 0, WID, Const.GRID);
        this.addChild(outline);

        if (!isOnLeft) {
            gauge.x = WID;
            gauge.scaleX = -0.5;
        }
    }

    public function update() {
        switch (gt) {
            case Libido :
                gauge.scaleX = GD.ME.LIB / 100;
            case Health :
                gauge.scaleX = GD.ME.HEA / 100;
            case Money :
                gauge.scaleX = -GD.ME.MON / 100;
            case Social :
                gauge.scaleX = -GD.ME.SOC / 100;
        }
    }
}