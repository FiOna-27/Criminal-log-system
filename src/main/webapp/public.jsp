<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Define page metadata and stylesheets -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>National Criminal Records Bureau</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap">
</head>
<body>
    <!-- Government banner with agency information -->
    <div class="government-banner">
        <div class="banner-content">
            <img src="${pageContext.request.contextPath}/assets/images/government-logo.png" alt="Department Logo" class="agency-logo">
            <div class="agency-info">
                <h1>National Criminal Records Bureau</h1>
                <p>United States Department of Justice</p>
            </div>
        </div>
        <div class="login-section">
            <a href="${pageContext.request.contextPath}/login.jsp" class="gov-login-btn">
                <img src="${pageContext.request.contextPath}/assets/images/lock-icon.png" alt="Secure Login">
                Authorized Personnel Login
            </a>
        </div>
    </div>

    <!-- Navigation menu -->
    <nav class="gov-nav">
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#wanted">Most Wanted</a></li>
            <li><a href="#statistics">Crime Statistics</a></li>
            <li><a href="help.jsp">Public Help</a></li>
            <li><a href="contact.jsp">About NCRB</a></li>
        </ul>
    </nav>

    <main class="public-container">
        <!-- Most wanted criminals section -->
        <section class="wanted-section" id="wanted">
            <h2>Most Wanted Criminals</h2>
            <div class="wanted-grid">
                <c:forEach var="criminal" items="${mostWantedList}">
                    <div class="criminal-card">
                        <div class="criminal-img" style="background-image: url('${pageContext.request.contextPath}/assets/images/wanted1.jpg');">
                            <span class="wanted-banner">WANTED</span>
                        </div>
                        <div class="criminal-info">
                            <h3>${criminal.name}</h3>
                            <p><strong>Charges:</strong> ${criminal.charges}</p>
                            <p><strong>Last Seen:</strong> ${criminal.lastSeen}</p>
                            <button class="gov-btn">View Details</button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- Public alert notice -->
        <section class="notice-section">
            <div class="notice-box">
                <h3><img src="${pageContext.request.contextPath}/assets/images/warning-icon.png" alt="Warning"> Public Alert</h3>
                <p>If you have any information regarding these individuals, please contact the NCRB Tip Line at 1-800-555-0100. 
                <strong>Do not approach</strong> these individuals as they may be armed and dangerous.</p>
            </div>
        </section>

        <!-- Crime statistics section -->
        <section class="stats-section" id="statistics">
            <h2>National Crime Statistics</h2>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">↓ 12%</div>
                    <div class="stat-label">Violent Crime (2023)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">↑ 8%</div>
                    <div class="stat-label">Cyber Crime (2023)</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">↓ 4%</div>
                    <div class="stat-label">Property Crime (2023)</div>
                </div>
            </div>
        </section>
    </main>

    <!-- Page footer with contact and links -->
    <footer class="gov-footer">
        <div class="footer-content">
            <div class="footer-section">
                <h4>National Criminal Records Bureau</h4>
                <p>935 Pennsylvania Avenue NW<br>
                Washington, DC 20535<br>
                Phone: (202) 324-3000</p>
            </div>
            <div class="footer-section">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Accessibility</a></li>
                    <li><a href="#">Freedom of Information Act</a></li>
                </ul>
            </div>
        </div>
        <div class="copyright">
            <p>© 2023 National Criminal Records Bureau. All rights reserved.</p>
        </div>
    </footer>

    <!-- Watermark for branding -->
    <div class="shadow-watermark">
        <img src="${pageContext.request.contextPath}/assets/images/shadow-files-watermark.png" alt="Shadow Files">
    </div>
</body>
</html>