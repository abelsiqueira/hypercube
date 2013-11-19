import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;

class MainScene extends Scene {

	public override function begin() {
    var canvas:Canvas = new Canvas(HXP.width, HXP.height);
    canvas.fill(new Rectangle(0,0,HXP.width,HXP.height), 0xffffff);
    canvas.fill(new Rectangle(1,1,HXP.width-2,HXP.height-2), 0);

//    canvas.fill(new Rectangle(HXP.halfWidth,0,2,HXP.height), 0x00ffff);
//    canvas.fill(new Rectangle(0,HXP.halfHeight,HXP.width,2), 0x00ffff);
//    canvas.fill(new Rectangle(HXP.halfWidth-2,2,6,2), 0x00ffff);
//    canvas.fill(new Rectangle(HXP.width-4,HXP.halfHeight-2,2,6), 0x00ffff);

    add(new Entity(0, 0, canvas));
//    var cube:Cube = new Cube();
//    cube.drawAxis(canvas);
//    add(new Cube());
    var hypercube:HyperCube = new HyperCube();
    hypercube.drawAxis(canvas);
    add(new HyperCube());
	}

}
