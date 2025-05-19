<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="com.example.models.Detective" %>

<!-- Check for authenticated detective session -->
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
    <!-- Define page metadata and stylesheets -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Most Wanted | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/most-wanted.css">
</head>
<body>
    <!-- Sign out link -->
    <a href="LogoutController" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <!-- Page header with detective information -->
        <header class="classified-header">
            <h1>MOST <span class="glitch" data-text="WANTED">WANTED</span> FILES</h1>
            <p class="access-level">Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </header>

        <!-- Search form for criminal records -->
        <div class="search-container">
            <form id="searchForm" action="${pageContext.request.contextPath}/SearchMostWantedController" method="get" autocomplete="off">
                <div class="search-wrapper">
                    <input type="text" id="searchInput" name="keyword" placeholder="ENTER TARGET DESIGNATION..." required />
                    <button type="submit">SEARCH</button>
                </div>
                <ul id="suggestions"></ul>
            </form>
        </div>

        <div class="scrollable-content">
            <!-- Display list of most wanted criminals -->
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
        
        <!-- Action buttons for authorized detectives -->
        <div class="action-buttons">
            <c:if test="${sessionScope.detective != null}">
                <a href="${pageContext.request.contextPath}/add-criminal.jsp" class="blood-button">
                    ADD NEW CRIMINAL
                </a>
                <a href="${pageContext.request.contextPath}/UpdateMostWanted.jsp" class="blood-button">
                    UPDATE RECORD
                </a>
                <c:if test="${sessionScope.detective.level >= 2}">
                    <a href="${pageContext.request.contextPath}/RemoveMostWanted.jsp" class="blood-button">
                        REMOVE TARGET
                    </a>
                </c:if>
            </c:if>
        </div>
    </div>

    <!-- Client-side JavaScript for search and UI interactions -->
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
