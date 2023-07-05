// Hscript version of ExtendedCentral's Tabi health gimmick

var tabiHealthBar = true;
var drainHealth = true;
var moveBar = true;

function create() {
    if (tabiHealthBar)
        health += 100;
}
function postCreate() {
	health += 0.8;
}

function update() {
    if (tabiHealthBar) {
        if (healthBar.x > 50.5 && healthBarBG > 50.5) {moveBar = true;}
    }
}

function onPlayerHit(event) {
	health += 0.050;

    if (health > 1.950 && moveBar == true) {
        healthBar.x -= 20;
        healthBarBG.x -= 20;
    }

    if (healthBar.x < 50.5 && healthBarBG.x < 50.5) {
        healthBar.x += 0;
        healthBarBG.x += 0;
        moveBar = false;
    }

    if (healthBar.x > 50.5 && healthBarBG.x > 50.5) {
        healthBar.x += 0;
        healthBarBG.x += 0;
        moveBar = true;
    }

    if (event.note.isSustainNote) {
        FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom + 0.02}, Conductor.crochet / 2000); 
    }
}

function onDadHit(event:NoteHitEvent) {
    if (tabiHealthBar) {
        if (healthBar.x < 343.5 && healthBarBG.x < 343.5) {
            healthBar.x += 5;
            healthBarBG.x += 5;
        }
    }

    if (drainHealth == true && healthBar.x > 343.2 || healthBarBG.x > 343.2) {
        health -= 0.003;
    }

    if (event.note.isSustainNote) {
        health -= 0.0005;
        FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom + 0.05}, Conductor.crochet / 2000); 
        // trace("Yo Hold note");
    }

	if (!FlxG.save.data.shakeShit)
    	camGame.shake(0.03, 0.02, null, true);
}