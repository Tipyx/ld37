package ui;

class UI extends mt.Process {

    public static var ME    : UI;

    var gauLib              : GaugeUI;
    var gauHea              : GaugeUI;
    var gauMon              : GaugeUI;
    var gauFri              : GaugeUI;

    var ow                  : ObjectUI;

    public var curTime      : DCDB.Choice_time_Time;
    var iconTime            : mt.heaps.slib.HSprite;
    var textTime            : h2d.Text;

    public function new () {
        super();

        ME = this;

        createRoot(Main.ME.s2d);

        gauLib = new GaugeUI(Libido);
        gauLib.root.setPos(Const.GRID * Const.SCALE * 4, Const.GRID * 4 * 0.5);

        gauHea = new GaugeUI(Health);
        gauHea.root.setPos(Const.GRID * Const.SCALE * 4, Const.GRID * 4 * 1.5);

        gauMon = new GaugeUI(Money);
        gauMon.root.setPos(Const.GRID * Const.SCALE * 8, Const.GRID * 4 * 0.5);

        gauFri = new GaugeUI(Friends);
        gauFri.root.setPos(Const.GRID * Const.SCALE * 8, Const.GRID * 4 * 1.5);

        curTime = DCDB.Choice_time_Time.Morning;

        iconTime = Const.SLB.h_get("time", 0.5, 0.5);
        iconTime.setScale(4);
        root.addChild(iconTime);

        textTime = new h2d.Text(Const.FONT, root);
        textTime.text = getTimeText();
        textTime.y = Const.GRID * Const.SCALE * 2 - 12;
        textTime.x = 10;
    }

    public function openObjectWindow(object:DCDB.Choice_object) {
        delayer.addF(function() {
            ow = new ObjectUI(object);
            ow.setPos(Std.int(mt.Metrics.w() - ow.wid) >> 1, mt.Metrics.h());
            root.addChild(ow);

            tw.createS(ow.y, mt.Metrics.h() - ow.hei - 10, 0.2);
        }, 1);
    }

    public function closeObjectWindow() {
        tw.createS(ow.y, mt.Metrics.h(), 0.2).onEnd = function () {
            ow.destroy();
            ow = null;
        };
    }

    public inline function objectWindowIsOpen():Bool {
        return ow != null;
    }

    inline function getTimeIcon() {
        return switch (curTime) {
            case DCDB.Choice_time_Time.Morning : "timeMorning";
            case DCDB.Choice_time_Time.Day : "timeDay";
            case DCDB.Choice_time_Time.Evening : "timeEvening";
            case DCDB.Choice_time_Time.Night : "timeNight";
        }
    }

    public inline function getTimeText() {
        return switch (curTime) {
            case DCDB.Choice_time_Time.Morning : "Morning";
            case DCDB.Choice_time_Time.Day : "Day";
            case DCDB.Choice_time_Time.Evening : "Evening";
            case DCDB.Choice_time_Time.Night : "Night";
        }
    }

    public function moveToNextTime() {
        switch (curTime) {
            case DCDB.Choice_time_Time.Morning :
                curTime = DCDB.Choice_time_Time.Day;
                tw.createS(iconTime.rotation, Math.PI * 0.5, 0.5);
            case DCDB.Choice_time_Time.Day :
                curTime = DCDB.Choice_time_Time.Evening;
                tw.createS(iconTime.rotation, Math.PI, 0.5);
            case DCDB.Choice_time_Time.Evening :
                curTime = DCDB.Choice_time_Time.Night;
                tw.createS(iconTime.rotation, Math.PI * 1.5, 0.5);
            case DCDB.Choice_time_Time.Night :
                curTime = DCDB.Choice_time_Time.Morning;
                tw.createS(iconTime.rotation, Math.PI * 2, 0.5).onEnd = function () { iconTime.rotation = 0; };
        }

        tw.createS(textTime.alpha, 1 > 0, 0.25).onEnd = function () {
            textTime.text = getTimeText();
            tw.createS(textTime.alpha, 0 > 1, 0.25);
        };
    }

    public function hlGauge(gt:DCDB.Choice_effects_gauge, isAdding:Bool) {
        switch (gt) {
            case Libido :
                gauLib.hl(isAdding);
            case Health :
                gauHea.hl(isAdding);
            case Money :
                gauMon.hl(isAdding);
            case Friends :
                gauFri.hl(isAdding);
        }
    }

    override public function update() {
        super.update();

        if (ow != null)
            ow.update();
    }
}