/**
 * 
 */

document.addEventListener('DOMContentLoaded', () => {
    const creakSound = document.getElementById('creak');
    const staticSound = document.getElementById('static');
    
    creakSound.playbackRate = 0.8 + Math.random() * 0.4;
    staticSound.playbackRate = 0.9 + Math.random() * 0.2;
    
    const equipmentCards = document.querySelectorAll('.equipment-card');
    equipmentCards.forEach(card => {
        card.addEventListener('mouseenter', () => {
            creakSound.currentTime = 0;
            creakSound.play().catch(e => console.log("Sound error:", e));
        });
    });
    
    const psychNotes = document.querySelectorAll('.note.redacted');
    psychNotes.forEach(note => {
        note.addEventListener('click', () => {
            staticSound.currentTime = 0;
            staticSound.play().catch(e => console.log("Sound error:", e));
            note.classList.toggle('revealed');
        });
    });
    
    setInterval(() => {
        if (Math.random() > 0.7) {
            const raven = document.getElementById('raven');
            raven.style.opacity = 1;
            setTimeout(() => {
                raven.style.opacity = 0;
            }, 3000);
        }
    }, 15000);
});