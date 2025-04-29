/**
 * 
 */
document.addEventListener('DOMContentLoaded', () => {
    // DOM Elements
    const addCriminalBtn = document.getElementById('add-criminal-btn');
    const addCriminalModal = document.getElementById('add-criminal-modal');
    const closeModalBtns = document.querySelectorAll('.close-modal');
    const criminalForm = document.getElementById('criminal-form');
    const criminalTable = document.querySelector('.table-body');
    const detailsModal = document.getElementById('criminal-details-modal');
    const creakSound = document.getElementById('creak');
    const staticSound = document.getElementById('static');

    // Initialize sounds
    creakSound.volume = 0.3;
    staticSound.volume = 0.2;

    // Modal Controls
    addCriminalBtn.addEventListener('click', () => {
        addCriminalModal.style.display = 'block';
        creakSound.currentTime = 0;
        creakSound.play();
    });

    closeModalBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            addCriminalModal.style.display = 'none';
            detailsModal.style.display = 'none';
            creakSound.currentTime = 0;
            creakSound.play();
        });
    });

    // Close modal when clicking outside
    window.addEventListener('click', (e) => {
        if (e.target === addCriminalModal || e.target === detailsModal) {
            addCriminalModal.style.display = 'none';
            detailsModal.style.display = 'none';
        }
    });

    // Form Submission
    criminalForm.addEventListener('submit', (e) => {
        e.preventDefault();
        
        // Get form values
        const id = document.getElementById('criminal-id').value;
        const name = document.getElementById('criminal-name').value;
        const crimes = document.getElementById('criminal-crimes').value;
        const danger = document.getElementById('criminal-danger').value;
        
        // Create new criminal row
        const newRow = document.createElement('div');
        newRow.className = `table-row ${danger}-threat`;
        newRow.innerHTML = `
            <div class="table-cell">${id}</div>
            <div class="table-cell">${name}</div>
            <div class="table-cell">${crimes}</div>
            <div class="table-cell">
                <span class="threat-level ${danger}">${danger.toUpperCase()}</span>
            </div>
            <div class="table-cell">[REDACTED]</div>
            <div class="table-cell actions-cell">
                <button class="action-btn view-btn">VIEW</button>
                <button class="action-btn edit-btn">EDIT</button>
                <button class="action-btn delete-btn">TERMINATE</button>
            </div>
        `;
        
        // Add to table
        criminalTable.prepend(newRow);
        
        // Reset form and close modal
        criminalForm.reset();
        addCriminalModal.style.display = 'none';
        
        // Play sound
        staticSound.currentTime = 0;
        staticSound.play();
        
        // Add event listeners to new buttons
        addRowEventListeners(newRow);
    });

    // View Criminal Details
    function showCriminalDetails(row) {
        const cells = row.querySelectorAll('.table-cell');
        const detailsContent = document.querySelector('.criminal-details');
        
        detailsContent.innerHTML = `
            <div class="criminal-photo"></div>
            <div class="criminal-info">
                <div class="info-label">CASE ID:</div>
                <div class="info-value">${cells[0].textContent}</div>
                
                <div class="info-label">ALIAS:</div>
                <div class="info-value">${cells[1].textContent}</div>
                
                <div class="info-label">CRIMES:</div>
                <div class="info-value">${cells[2].textContent}</div>
                
                <div class="info-label">THREAT LEVEL:</div>
                <div class="info-value">${cells[3].innerHTML}</div>
                
                <div class="info-label">LAST SIGHTING:</div>
                <div class="info-value">${cells[4].textContent}</div>
                
                <div class="info-label">STATUS:</div>
                <div class="info-value active">ACTIVE</div>
            </div>
        `;
        
        detailsModal.style.display = 'block';
    }

    // Add event listeners to table rows
    function addRowEventListeners(row) {
        const viewBtn = row.querySelector('.view-btn');
        const editBtn = row.querySelector('.edit-btn');
        const deleteBtn = row.querySelector('.delete-btn');
        
        viewBtn.addEventListener('click', () => {
            showCriminalDetails(row);
            creakSound.currentTime = 0;
            creakSound.play();
        });
        
        editBtn.addEventListener('click', () => {
            // In a real app, this would populate the edit form
            alert('Edit functionality would be implemented here');
            staticSound.currentTime = 0;
            staticSound.play();
        });
        
        deleteBtn.addEventListener('click', () => {
            if (confirm('Mark this criminal profile for termination?')) {
                row.classList.add('terminated');
                setTimeout(() => {
                    row.remove();
                }, 500);
                staticSound.currentTime = 0;
                staticSound.play();
            }
        });
    }

    // Initialize existing rows
    document.querySelectorAll('.table-row').forEach(row => {
        addRowEventListeners(row);
    });

    // Random raven appearance
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