import openfl.Lib;

var chromaticAberration = new CustomShader("chromaticAberration");
var bright = new CustomShader("bright");
var tabi_left:FlxSprite;
var tabi_down:FlxSprite;
var tabi_up:FlxSprite;
var tabi_right:FlxSprite;

function create() {
	camGame.addShader(chromaticAberration);
	camHUD.addShader(chromaticAberration);
	camGame.addShader(bright);
	
	// FlxTrail stuff
	tabi_left = new FlxSprite(dad.x - 400, dad.y + 20);
	tabi_left.frames =  Paths.getSparrowAtlas("characters/tabi-crazy");
	tabi_left.animation.frameIndex = 28; // left
	tabi_left.antialiasing = true;
	insert(7, tabi_left);
	tabi_left.alpha = 0.00001;

	tabi_down = new FlxSprite(dad.x - 250, dad.y + 90);
	tabi_down.frames =  Paths.getSparrowAtlas("characters/tabi-crazy");
	tabi_down.animation.frameIndex = 0; // down
	tabi_down.antialiasing = true;
	insert(8, tabi_down);
	tabi_down.alpha = 0.00001;

	tabi_up = new FlxSprite(dad.x - 220, dad.y - 65);
	tabi_up.frames =  Paths.getSparrowAtlas("characters/tabi-crazy");
	tabi_up.animation.frameIndex = 56; // up
	tabi_up.antialiasing = true;
	insert(9, tabi_up);
	tabi_up.alpha = 0.00001;

	tabi_right = new FlxSprite(500, dad.y + 50);
	tabi_right.frames =  Paths.getSparrowAtlas("characters/tabi-crazy");
	tabi_right.animation.frameIndex = 42; // right
	tabi_right.antialiasing = true;
	insert(10, tabi_right);
	tabi_right.alpha = 0.00001;
}

// Shaky screen by Ne_Eo
function shakeWindow(magnitude:Float){
	if (FlxG.save.data.shakeShit) {
		return false; // I have no clue why it doesn't work
	} else {
		var randX:Bool = FlxG.random.bool(50);
		var randY:Bool = FlxG.random.bool(50);

		var xm = Std.int(Lib.application.window.width / (100 * magnitude));

		Lib.application.window.x += xm * (randX ? 1 : -1);
		Lib.application.window.y += xm * (randY ? 1 : -1);

		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			Lib.application.window.x -= xm * (randX ? 1 : -1);
			Lib.application.window.y -= xm * (randY ? 1 : -1);
		});
	}
}

function onDadHit(event:NoteHitEvent) {
	if (!FlxG.fullscreen)
		shakeWindow(1);

	// FlxTrail shit
	switch(event.direction) {
		case 0:
			tabi_left.alpha = 0.5;
			var bleh_left = new FlxTimer().start(0.5, function(singLEFT:FlxTimer){
				// tabi_left.alpha = 0.00001;
				FlxTween.tween(tabi_left, {alpha: 0.00001}, 0.1);
			});
		
		case 1:
			tabi_down.alpha = 0.5;
			var bleh_down = new FlxTimer().start(0.5, function(singDOWN:FlxTimer){
				// tabi_down.alpha = 0.00001;
				FlxTween.tween(tabi_down, {alpha: 0.00001}, 0.1);
			});
		
		case 2:
			tabi_up.alpha = 0.5;
			var bleh_up = new FlxTimer().start(0.5, function(singUP:FlxTimer){
			// tabi_up.alpha = 0.00001;
			FlxTween.tween(tabi_up, {alpha: 0.00001}, 0.1);
		});

		case 3:
			tabi_right.alpha = 0.5;
			var bleh_right = new FlxTimer().start(0.5, function(singRIGHT:FlxTimer){
			// tabi_right.alpha = 0.00001;
			FlxTween.tween(tabi_right, {alpha: 0.00001}, 0.1);
		});
	}
}

