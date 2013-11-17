import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;

typedef Point = {x:Float, y:Float, z:Float};

class Cube extends Entity {

  private var w:Array<Point>;
  private var p:Array<Canvas>;
  private var board:Canvas;

  private var count:Int = 0;
  private var N:Int = 2*2*2;
  
  private var speeda:Float = 3.14/32;
  private var speedb:Float = 1e-3;

  public function new () {
    super();

    board = new Canvas(HXP.width, HXP.height);
    addGraphic(board);

    w = new Array<Point>();
    p = new Array<Canvas>();
    for (k in 0...N) {
      var i:Int = Std.int(k/4);
      var j:Int = Std.int(k/2)%2;
      var l:Int = k%2;

      w.push({x:0, y:0, z:0});
      p.push(new Canvas(3,3));

      var color:Int = 0;
      if (i == 0)
        color = 0xff0000 + j*0xff;
      else if (i == 1)
        color = 0x00ff00 + j*0xff;

      p[k].fill(new Rectangle(0,0,3,3), color);
      addGraphic(p[k]);
    }
  }

  override public function update() {
    count++;
    var cosa:Float = Math.cos(count*speeda);
    var sina:Float = Math.sin(count*speeda);
    var cosb:Float = Math.cos(count*speedb);
    var sinb:Float = Math.sin(count*speedb);
    
    for (k in 0...N) {
      var i:Int = Std.int(k/4);
      var j:Int = Std.int(k/2)%2;
      var l:Int = k%2;

      w[k].x = 50*( ((2*i-1)*cosa - (2*j-1)*sina)*cosb -
          (2*l-1)*sinb );
      w[k].y = 50*( (2*i-1)*sina + (2*j-1)*cosa );
      w[k].z = 50*( ((2*i-1)*cosa - (2*j-1)*sina)*sinb + (2*l-1)*cosb );

      p[k].x = HXP.halfWidth  + 0.866*w[k].x + 0.5*w[k].z;
      p[k].y = HXP.halfHeight + 0.866*w[k].y - 0.5*w[k].z;
    }

    board.fill(new Rectangle(1,1,board.width-2,board.height-2), 0);
    for (k in 0...N) {
      var i:Int = Std.int(k/4);
      var j:Int = Std.int(k/2)%2;
      var l:Int = k%2;

      var kip:Int = 0;
      if (i == 0) {
        kip = k+4;
        drawLines(k, kip);
      } 
      if (j == 0) {
        kip = k+2;
        drawLines(k, kip);
      }
      if (l == 0) {
        kip = k+1;
        drawLines(k, kip);
      }
    }
  }

  private function drawLines (k:Int, kip:Int) {
    var x0:Float = p[k].x;
    var y0:Float = p[k].y;
    var x1:Float = p[kip].x;
    var y1:Float = p[kip].y;

    var dx:Float = x1-x0;
    var dy:Float = y1-y0;
    var N:Int = Std.int(Math.max(Math.abs(dx), Math.abs(dy)));
    dx /= N;
    dy /= N;

    for (i in 0...N+1) {
      var x:Float = x0 + i*dx;
      var y:Float = y0 + i*dy;

      board.fill(new Rectangle(x,y,1,1), 0x666666, 1.0);
    }
  }

}
