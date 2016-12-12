import en.*;
import ui.*;

class Game extends mt.Process {

	public static var ME    : Game;

	// var gr                  : h2d.Graphics;

	var lvl					: DCDB.Ld;

	// En
	var hero                : Hero;
	var bed                 : Bed;
	var door                : Door;
	var pc               	: PC;
	var console            	: Console;

	public var arCol      	: Array<h2d.col.Point>;

	var gd					: GD;
	var ui					: UI;

	public var heroLock		: Bool;

	public var cm			: mt.deepnight.Cinematic;

	public function new() {
		super();

		ME = this;

		createRoot(Main.ME.s2d);

		cm = new mt.deepnight.Cinematic(60);

		root.setScale(Const.SCALE);

		root.y = -mt.Metrics.h();
		tw.createS(root.y, (Const.GRID >>1) * Const.SCALE, 2).onEnd = function () {
			tw.createS(ui.root.alpha, 1, 0.5);
		};
		// root.y += (Const.GRID >>1) * Const.SCALE;

		heroLock = false;

		// INIT LEVEL

		var flooring = Const.SLB.h_get("flooring");
		root.addChild(flooring);

		arCol = [];

		lvl = DCDB.ld.get(DCDB.LdKind.room);
		var ar = lvl.layers[0].data.data.decode();
		for (i in 0...ar.length) {
			var v = ar[i];
			var x = i % lvl.width;
			var y = Std.int(i / lvl.width);
			if (v > 0)
				arCol.push(new h2d.col.Point(x, y));
		}

		// INIT ENTITIES

		bed = new Bed(1, 9, Bed);
		root.addChild(bed);

		door = new Door(6, 3, Door);
		root.addChild(door);

		pc = new PC(10, 8, PC);
		root.addChild(pc);

		console = new Console(5, 9, Console);
		root.addChild(console);

		hero = new Hero(5, 6, null);
		root.addChild(hero);

		// OTHERS

		gd = new GD();
		
		ui = new UI();
		ui.root.alpha = 0;
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

    public function onValid(arEff:Array<DCDB.Choice_effects>) {
        heroLock = true;

        cm.create({
            for (e in arEff) {
                GD.ME.addXto(e.value, e.gauge);
            }
            1000;

            ui.moveToNextTime();
            if (ui.curTime == Night) {
                gd.onEndDay();
                1100;
            }
            else
                500;

            heroLock = false;
        });

		delayer.addS(function() {
			if(GD.ME.checkGameOver())
				gameOver();
		}, 2.5);
    }

	function gameOver() {
		var gr = Const.SLB.h_get("wp");
		gr.colorize(0xFF0000);
		gr.blendMode = Add;
		gr.scaleX = mt.Metrics.w();
		gr.scaleY = mt.Metrics.h();
		Main.ME.s2d.addChild(gr);

		tw.createS(root.alpha, 1 > 0, 1);
		tw.createS(gr.alpha, 1 > 0, 1).onEnd = function () {
			new End();
		};

		heroLock = true;
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
		return !ui.objectWindowIsOpen() && !heroLock;
	}

	public function heroIsNearObject():Null<DCDB.Choice_object> {
		for (e in Entity.ALL) {
			if (e != hero) {
				if (mt.deepnight.Lib.distanceSqr(e.xx, e.yy, hero.xx, hero.yy) <= (Const.GRID * 1.5) * (Const.GRID * 1.5))
					return e.type;
			}
		}

		return null;
	}

	override public function update() {
		super.update();

		cm.update(dt);

		for (e in Entity.ALL)
			e.update();

		// if(hxd.Key.isPressed(hxd.Key.Y))
		// 	gameOver();
	}
}