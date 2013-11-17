import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;

class Main extends Engine
{

  override public function new() {
    super(800, 800, 30, false);
  }

	override public function init()
	{
#if debug
		HXP.console.enable();
    HXP.console.toggleKey = Key.E;
#end
		HXP.scene = new MainScene();
    HXP.screen.color = 0;
	}

	public static function main() { new Main(); }

}
