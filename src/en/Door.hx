package en;

class Door extends Entity {

    public function new(ncx, ncy, type) {
        super(ncx, ncy, type);

        wid = 1;
        hei = 1;

        xr = 0.5;
        yr = 0.5;
    }

    override public function update() {
        super.update();
    }
}