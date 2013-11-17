import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;

class Square extends Entity {

  private var p:Array<Canvas>;
  private var board:Canvas;

  private var count:Int = 0;
  private var N:Int = 2*2;

  public function new () {
    super();

    p = new Array<Canvas>();
    for (i in 0...N) {
      p.push(new Canvas(6,6));
    }

    board = new Canvas(200, 200);
    board.x = HXP.halfWidth - 100;
    board.y = HXP.halfHeight - 100;
    addGraphic(board);

    for (k in 0...N) {
      var i:Int = Std.int(k/2);
      var j:Int = k%2;

      var color:Int = 0;
      if (i == 0)
        color = 0xff0000 + j*0xff;
      else if (i == 1)
        color = 0xffff00 + j*0xff;

      p[k].fill(new Rectangle(0,0,6,6), color);
      p[k].x = HXP.halfWidth + (2*i - 1)*50;
      p[k].y = HXP.halfHeight + (2*j - 1)*50;
      addGraphic(p[k]);
    }
  }

  override public function update() {
    count++;
    var cos:Float = Math.cos(count*3.14/32);
    var sin:Float = Math.sin(count*3.14/32);
    
    for (k in 0...N) {
      var i:Int = Std.int(k/2);
      var j:Int = k%2;

      p[k].x = HXP.halfWidth  + 50*( (2*i-1)*cos - (2*j-1)*sin );
      p[k].y = HXP.halfHeight + 50*( (2*i-1)*sin + (2*j-1)*cos );
    }
  }

}
