class Main extends hxd.App
{
	var game					: Game;

	public static var ME		: Main;

    override function init() {
		super.init();

		ME = this;

		Const.INIT();

		DCDB.load(hxd.Res.data.entry.getBytes().toString());

		engine.backgroundColor = 0x70481d;
		
		game = new Game();
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