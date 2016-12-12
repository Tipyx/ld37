package ui;

class GaugeUI extends mt.Process {

    var gt              : DCDB.Choice_effects_gauge;

    public static var WID = Const.GRID * 2.5 * 4;
    public var point    : Float;

    var gauge           : mt.heaps.slib.HSprite;
    var icon            : mt.heaps.slib.HSprite;
    var redIcon         : mt.heaps.slib.HSprite;
    var greIcon         : mt.heaps.slib.HSprite;

    var baseSX          : Float;

    public function new(gt:DCDB.Choice_effects_gauge) {
        super(UI.ME);

        createRoot(UI.ME.root);

        this.gt = gt;

        baseSX = WID;

        gauge = Const.SLB.h_get("wp");
        gauge.scaleX = baseSX;
        gauge.scaleY = Const.GRID;
        root.addChild(gauge);

        var gaugeBG = Const.SLB.h_get("outlineGauge");
        root.addChild(gaugeBG);

        var idIcon = switch(gt) {
            case Libido : "iconSex";
            case Money : "iconDollar";
            case Friends : "iconSocial";
            case Health : "iconHealth";
        }
        icon = Const.SLB.h_get(idIcon, 0, 0.5, 0.5);
        icon.setScale(3);
        icon.x = -Const.GRID * 2;
        icon.y = Const.GRID >> 1;
        root.addChild(icon);

        redIcon = Const.SLB.h_get(idIcon, 0, 0.5, 0.5);
        redIcon.setScale(icon.scaleX);
        redIcon.x = icon.x;
        redIcon.y = icon.y;
        redIcon.alpha = 0;
        redIcon.colorize(0xFF0000);
        root.addChild(redIcon);

        greIcon = Const.SLB.h_get(idIcon, 0, 0.5, 0.5);
        greIcon.setScale(icon.scaleX);
        greIcon.x = icon.x;
        greIcon.y = icon.y;
        greIcon.alpha = 0;
        greIcon.colorize(0x00FF00);
        root.addChild(greIcon);
    }

    public function hl(isAdding:Bool) {
        if (isAdding) {
            tw.createS(greIcon.alpha, 1 > 0, 1);
            tw.createS(greIcon.scaleX, 3 > 4.5, 1);
            tw.createS(greIcon.scaleY, 3 > 4.5, 1);
        }
        else {
            tw.createS(redIcon.alpha, 1 > 0, 1);
            tw.createS(redIcon.scaleX, 4.5 > 3, 1);
            tw.createS(redIcon.scaleY, 4.5 > 3, 1);
        }
    }

    override public function update() {
        super.update();

        switch (gt) {
            case Libido :
                gauge.scaleX = GD.ME.LIB / 100;
            case Health :
                gauge.scaleX = GD.ME.HEA / 100;
            case Money :
                gauge.scaleX = GD.ME.MON / 100;
            case Friends :
                gauge.scaleX = GD.ME.FRI / 100;
        }

        if (gauge.scaleX > 1)
            gauge.scaleX = 1;
        else if (gauge.scaleX < 0)
            gauge.scaleX = 0;

        if (gauge.scaleX <= 0.25)
            gauge.colorize(0xb82521);
        else if (gauge.scaleX <= 0.50)
            gauge.colorize(0xb87321);
        else
            gauge.colorize(0x26b821);

        gauge.scaleX *= baseSX;
    }
}