import FreeplayState;

var chromaticAberration = new CustomShader("chromaticAberration");

function create() {
    FlxG.camera.addShader(chromaticAberration);
}

function beatHit(curBeat) {
    if (songs[curSelected].name.toLowerCase() == 'genocide' || songs[curSelected].name.toLowerCase() == 'genocide-retrospecter-remix'){
			FlxG.camera.shake(0.005, 0.1);
            chromaticAberration.iTime = 5;
            FlxG.camera.zoom += 0.08 * 2;
            FlxTween.tween(FlxG.camera, { zoom: 1 }, 0.1);
		} else {
            FlxG.camera.shake(0);
            chromaticAberration.iTime = 0;
            FlxG.camera.zoom = 1;
        }
}