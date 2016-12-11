package ui;

class GaugeUI extends mt.Process {

    var gt              : DCDB.Choice_effects_gauge;

    public static var WID = Const.GRID * 2.5 * Const.SCALE;

    public var point    : Float;

    var gauge           : h2d.Graphics;
    var icon            : mt.heaps.slib.HSprite;
    var redIcon         : mt.heaps.slib.HSprite;
    var greIcon         : mt.heaps.slib.HSprite;

    public function new(gt:DCDB.Choice_effects_gauge) {
        super(UI.ME);

        createRoot(UI.ME.root);

        this.gt = gt;

        var gaugeBG = new h2d.Graphics();
        gaugeBG.beginFill(0xFFFFFF);
        gaugeBG.drawRect(0, 0, WID, Const.GRID);
        root.addChild(gaugeBG);

        gauge = new h2d.Graphics();
        gauge.beginFill(0x00AA00);
        gauge.drawRect(0, 0, WID, Const.GRID);
        gauge.scaleX = 0.5;
        root.addChild(gauge);

        var outline = new h2d.Graphics();
        outline.lineStyle(4, 0);
        outline.drawRect(0, 0, WID, Const.GRID);
        root.addChild(outline);

        var idIcon = switch(gt) {
            case Libido : "iconSex";
            case Money : "iconDollar";
            case Social : "iconSocial";
            case Health : "iconHealth";
        }
        icon = Const.SLB.h_get(idIcon, 0, 1, 0.5);
        icon.setScale(3);
        icon.x = -Const.GRID;
        icon.y = Const.GRID >> 1;
        root.addChild(icon);

        redIcon = Const.SLB.h_get(idIcon, 0, 1, 0.5);
        redIcon.setScale(icon.scaleX);
        redIcon.x = -Const.GRID;
        redIcon.y = Const.GRID >> 1;
        redIcon.alpha = 0;
        redIcon.colorize(0xFF0000);
        root.addChild(redIcon);

        greIcon = Const.SLB.h_get(idIcon, 0, 1, 0.5);
        greIcon.setScale(icon.scaleX);
        greIcon.x = -Const.GRID;
        greIcon.y = Const.GRID >> 1;
        greIcon.alpha = 0;
        greIcon.colorize(0x00FF00);
        root.addChild(greIcon);
    }

    override public function update() {
        super.update();

        var oldX = gauge.scaleX;

        switch (gt) {
            case Libido :
                gauge.scaleX = GD.ME.LIB / 100;
            case Health :
                gauge.scaleX = GD.ME.HEA / 100;
            case Money :
                gauge.scaleX = GD.ME.MON / 100;
            case Social :
                gauge.scaleX = GD.ME.SOC / 100;
        }

        if (gauge.scaleX > 1)
            gauge.scaleX = 1;
        else if (gauge.scaleX < 0)
            gauge.scaleX = 0;

        if (tw.count() == 0) {
            if (gauge.scaleX > oldX) {
                tw.createS(greIcon.alpha, 1 > 0, 1.5);
            }
            else if (gauge.scaleX < oldX) {
                 tw.createS(redIcon.alpha, 1 > 0, 1.5);
            }
        }
    }
}