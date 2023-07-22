function postUpdate(elapsed:Float) {
    if (curCameraTarget == 1) {
        switch (boyfriend.animation.curAnim.name) {
            case "singDOWN": camFollow.y += 20 * elapsed;
            case "singUP": camFollow.y -= 20 * elapsed;
            case "singLEFT": camFollow.x -= 20 * elapsed;
            case "singRIGHT": camFollow.x += 20 * elapsed;
        }
    } else {
        switch (dad.animation.curAnim.name) {
            case "singDOWN": camFollow.y += 20 * elapsed;
            case "singUP": camFollow.y -= 20 * elapsed;
            case "singLEFT": camFollow.x -= 20 * elapsed;
            case "singRIGHT": camFollow.x += 20 * elapsed;
        }
    }
}