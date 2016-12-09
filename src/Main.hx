class Main extends hxd.App
{
	var game					: Game;

	public static var ME		: Main;

    override function init() {
		super.init();

		ME = this;
		
		game = new Game();
    }

	override public function update(dt:Float) {
		super.update(dt);

		mt.Process.updateAll(dt);
	}

	static function main() {
		hxd.Res.initEmbed();
		
		// DCDB.load(hxd.Res.data.entry.getBytes().toString());
		
		// Const.INIT();
		
		new Main();
	}
}