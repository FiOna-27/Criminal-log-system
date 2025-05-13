document.addEventListener('DOMContentLoaded', () => {
    const wantedCards = document.querySelectorAll('.wanted-card');
    wantedCards.forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-5px)';
            card.style.boxShadow = '0 5px 15px rgba(139, 0, 0, 0.3)';
        });
        card.addEventListener('mouseleave', () => {
            card.style.transform = '';
            card.style.boxShadow = '';
        });
    });
	        const searchInput = document.getElementById('searchInput');
	        const suggestionsBox = document.getElementById('suggestions');

	        searchInput.addEventListener('keyup', function() {
	            const keyword = this.value.trim();

	            if (keyword.length === 0) {
	                suggestionsBox.style.display = 'none';
	                return;
	            }

	            fetch('${pageContext.request.contextPath}/SearchMostWantedServlet', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded'
	                },
	                body: 'keyword=' + encodeURIComponent(keyword)
	            })
	            .then(response => response.text())
	            .then(data => {
	                suggestionsBox.innerHTML = '';
	                if (data) {
	                    const names = data.split(',');
	                    names.forEach(name => {
	                        if (name.trim() !== '') {
	                            const li = document.createElement('li');
	                            li.textContent = name;
	                            li.addEventListener('click', () => {
	                                searchInput.value = name;
	                                suggestionsBox.style.display = 'none';
	                            });
	                            suggestionsBox.appendChild(li);
	                        }
	                    });
	                    suggestionsBox.style.display = names.length > 0 ? 'block' : 'none';
	                } else {
	                    suggestionsBox.style.display = 'none';
	                }
	            })
	            .catch(error => {
	                console.error('Error fetching suggestions:', error);
	                suggestionsBox.style.display = 'none';
	            });
	        });

	        document.addEventListener('click', function(e) {
	            if (e.target !== searchInput) {
	                suggestionsBox.style.display = 'none';
	            }
	        });

	        document.getElementById('searchForm').addEventListener('submit', function(e) {
	            if (searchInput.value.trim() === '') {
	                e.preventDefault();
	            }
	        });

	        document.addEventListener('DOMContentLoaded', () => {
	            const wantedCards = document.querySelectorAll('.wanted-card');
	            wantedCards.forEach(card => {
	                card.addEventListener('mouseenter', () => {
	                    card.style.transform = 'translateY(-5px)';
	                    card.style.boxShadow = '0 5px 15px rgba(139, 0, 0, 0.3)';
	                });
	                card.addEventListener('mouseleave', () => {
	                    card.style.transform = '';
	                    card.style.boxShadow = '';
	                });
	            });
	        });
	    
});
