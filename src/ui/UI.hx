package ui;

class UI extends mt.Process {

    public static var ME    : UI;

    var gauLib              : GaugeUI;
    var gauHea              : GaugeUI;
    var gauMon              : GaugeUI;
    var gauSoc              : GaugeUI;

    var ow                  : ObjectUI;

    public function new () {
        super();

        ME = this;

        createRoot(Main.ME.s2d);

        gauLib = new GaugeUI(Libido, true);
        gauLib.setPos(Const.GRID * Const.SCALE * 3.5 - GaugeUI.WID, mt.Metrics.h() - Const.GRID * 4 * 1.6);
        root.addChild(gauLib);

        gauHea = new GaugeUI(Health, true);
        gauHea.setPos(Const.GRID * Const.SCALE * 3.5 - GaugeUI.WID, mt.Metrics.h() - Const.GRID * 4 * 0.6);
        root.addChild(gauHea);

        gauMon = new GaugeUI(Money, false);
        gauMon.setPos(Const.GRID * Const.SCALE * 8.5, mt.Metrics.h() - Const.GRID * 4 * 1.6);
        root.addChild(gauMon);

        gauSoc = new GaugeUI(Social, false);
        gauSoc.setPos(Const.GRID * Const.SCALE * 8.5, mt.Metrics.h() - Const.GRID * 4 * 0.6);
        root.addChild(gauSoc);
    }

    public function openObjectWindow(object:DCDB.Choice_object) {
        delayer.addF(function() {
            ow = new ObjectUI(object);
            ow.setPos(100, 100);
            root.addChild(ow);
        }, 1);
    }

    public function closeObjectWindow() {
        ow.destroy();
        ow = null;
    }

    public inline function objectWindowIsOpen():Bool {
        return ow != null;
    }

    override public function update() {
        super.update();

        if (ow != null)
            ow.update();

        gauLib.update();
        gauHea.update();
        gauMon.update();
        gauSoc.update();
    }
}