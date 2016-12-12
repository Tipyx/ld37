package ui;

class ChoiceUI extends h2d.Layers {

    var txtChoice                   : h2d.Text;
    var outline                     : h2d.Graphics;

    var c                           : DCDB.Choice;
    var objUI                       : ObjectUI;

    var wid                         : Int;
    var hei                         : Int;

    public function new(objUI:ObjectUI, c:DCDB.Choice) {
        super();

        this.c = c;
        this.objUI = objUI;

        wid = Std.int(objUI.wid * 0.9);
        hei = 50;

        outline = new h2d.Graphics(this);
        outline.lineStyle(1, 0xFFFFFF);
        outline.drawRect(0, 0, wid, hei);
        outline.x = objUI.wid * 0.025;

        txtChoice = new h2d.Text(Const.FONT);
        txtChoice.text = c.name;
        txtChoice.x = outline.x + 10;
        txtChoice.y = Std.int(hei - txtChoice.textHeight) >> 1;
        this.addChild(txtChoice);

        var fromX = outline.x + wid;
        for (e in c.effects) {
            fromX = addEffect(e, fromX);
            fromX -= 20;
        }
    }

    function addEffect(e:DCDB.Choice_effects, fromX:Float) {
        var cont = new h2d.Sprite(this);
        // cont.y = txtChoice.y;

        var idIcon = switch(e.gauge) {
            case Libido : "iconSex";
            case Money : "iconDollar";
            case Friends : "iconSocial";
            case Health : "iconHealth";
        }
        var icon = Const.SLB.h_get(idIcon, 0, 0, 0.5);
        icon.setScale(2);
        cont.addChild(icon);

        var text = new h2d.Text(Const.FONT, cont);
        text.text = getTextForEffect(e);
        text.x = icon.tile.width * icon.scaleX;
        text.setScale(2);

        icon.y = text.textHeight - 3;

        cont.x = fromX - cont.getBounds().width;

        fromX = cont.x;

        return fromX;
    }

    function getTextForEffect(e:DCDB.Choice_effects) {
        if (e.value > 0) {
            if (e.value > 40)   return "+++";
            else if (e.value > 20) return "++";
            else return "+";
        }
        else {
            if (e.value < -40)   return "---";
            else if (e.value < -20) return "--";
            else return "-";
        }
    }

    public function onValid() {
        Game.ME.onValid(c.effects.toArrayCopy());
    }

    public function destroy() {
        super.remove();

        txtChoice.remove();
    }
}