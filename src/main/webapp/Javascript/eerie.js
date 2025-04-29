document.addEventListener('DOMContentLoaded', () => {
    const creakSound = document.getElementById("creak");
    const ravenSound = document.getElementById("raven-caw");
    const ravenImage = document.getElementById("raven");
    const submitBtn = document.getElementById("submit-btn");
    const entryCurtain = document.getElementById("entry-curtain");
    const enterButton = document.getElementById("enter-button");

    // Initialize sounds with random pitch
    function setupSounds() {
        // Random pitch for creak (0.8x to 1.2x normal speed)
        creakSound.playbackRate = 0.8 + Math.random() * 0.4;
        ravenSound.playbackRate = 0.9 + Math.random() * 0.2;
        
        // Set volumes
        creakSound.volume = 0.3;
        ravenSound.volume = 0.2;
    }

    // Play raven sounds at random intervals
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

    // Enter button click handler
    enterButton.addEventListener('click', () => {
        // Fade out curtain (slower)
        entryCurtain.style.opacity = 0;
        
        // After fade completes:
        setTimeout(() => {
            entryCurtain.style.display = 'none';
            
            // Start typewriter effect by adding class
            document.querySelector('h1').style.opacity = 1;
            
            // Setup and start sound effects
            setupSounds();
            startRavenInterval();
        }, 2000); // Matches CSS transition time
    });

    // Remove the button hover sound completely
    // (This is the change you requested - removed the mouseover event listener)
});