import en.*;

class Game extends mt.Process {

	public static var ME    : Game;

	// var gr                  : h2d.Graphics;

	var lvl					: DCDB.Ld;

	// En
	var hero                : Hero;
	var bed                 : Bed;

	public var arCol      	: Array<h2d.col.Point>;

	var gd					: GD;
	var ui					: UI;

	public function new() {
		super();

		ME = this;

		createRoot(Main.ME.s2d);

		root.setScale(Const.SCALE);

		// INIT LEVEL

		arCol = [];

		lvl = DCDB.ld.get(DCDB.LdKind.room);
		var ar = lvl.layers[0].data.data.decode();
		for (i in 0...ar.length) {
			var v = ar[i];
			var x = i % lvl.width;
			var y = Std.int(i / lvl.width) ;
			if (v == 1) {
				var gr = new h2d.Graphics(root);
				gr.beginFill(0x000000);
				gr.drawRect(0, 0, Const.GRID, Const.GRID);
				gr.endFill();
				gr.setPos(x * Const.GRID, y * Const.GRID);
				arCol.push(new h2d.col.Point(x, y));
			}
		}

		// INIT ENTITIES

		bed = new Bed (1, 7, Bed);
		root.addChild(bed);

		hero = new Hero(6, 6, null);
		root.addChild(hero);

		// OTHERS

		gd = new GD();
		
		ui = new UI();
		addChild(ui);

		debug();
	}

	public inline function debug() {
		var console = new h2d.Console(Const.FONT, Main.ME.s2d);

		console.addCommand("grid", "grid", [], function () {
			for (i in 0...lvl.width) {
				var gr = new h2d.Graphics(root);
				gr.beginFill(0xFF0000, 0.25);
				gr.drawRect(i * Const.GRID, 0, 1, Const.GRID * lvl.height);
			}

			for (i in 0...lvl.height) {
				var gr = new h2d.Graphics(root);
				gr.beginFill(0xFF0000, 0.25);
				gr.drawRect(0, i * Const.GRID, Const.GRID * lvl.width, 1);
			}
		});
	}

    public function checkCol(ncx:Float, ncy:Float):Bool {
        if (ncx < 0 || ncx >= 12 || ncy < 0 || ncy >= 12)
            return true;

        for (col in arCol) {
            if (ncx == col.x && ncy == col.y) {
                return true;
            }
        }

        return false;
    }

	public function heroCanMove():Bool {
		return !ui.objectWindowIsOpen();
	}

	public function heroIsNearObject():Null<DCDB.Choice_object> {
		for (e in Entity.ALL) {
			if (e != hero) {
				if (mt.deepnight.Lib.distanceSqr(e.xx, e.yy, hero.xx, hero.yy) <= Const.GRID * Const.GRID)
					return e.type;
			}
		}

		return null;
	}

	override public function update() {
		super.update();

		for (e in Entity.ALL)
			e.update();

		if (hxd.Key.isPressed(hxd.Key.Y)) {
			// ui.openObjectWindow();
		}
	}
}