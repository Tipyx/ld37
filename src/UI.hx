enum GaugeType {
    Libido;
    Health;
    Money;
    Social;
}

class UI extends mt.Process {

    public static var ME    : UI;

    var gauLib              : Gauge;
    var gauHea              : Gauge;
    var gauMon              : Gauge;
    var gauSoc              : Gauge;

    var ow                  : ObjectWindow;

    public function new () {
        super();

        ME = this;

        createRoot(Main.ME.s2d);

        gauLib = new Gauge(Libido, true);
        gauLib.setPos(Const.GRID * Const.SCALE * 3.5 - Gauge.WID, mt.Metrics.h() - Const.GRID * 4 * 1.6);
        root.addChild(gauLib);

        gauHea = new Gauge(Health, true);
        gauHea.setPos(Const.GRID * Const.SCALE * 3.5 - Gauge.WID, mt.Metrics.h() - Const.GRID * 4 * 0.6);
        root.addChild(gauHea);

        gauMon = new Gauge(Money, false);
        gauMon.setPos(Const.GRID * Const.SCALE * 8.5, mt.Metrics.h() - Const.GRID * 4 * 1.6);
        root.addChild(gauMon);

        gauSoc = new Gauge(Social, false);
        gauSoc.setPos(Const.GRID * Const.SCALE * 8.5, mt.Metrics.h() - Const.GRID * 4 * 0.6);
        root.addChild(gauSoc);
    }

    public function openObjectWindow() {
        ow = new ObjectWindow();
        ow.setPos(100, 100);
        root.addChild(ow);
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
    }
}

class Gauge extends h2d.Layers {

    var gt              : GaugeType;
    var isOnLeft        : Bool;

    public static var WID = Const.GRID * 2.5 * Const.SCALE;

    public var point    : Float;

    public function new(gt:GaugeType, isOnLeft:Bool) {
        super();

        this.gt = gt;
        this.isOnLeft = isOnLeft;

        var gaugeBG = new h2d.Graphics();
        gaugeBG.beginFill(0xFFFFFF);
        gaugeBG.drawRect(0, 0, WID, Const.GRID);
        this.addChild(gaugeBG);

        var gauge = new h2d.Graphics();
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
}

class ObjectWindow extends h2d.Layers {

    var arrow               : mt.heaps.slib.HSprite;

    var arChoice            : Array<Choice>;
    var curChoiceIndex      : Int;

    var wid                 = 300;
    var offsetX             = 10;
    var offsetY             = 10;

    public function new() {
        super();

        arChoice = [];
        curChoiceIndex = 0;
        
        // ------- BASE -------
        var txtObject = new h2d.Text(Const.FONT);
        txtObject.text = "Object Name";
        txtObject.textAlign = Center;
        txtObject.x = Std.int(wid * 0.5);
        txtObject.y = offsetY;

        var separator = new h2d.Graphics();
        separator.beginFill(0xFFFFFF);
        separator.drawRect(0, 0, wid * 0.8, 1);
        separator.endFill();
        separator.x = wid * 0.1;
        separator.y = txtObject.y + txtObject.textHeight + 5;

        this.add(txtObject, 1);
        this.add(separator, 1);
        
        initChoice(separator.y + 1 + 10);

        var hei = this.getBounds().height;

        var bg = new h2d.Graphics();
        bg.lineStyle(4, 0x2a7cbf);
        bg.beginFill(0x0d273d, 0.8);
        bg.drawRect(0, 0, wid, hei + offsetY * 2);
        bg.endFill();
        this.add(bg, 0);
    }

    function initChoice(by:Float) {
        for (i in 0...2) {
            var choice = new Choice();
            choice.x = offsetX;
            choice.y = Std.int(by);
            by += choice.getBounds().height + 10;
            arChoice.push(choice);
            this.add(choice, 1);
        }

        arrow = Const.SLB.h_get("arrow", 0, 1, 0.5);
        this.add(arrow, 2);
    }

    public function destroy() {
        super.remove();

        for (c in this.childs)
            c.remove();

        for (c in arChoice)
            c.destroy();
    }

    public function update() {
        arrow.y = arChoice[curChoiceIndex].y + arChoice[curChoiceIndex].getBounds().height * 0.5;

        if (hxd.Key.isPressed(hxd.Key.UP) && curChoiceIndex > 0)
            curChoiceIndex--;
        else if (hxd.Key.isPressed(hxd.Key.DOWN) && curChoiceIndex < arChoice.length - 1)
            curChoiceIndex++;
        
        if (hxd.Key.isPressed(Const.BTN_CANCEL))
            UI.ME.closeObjectWindow();
    }
}

class Choice extends h2d.Layers {

    var txtChoice                   : h2d.Text;

    public function new() {
        super();

        txtChoice = new h2d.Text(Const.FONT);
        txtChoice.text = "Choice";
        this.addChild(txtChoice);
    }

    public function destroy() {
        super.remove();

        txtChoice.remove();
    }
}