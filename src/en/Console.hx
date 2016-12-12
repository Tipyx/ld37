package en;

class Console extends Entity {

    public function new(ncx, ncy, type) {
        super(ncx, ncy, type);

        wid = 1;
        hei = 1;

        xr = 0.5;
        yr = 0.5;

        // var gr = new h2d.Graphics(this);
        // gr.beginFill(0xd8d8d8);
        // gr.drawRect(0, 0, Const.GRID * wid, Const.GRID * hei);
        // gr.setPos(-Const.GRID * wid * 0.5, -Const.GRID * hei * 0.5);
        // this.add(gr, 0);
    }

    override public function update() {
        super.update();
    }
}