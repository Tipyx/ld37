package ui;

class ObjectUI extends h2d.Layers {

    var arrow               : mt.heaps.slib.HSprite;

    var arChoice            : Array<ChoiceUI>;
    var curChoiceIndex      : Int;

    public var wid          = 700;
    public var hei          : Int;
    var offsetX             = 10;
    var offsetY             = 10;

    var object              : DCDB.Choice_object;

    public function new(object:DCDB.Choice_object) {
        super();

        this.object = object;

        arChoice = [];
        curChoiceIndex = 0;
        
        // ------- BASE -------
        var txtObject = new h2d.Text(Const.FONT);
        txtObject.text = getNameObject();
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

        hei = Std.int(this.getBounds().height);

        var bg = new h2d.Graphics();
        bg.lineStyle(4, 0x2a7cbf);
        bg.beginFill(0x0d273d, 0.95);
        bg.drawRect(0, 0, wid, hei + offsetY * 2);
        bg.endFill();
        this.add(bg, 0);

        arrow = Const.SLB.h_get("arrow", 0, 1, 0.5);
        arrow.visible = arChoice.length > 0;
        this.add(arrow, 2);

        hei += offsetY * 2;
    }

    inline function getNameObject():String {
        return switch (object) {
            case Bed : "Bed";
            case Door : "Door";
            case PC : "PC";
            case Console : "PlaySwitch : The One";
        }
    }

    function initChoice(baseY:Float) {
        var cds = DCDB.choice.all.filter(function (f)  {
            var time = false;
            for (t in f.time)
                if (t.Time == UI.ME.curTime)
                    time = true;

            return f.object == object && time;
        });

        for (cd in cds) {
            var choice = new ChoiceUI(this, cd);
            choice.x = offsetX;
            choice.y = Std.int(baseY);
            baseY += choice.getBounds().height + 10;
            arChoice.push(choice);
            this.add(choice, 1);
        }
    }

    public function destroy() {
        super.remove();

        for (c in this.childs)
            c.remove();

        for (c in arChoice)
            c.destroy();
    }

    public function update() {
        if (arChoice.length > 0)
            arrow.y = arChoice[curChoiceIndex].y + arChoice[curChoiceIndex].getBounds().height * 0.5;

        if (hxd.Key.isPressed(hxd.Key.UP) && curChoiceIndex > 0)
            curChoiceIndex--;
        else if (hxd.Key.isPressed(hxd.Key.DOWN) && curChoiceIndex < arChoice.length - 1)
            curChoiceIndex++;
        
        if (hxd.Key.isPressed(Const.BTN_CANCEL))
            UI.ME.closeObjectWindow();
        else if (arChoice.length > 0 && hxd.Key.isPressed(Const.BTN_VALID)) {
            arChoice[curChoiceIndex].onValid();
            UI.ME.closeObjectWindow();
        }
    }
}