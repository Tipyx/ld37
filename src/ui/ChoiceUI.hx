package ui;

class ChoiceUI extends h2d.Layers {

    var txtChoice                   : h2d.Text;

    var c                           : DCDB.Choice;

    public function new(c:DCDB.Choice) {
        super();

        this.c = c;

        txtChoice = new h2d.Text(Const.FONT);
        txtChoice.text = c.name;
        this.addChild(txtChoice);
    }

    public function onValid() {
        for (e in c.effects) {
            GD.ME.AddXto(e.value, e.gauge);
        }
    }

    public function destroy() {
        super.remove();

        txtChoice.remove();
    }
}