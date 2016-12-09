class Main extends hxd.App
{
    override function init() {
		super.init();

        trace("trololo");

		var gr = new h2d.Graphics(s2d);
		gr.beginFill(0xFFFFFF);
		gr.drawRect(0, 0, 100, 100);
		gr.endFill();
    }

	static function main() {
		hxd.Res.initEmbed();
		
		// DCDB.load(hxd.Res.data.entry.getBytes().toString());
		
		// Const.INIT();
		
		new Main();
	}
}