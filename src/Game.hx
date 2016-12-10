class Game extends mt.Process {

	public static var ME    : Game;

	var gr                  : h2d.Graphics;

	// En
	var hero                : Hero;

	public var arCol      	: Array<h2d.col.Point>;

	public function new() {
		super();

		ME = this;

		createRoot(Main.ME.s2d);

		root.setScale(3);

		// INIT LEVEL

		arCol = [];

		var lvl = DCDB.ld.get(DCDB.LdKind.room);
		var ar = lvl.layers[0].data.data.decode();
		for (i in 0...ar.length) {
			var v = ar[i];
			var x = i % lvl.width;
			var y = Std.int(i / lvl.width) ;
			if (v == 1) {
				var gr = new h2d.Graphics(root);
				gr.beginFill(0x000000);
				gr.drawRect(0, 0, 16, 16);
				gr.endFill();
				gr.setPos(x * 16, y * 16);
				arCol.push(new h2d.col.Point(x, y));
			}
		}

		// for (i in 0...lvl.width) {
		// 	var gr = new h2d.Graphics(root);
		// 	gr.beginFill(0xFF0000, 0.25);
		// 	gr.drawRect(i * 16, 0, 1, 16 * lvl.height);
		// }

		// for (i in 0...lvl.height) {
		// 	var gr = new h2d.Graphics(root);
		// 	gr.beginFill(0xFF0000, 0.25);
		// 	gr.drawRect(0, i * 16, 16 * lvl.width, 1);
		// }

		// INIT ENTITIES

		hero = new Hero(7, 7);
		root.addChild(hero);
	}

	override public function update() {
		super.update();

		hero.update();
	}
}