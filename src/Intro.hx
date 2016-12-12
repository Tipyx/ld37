class Intro extends mt.Process {

    var textTitle                       : h2d.Text;

    public function new() {
        super();

        createRoot(Main.ME.s2d);

        textTitle = new h2d.Text(Const.FONT, root);
        textTitle.text = "A normal teenage life...";
        textTitle.setScale(2);
        textTitle.x = 10;
        textTitle.y = 20;

        var textTipyx = new h2d.Text(Const.FONT, root);
        textTipyx.text = "A game (?) by Tipyx";
        textTipyx.x = mt.Metrics.w() - textTipyx.textWidth - 10;
        textTipyx.y = mt.Metrics.h() - textTipyx.textHeight - 10;

        var textRules = new h2d.Text(Const.FONT, root);
        textRules.text = "Don't let your 4 gauges be empty ! \n[SEX]  [HEALTH]  [SOCIAL]  [FRIENDS]";
        textRules.x = Std.int(mt.Metrics.w() - textRules.textWidth) >> 1;
        textRules.y = mt.Metrics.h() * 0.3;

        var textValid = new h2d.Text(Const.FONT, root);
        textValid.text = "Valid with [W]/[Z]";
        textValid.x = Std.int(mt.Metrics.w() - textTipyx.textWidth) >> 1;
        textValid.y = mt.Metrics.h() * 0.6;

        var textCancel = new h2d.Text(Const.FONT, root);
        textCancel.text = "Cancel with [X]";
        textCancel.x = Std.int(mt.Metrics.w() - textCancel.textWidth) >> 1;
        textCancel.y = textValid.y + textValid.textHeight * textValid.scaleY;
    }

    var lock = false;

    override public function update() {
        super.update();

        if (!lock && (hxd.Key.isPressed(Const.BTN_VALID_1) || hxd.Key.isPressed(Const.BTN_VALID_2) || hxd.Key.isPressed(Const.BTN_CANCEL))) {
            lock = true;
            tw.createS(root.alpha, 0, 1).onEnd = function () {
                destroy();
		        new Game();
            };
        }

        textTitle.x = 40 + Math.cos(itime / 20) * 10;
    }
}