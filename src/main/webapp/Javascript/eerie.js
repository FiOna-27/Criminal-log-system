document.addEventListener('DOMContentLoaded', () => {
    const creakSound = document.getElementById("creak");
    const ravenSound = document.getElementById("raven-caw");
    const ravenImage = document.getElementById("raven");
    const submitBtn = document.getElementById("submit-btn");
    const entryCurtain = document.getElementById("entry-curtain");
    const enterButton = document.getElementById("enter-button");

    function setupSounds() {
        creakSound.playbackRate = 0.8 + Math.random() * 0.4;
        ravenSound.playbackRate = 0.9 + Math.random() * 0.2;
        
        creakSound.volume = 0.3;
        ravenSound.volume = 0.2;
    }

    function startRavenInterval() {
        setInterval(() => {
            if (Math.random() > 0.7) {
                ravenImage.style.opacity = 1;
                setTimeout(() => {
                    ravenSound.currentTime = 0;
                    ravenSound.play();
                    setTimeout(() => {
                        ravenImage.style.opacity = 0;
                    }, 3000);
                }, 500);
            }
        }, 15000);
    }

    enterButton.addEventListener('click', () => {
        entryCurtain.style.opacity = 0;
        
        setTimeout(() => {
            entryCurtain.style.display = 'none';
            
            document.querySelector('h1').style.opacity = 1;
            
            setupSounds();
            startRavenInterval();
        }, 2000); 
    });
	
});