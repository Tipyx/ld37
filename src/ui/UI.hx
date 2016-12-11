package ui;

class UI extends mt.Process {

    public static var ME    : UI;

    var gauLib              : GaugeUI;
    var gauHea              : GaugeUI;
    var gauMon              : GaugeUI;
    var gauSoc              : GaugeUI;

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

        gauSoc = new GaugeUI(Social);
        gauSoc.root.setPos(Const.GRID * Const.SCALE * 8, Const.GRID * 4 * 1.5);

        curTime = DCDB.Choice_time_Time.Morning;

        iconTime = Const.SLB.h_get(getTimeIcon());
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

    inline function getTimeText() {
        return switch (curTime) {
            case DCDB.Choice_time_Time.Morning : "Morning";
            case DCDB.Choice_time_Time.Day : "Day";
            case DCDB.Choice_time_Time.Evening : "Evening";
            case DCDB.Choice_time_Time.Night : "Night";
        }
    }

    public function moveToNextTime() {
        curTime = switch (curTime) {
            case DCDB.Choice_time_Time.Morning : DCDB.Choice_time_Time.Day;
            case DCDB.Choice_time_Time.Day : DCDB.Choice_time_Time.Evening;
            case DCDB.Choice_time_Time.Evening : DCDB.Choice_time_Time.Night;
            case DCDB.Choice_time_Time.Night : DCDB.Choice_time_Time.Morning;
        }

        iconTime.set(getTimeIcon());
        textTime.text = getTimeText();
    }

    override public function update() {
        super.update();

        if (ow != null)
            ow.update();
    }
}