document.addEventListener('DOMContentLoaded', () => {
    // Password visibility toggle
    const eyeToggle = document.querySelector('.eye-toggle');
    const passwordInput = document.getElementById('password');
    
    eyeToggle.addEventListener('click', () => {
        const type = passwordInput.type === 'password' ? 'text' : 'password';
        passwordInput.type = type;
        eyeToggle.textContent = type === 'password' ? '👁' : '👁‍🗨';
    });

    // Raven random appearance
    setInterval(() => {
        if (Math.random() > 0.7) {
            const raven = document.getElementById('raven');
            raven.style.opacity = 1;
            setTimeout(() => {
                raven.style.opacity = 0;
            }, 3000);
        }
    }, 15000);

    // Add red glow to inputs when focused
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', () => {
            input.style.boxShadow = '0 0 8px rgba(139, 0, 0, 0.5)';
        });
        input.addEventListener('blur', () => {
            input.style.boxShadow = 'none';
        });
    });
	
	// login-page.js - Login specific interactions
	document.addEventListener('DOMContentLoaded', () => {
	    // Ensure sound manager exists
	    if (!window.eerieSoundManager) {
	        window.eerieSoundManager = new EerieSoundManager();
	    }
	    
	    // Add any login-specific sound triggers here
	    const form = document.querySelector('form');
	    if (form) {
	        form.addEventListener('submit', () => {
	            eerieSoundManager.playCreak();
	        });
	    }
	    
	    // Initialize sounds
	    eerieSoundManager.init();
	});
});