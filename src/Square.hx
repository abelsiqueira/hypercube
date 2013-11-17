import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;

class Square extends Entity {

  private var p00:Canvas;
  private var p01:Canvas;
  private var p10:Canvas;
  private var p11:Canvas;

  private var count:Int = 0;

  public function new () {
    super();

    p00 = new Canvas(6,6);
    p01 = new Canvas(6,6);
    p10 = new Canvas(6,6);
    p11 = new Canvas(6,6);

    p00.fill(new Rectangle(0,0,6,6), 0xff0000);
    p01.fill(new Rectangle(0,0,6,6), 0xff0000);
    p10.fill(new Rectangle(0,0,6,6), 0xff0000);
    p11.fill(new Rectangle(0,0,6,6), 0xff0000);

    p00.x = HXP.halfWidth - 50;
    p01.x = HXP.halfWidth - 50;
    p10.x = HXP.halfWidth + 50;
    p11.x = HXP.halfWidth + 50;
    p00.y = HXP.halfHeight - 50;
    p01.y = HXP.halfHeight + 50;
    p10.y = HXP.halfHeight - 50;
    p11.y = HXP.halfHeight + 50;

    addGraphic(p00);
    addGraphic(p01);
    addGraphic(p10);
    addGraphic(p11);
  }

  override public function update() {
    count++;
    var cos:Float = Math.cos(count*3.14/32);
    var sin:Float = Math.sin(count*3.14/32);
    p00.x = HXP.halfWidth +  50*( -cos + sin );
    p00.y = HXP.halfHeight + 50*( -sin - cos );
    p01.x = HXP.halfWidth +  50*( -cos - sin );
    p01.y = HXP.halfHeight + 50*( -sin + cos );
    p10.x = HXP.halfWidth +  50*( cos + sin );
    p10.y = HXP.halfHeight + 50*( sin - cos );
    p11.x = HXP.halfWidth +  50*( cos - sin );
    p11.y = HXP.halfHeight + 50*( sin + cos );
  }

}
