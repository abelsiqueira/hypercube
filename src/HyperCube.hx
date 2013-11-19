import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Canvas;
import flash.geom.Rectangle;

typedef Point = {x:Float, y:Float, ?z:Float, ?w:Float};

class HyperCube extends Entity {

  private var b:Array<Point>;
  private var w:Array<Point>;
  private var p:Array<Canvas>;
  private var board:Canvas;

  private var count:Int = 0;
  private var N:Int = 2*2*2*2;
  
  private var speeda:Float = 3.14/1024;
  private var speedb:Float = 3.14/1024;
  private var speedc:Float = 3.14/64;

  private var axis:Array<Point>;

  private var perspective:Bool = false;

  public function new () {
    super();

    axis = [{x:0, y:1}, {x:-0.866, y:-0.5}, {x:0.866, y:-0.5}, {x:0, y:0}];
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

      w[k].x = ((b[k].x*cosa - b[k].y*sina)*cosb - b[k].z*sinb)*cosc -
          b[k].w*sinc;
      w[k].y = b[k].x*sina + b[k].y*cosa;
      w[k].z = (b[k].x*cosa - b[k].y*sina)*sinb + b[k].z*cosb;
      w[k].w = ((b[k].x*cosa - b[k].y*sina)*cosb - b[k].z*sinb)*sinc + b[k].w*cosc;

      var P:Point = {x:0, y:0};
      projectPoint(w[k], P);

      p[k].x = P.x;
      p[k].y = P.y;
    }

    board.fill(new Rectangle(1,1,board.width-2,board.height-2), 0, 0);
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

  private function projectPoint (w:Point, P:Point) {
    if (perspective) {
      P.x = HXP.halfWidth  + 50*(axis[0].x*w.x + axis[1].x*w.y + axis[2].x*w.z) *
        Math.pow(2, (w.w+1)/2);
      P.y = HXP.halfWidth  - 50*(axis[0].y*w.x - axis[1].y*w.y - axis[2].y*w.z) *
        Math.pow(2, (w.w+1)/2);
    } else {
      P.x = HXP.halfWidth  + 50*(axis[0].x*w.x + axis[1].x*w.y + axis[2].x*w.z);
      P.y = HXP.halfWidth  - 50*(axis[0].y*w.x - axis[1].y*w.y - axis[2].y*w.z);
    }
  }

  private function drawLines (k:Int, kip:Int) {
    var p0:Point = {x:p[k].x, y:p[k].y};
    var p1:Point = {x:p[kip].x, y:p[kip].y};
  
    drawLineFromTo (p0, p1, board);
  }

  private function drawLineFromTo (p0:Point, p1:Point, canvas:Canvas, color=0x666666) {
    var x0:Float = p0.x;
    var y0:Float = p0.y;
    var x1:Float = p1.x;
    var y1:Float = p1.y;

    var dx:Float = x1-x0;
    var dy:Float = y1-y0;
    var N:Int = Std.int(Math.max(Math.abs(dx), Math.abs(dy)));
    dx /= N;
    dy /= N;

    for (i in 0...N+1) {
      var x:Float = x0 + i*dx;
      var y:Float = y0 + i*dy;

      canvas.fill(new Rectangle(x,y,1,1), color);
    }
  }

  public function drawAxis (canvas:Canvas) {
    var p:Point = {x:HXP.halfWidth, y:HXP.halfHeight};
    var pf:Point = {x:p.x, y:p.y};
    var color:Int = 0x666666;

    for (i in 0...3) {
      pf.x = p.x + 300*axis[i].x;
      pf.y = p.y - 300*axis[i].y;
      drawLineFromTo(p, pf, canvas, color);
    }
  }

}
