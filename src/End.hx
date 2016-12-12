class End extends mt.Process {

    public function new() {
        super();

        createRoot(Main.ME.s2d);

        var textTitle = new h2d.Text(Const.FONT, root);
        textTitle.text = getLooseText() + " on day " + GD.ME.day + " after the " + ui.UI.ME.getTimeText();
        textTitle.x = Std.int(mt.Metrics.w() - textTitle.textWidth) >> 1;
        textTitle.y = mt.Metrics.h() >> 1;

        var textScore = new h2d.Text(Const.FONT, root);
        textScore.text = "Score : " + getScore();
        textScore.x = Std.int(mt.Metrics.w() - textScore.textWidth) >> 1;
        textScore.y = textTitle.y + textTitle.textHeight * textTitle.scaleY + 50;

        var textButton = new h2d.Text(Const.FONT, root);
        textButton.text = "Press [X] to restart";
        textButton.x = Std.int(mt.Metrics.w() - textButton.textWidth) >> 1;
        textButton.y = mt.Metrics.h() - textButton.textHeight - 10;

        tw.createS(root.alpha, 0 > 1, 0.5);
    }

    inline function getLooseText():String {
        if (GD.ME.LIB <= 0)
            return "You let your libido explodes";
        else if (GD.ME.MON <= 0)
            return "You squander all your money";
        else if (GD.ME.FRI <= 0)
            return "You lost all your friends";
        else if (GD.ME.HEA <= 0)
            return "You fall very ill";
        else
            return "You lost";
    }

    inline function getScore():Int {
        var score : Float = (GD.ME.day - 1) * 1000;
        
        score += switch(ui.UI.ME.curTime) {
            case Morning : 250;
            case Day : 500;
            case Evening : 750;
            case Night : 1000;
        }

        score += GD.ME.LIB;
        score += GD.ME.FRI;
        score += GD.ME.HEA;
        score += GD.ME.MON;

        return Std.int(score);
    }

    var lock = false;

    override public function update() {
        super.update();

        if (!lock && hxd.Key.isPressed(hxd.Key.X)) {
            lock = true;
            tw.createS(ui.UI.ME.root.alpha, 1 > 0, 0.5);
            tw.createS(root.alpha, 1 > 0, 0.5).onEnd = function () {
                Game.ME.destroy();
                new Game();
                destroy();
            };
        }
    }
}