function update() {
    // sprite.alpha = health / 1;

    if (health / 2 - 1 && !FlxG.save.data.shaderShit) {
        bright.iTime = 2 / 32;
        bright.contrast = 2 / 8;
    } else {
        bright.iTime = health / 2;
        bright.contrast = health / 2;
    }

	if (!FlxG.save.data.shakeShit)
    	camHUD.shake(0.005, (60 / Conductor.bpm), null, true, FlxAxes.X);
}

 // Camera stuff

function postUpdate(elapsed:Float) {
    camFollow.setPosition(650 * 2, 750);

    if (curCameraTarget == 0) {
        // trace("CPU");
        chromaticAberration.iTime = 2;
        defaultCamZoom = 0.75;
        camFollow.setPosition(550 * 2, 750);
        FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
    } else {
        // trace("BF");
        chromaticAberration.iTime = 0;
        camFollow.setPosition(700 * 2, 750);
        defaultCamZoom = 0.6;
        FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
    }

	if  (FlxG.save.data.shaderShit)
		chromaticAberration.iTime = 0;
}

// Script by yashermania for changing noteskin

function onNoteCreation(event) {
	event.cancel();
	var note = event.note;
	
	if (!event.cancel) {
		switch (event.noteType) {
			default:
				note.frames = Paths.getFrames('game/notes/TabiNote');
			switch (event.strumID % 4 ) {
				case 0:
					note.animation.addByPrefix('scroll', 'purple0');
					note.animation.addByPrefix('hold', 'purple hold piece');
					note.animation.addByPrefix('holdend', 'pruple end hold');
				case 1:
					note.animation.addByPrefix('scroll', 'blue0');
					note.animation.addByPrefix('hold', 'blue hold piece');
					note.animation.addByPrefix('holdend', 'blue hold end');
				case 2:
					note.animation.addByPrefix('scroll', 'green0');
					note.animation.addByPrefix('hold', 'green hold piece');
					note.animation.addByPrefix('holdend', 'green hold end');
				case 3:
					note.animation.addByPrefix('scroll', 'red0');
					note.animation.addByPrefix('hold', 'red hold piece');
					note.animation.addByPrefix('holdend', 'red hold end');
			}
			note.scale.set(0.7, 0.7);
			note.updateHitbox();
		}
	}
}

function onStrumCreation(event) {
	event.cancel();
	var strum = event.strum;

	if (!event.cancel) {
		strum.frames = Paths.getFrames('game/notes/TabiNote');
		strum.animation.addByPrefix('green', 'arrowUP');
		strum.animation.addByPrefix('blue', 'arrowDOWN');
		strum.animation.addByPrefix('purple', 'arrowLEFT');
		strum.animation.addByPrefix('red', 'arrowRIGHT');
		strum.antialiasing = true;
		strum.scale.set(0.7,0.7);
		
		switch (event.strumID % 4) {
			case 0:
				strum.animation.addByPrefix("static", 'arrowLEFT0');
				strum.animation.addByPrefix("pressed", 'left press', 12, false);
				strum.animation.addByPrefix("confirm", 'left confirm', 24, false);
			case 1:
				strum.animation.addByPrefix("static", 'arrowDOWN0');
				strum.animation.addByPrefix("pressed", 'down press', 12, false);
				strum.animation.addByPrefix("confirm", 'down confirm', 24, false);
			case 2:
				strum.animation.addByPrefix("static", 'arrowUP0');
				strum.animation.addByPrefix("pressed", 'up press', 12, false);
				strum.animation.addByPrefix("confirm", 'up confirm', 24, false);
			case 3:
				strum.animation.addByPrefix("static", 'arrowRIGHT0');
				strum.animation.addByPrefix("pressed", 'right press', 12, false);
				strum.animation.addByPrefix("confirm", 'right confirm', 24, false);
		}	
		strum.updateHitbox();
	}
}