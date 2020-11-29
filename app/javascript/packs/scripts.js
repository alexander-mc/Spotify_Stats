window.playPause = function(id) {
    var mySong = document.getElementById(id);

    if (mySong.paused)
        mySong.play();
    else
        mySong.pause();
}

document.addEventListener('play', function(e) {
    // Get all <audio> tag elements on the page
    var allAudios = document.getElementsByTagName('audio');
    // Iterate through all players and pause them, except for
    // the one that fired the "play" event ("target")
    for (var i = 0; i < allAudios.length; i++) {
        if (allAudios[i] != e.target) {
        allAudios[i].pause();
        }
    }
}, true);