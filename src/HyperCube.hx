import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;

typedef Point = {x:Float, y:Float, z:Float, w:Float};

class HyperCube extends Entity {

  private var b:Array<Point>;
  private var w:Array<Point>;
  private var p:Array<Canvas>;
  private var board:Canvas;

  private var count:Int = 0;
  private var N:Int = 2*2*2*2;
  
  private var speeda:Float = 3.14/32;
  private var speedb:Float = 3.14/64;
  private var speedc:Float = 1e-3;

  public function new () {
    super();

    board = new Canvas(HXP.width, HXP.height);
    addGraphic(board);

    b = new Array<Point>();
    w = new Array<Point>();
    p = new Array<Canvas>();
    for (k in 0...N) {
      var i:Int = Std.int(k/8);
      var j:Int = Std.int(k/4)%2;
      var l:Int = Std.int(k/2)%2;
      var m:Int = k%2;

      b.push({x:2*i-1, y:2*j-1, z:2*l-1, w:2*m-1});
      w.push({x:0, y:0, z:0, w:0});
      p.push(new Canvas(3,3));

      var cint:Int = i+j+l+m;
      var color:Int = 0;
      switch  (cint) {
        case 0:
          color = 0xffffff;
        case 1:
          color = 0xff0000;
        case 2:
          color = 0x00ff00;
        case 3:
          color = 0x0000ff;
        case 4:
          color = 0xffff00;
      }

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
    var cosc:Float = Math.cos(count*speedc);
    var sinc:Float = Math.sin(count*speedc);
    
    for (k in 0...N) {
      var i:Int = Std.int(k/8);
      var j:Int = Std.int(k/4)%2;
      var l:Int = Std.int(k/2)%2;
      var m:Int = k%2;

      w[k].x = 50*( ((b[k].x*cosa - b[k].y*sina)*cosb - b[k].z*sinb)*cosc -
          b[k].w*sinc );
      w[k].y = 50*( b[k].x*sina + b[k].y*cosa );
      w[k].z = 50*( (b[k].x*cosa - b[k].y*sina)*sinb + b[k].z*cosb );
      w[k].w = 50*( ((b[k].x*cosa - b[k].y*sina)*cosb - b[k].z*sinb)*sinc +
          b[k].w*cosc );

      p[k].x = HXP.halfWidth  + 0.866*w[k].x + 0.5*w[k].z;
      p[k].y = HXP.halfHeight + 0.866*w[k].y - 0.5*w[k].z;
    }

    board.fill(new Rectangle(1,1,board.width-2,board.height-2), 0);
    for (k in 0...N) {
      var i:Int = Std.int(k/8);
      var j:Int = Std.int(k/4)%2;
      var l:Int = Std.int(k/2)%2;
      var m:Int = k%2;

      var kip:Int = 0;
      if (i == 0) {
        kip = k+8;
        drawLines(k, kip);
      } 
      if (j == 0) {
        kip = k+4;
        drawLines(k, kip);
      }
      if (l == 0) {
        kip = k+2;
        drawLines(k, kip);
      }
      if (m == 0) {
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
