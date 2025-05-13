<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.example.models.Detective" %>
<%
    Detective detective = (Detective) session.getAttribute("detective");
    if (detective == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Most Wanted | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <style>
        body {
            background-color: #000;
            color: #ccc;
            font-family: 'Courier New', monospace;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        .classified-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            flex: 1;
            display: flex;
            flex-direction: column;
            height: calc(100vh - 4rem);
        }

        .scrollable-content {
            flex: 1;
            overflow-y: auto;
            padding-right: 10px;
        }

        .scrollable-content::-webkit-scrollbar {
            width: 8px;
        }

        .scrollable-content::-webkit-scrollbar-track {
            background: rgba(10, 10, 10, 0.5);
        }

        .scrollable-content::-webkit-scrollbar-thumb {
            background-color: var(--blood-red);
            border-radius: 4px;
        }

        .search-container {
            position: sticky;
            top: 0;
            background: #000;
            padding: 1rem 0;
            z-index: 10;
            margin-bottom: 1rem;
        }

        .search-wrapper {
            display: flex;
            flex-direction: row; 
            align-items: center;
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            gap: 0.5rem; 
        }

        #searchInput {
            flex: 1; 
            max-width: 500px; 
            padding: 1rem 1.5rem;
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--blood-red);
            color: #ccc;
            font-family: 'Courier New', monospace;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        #searchInput:focus {
            outline: none;
            box-shadow: 0 0 10px rgba(139, 0, 0, 0.5);
            border-color: var(--blood-red);
        }

        #searchInput::placeholder {
            color: #666;
            font-style: italic;
        }

        #searchForm button {
            width: auto;
            padding: 1rem 1.5rem;
            background: rgba(139, 0, 0, 0.5);
            border: 1px solid var(--blood-red);
            color: #ccc;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: relative;
            overflow: hidden;
        }

        #searchForm button:hover {
            background: rgba(139, 0, 0, 0.7);
            text-shadow: 0 0 5px rgba(255, 255, 255, 0.5);
        }

        #searchForm button::after {
            content: "»";
            margin-left: 5px;
            opacity: 0;
            transition: all 0.3s ease;
        }

        #searchForm button:hover::after {
            opacity: 1;
            margin-left: 10px;
        }

       
        #suggestions {
            position: absolute;
            top: 100%;
            left: 0; 
            width: 500px;
            max-height: 300px;
            overflow-y: auto;
            background: #1a1a1a; 
            border: 1px solid var(--blood-red);
            border-top: none; 
            list-style: none;
            padding: 0;
            margin: 0;
            z-index: 1000;
            display: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
        }

        #suggestions li {
            padding: 0.8rem 1rem;
            color: #ccc;
            font-family: 'Courier New', monospace;
            border-bottom: 1px dashed #333;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        #suggestions li:hover {
            background: rgba(139, 0, 0, 0.3);
            color: #fff;
        }

        #suggestions::-webkit-scrollbar {
            width: 6px;
        }

        #suggestions::-webkit-scrollbar-track {
            background: #111;
        }

        #suggestions::-webkit-scrollbar-thumb {
            background-color: var(--blood-red);
            border-radius: 4px;
        }

        .classified-header {
            text-align: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            position: relative;
            border-bottom: 1px solid var(--blood-red);
        }

        .classified-header::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 25%;
            width: 50%;
            height: 1px;
            background: linear-gradient(to right, transparent, var(--blood-red), transparent);
        }

        .access-level {
            font-size: 0.9rem;
            letter-spacing: 1px;
            color: #666;
        }

        .redacted {
            background: #111;
            color: transparent;
            text-shadow: 0 0 8px rgba(139, 0, 0, 0.3);
            padding: 0 0.5rem;
            border-radius: 3px;
        }

        .most-wanted-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
            padding-bottom: 2rem;
        }

        .wanted-card {
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--cobweb);
            border-left: 3px solid var(--blood-red);
            padding: 1.5rem;
            transition: all 0.3s ease;
            height: 100%;
            box-sizing: border-box;
        }

        .wanted-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(139, 0, 0, 0.3);
        }

        .wanted-info h3 {
            color: var(--blood-red);
            margin-bottom: 1rem;
            font-size: 1.3rem;
        }

        .blood-text {
            color: var(--blood-red);
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            justify-content: center;
            padding: 1rem 0;
            background: rgba(0, 0, 0, 0.7);
            position: sticky;
            bottom: 0;
            z-index: 5;
        }

        .blood-button {
            padding: 0.8rem 1.5rem;
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--blood-red);
            color: #ccc;
            text-decoration: none;
            font-family: 'Courier New', monospace;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .blood-button:hover {
            background: rgba(139, 0, 0, 0.3);
        }

        .signout-fixed {
            position: fixed;
            bottom: 20px;
            right: 20px;
            color: var(--blood-red);
            background: rgba(0, 0, 0, 0.6);
            padding: 0.5rem 1rem;
            border: 1px solid var(--blood-red);
            font-family: 'Courier New', monospace;
            font-weight: bold;
            text-decoration: none;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <!-- SIGN OUT BUTTON -->
    <a href="LogoutServlet" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <header class="classified-header">
            <h1>MOST <span class="glitch" data-text="WANTED">WANTED</span> FILES</h1>
            <p class="access-level">Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </header>

        <!-- Search Bar -->
        <div class="search-container">
            <form id="searchForm" action="${pageContext.request.contextPath}/SearchMostWantedServlet" method="get" autocomplete="off">
                <div class="search-wrapper">
                    <input type="text" id="searchInput" name="keyword" placeholder="ENTER TARGET DESIGNATION..." required />
                    <button type="submit">SEARCH</button>
                </div>
                <ul id="suggestions"></ul>
            </form>
        </div>

        <div class="scrollable-content">
            <section class="wanted-section" id="wanted">
                <h2 class="section-title"><span class="ficker">CLASSIFIED CRIMINAL DOSSIERS</span></h2>
                <div class="most-wanted-grid">
                    <c:forEach var="criminal" items="${mostWantedList}">
                        <div class="wanted-card" data-sound="static">
                            <div class="wanted-info">
                                <h3>${criminal.name}</h3>
                                <p><strong class="blood-text">Charges:</strong> ${criminal.charges}</p>
                                <p><strong class="blood-text">Last Seen:</strong> ${criminal.lastSeen}</p>
                                <p><strong class="blood-text">Info:</strong> ${criminal.info}</p>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </div>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/add-criminal.jsp" class="blood-button">
                ADD NEW CRIMINAL
            </a>
            <a href="${pageContext.request.contextPath}/UpdateMostWanted.jsp" class="blood-button">
                UPDATE RECORD
            </a>
            <a href="${pageContext.request.contextPath}/RemoveMostWanted.jsp" class="blood-button">
                REMOVE TARGET
            </a>
        </div>
    </div>

    <script>
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
    </script>
</body>
</html>