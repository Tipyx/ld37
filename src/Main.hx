class Main extends hxd.App
{
	public static var ME		: Main;

    override function init() {
		super.init();

		ME = this;

		Const.INIT();

		DCDB.load(hxd.Res.data.entry.getBytes().toString());

		engine.backgroundColor = 0x0F0C12;

		new Intro();
		// new Game();
    }

	override public function update(dt:Float) {
		super.update(dt);

		mt.Process.updateAll(dt);
	}

	static function main() {
		hxd.Res.initEmbed();
		
		new Main();
	}
}