/**
 * 
 */

document.addEventListener('DOMContentLoaded', () => {
    // Terminal boot sequence
    setTimeout(() => {
        document.getElementById('terminal-curtain').style.opacity = 0;
        setTimeout(() => {
            document.getElementById('terminal-curtain').style.display = 'none';
        }, 1000);
    }, 4000);

    // Navigation sound effects
    const navItems = document.querySelectorAll('.nav-item');
    const sounds = {
        creak: document.getElementById('creak'),
        static: document.getElementById('static'),
        typewriter: document.getElementById('typewriter')
    };

    navItems.forEach(item => {
        const soundType = item.getAttribute('data-sound');
        const sound = sounds[soundType];
        
        if (sound) {
            item.addEventListener('mouseenter', () => {
                sound.currentTime = 0;
                sound.volume = 0.3;
                sound.play().catch(e => console.log("Sound error:", e));
            });
        }
    });

    // Raven random appearance
	
	
	
});