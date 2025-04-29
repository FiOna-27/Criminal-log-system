<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Home | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">

    <style>
        html, body {
            height: auto;
            overflow: auto;
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
            transition: background 0.3s ease, color 0.3s ease;
        }

        .signout-fixed:hover {
            background-color: var(--blood-red);
            color: #000;
        }
    </style>
</head>
<body>

    <div class="terminal-curtain" id="terminal-curtain">
        <div class="boot-sequence">
            <div class="boot-line">> INITIALIZING SHADOW NETWORK...</div>
            <div class="boot-line">> LOADING CLASSIFIED DATABASES...</div>
            <div class="boot-line">> ESTABLISHING SECURE CONNECTION...</div>
            <div class="boot-line">> WELCOME, AGENT <span class="blink-text">█</span></div>
        </div>
    </div>

    <!-- SIGN OUT BUTTON (Fixed to Bottom Right) -->
    <a href="LogoutServlet" class="signout-fixed">[SIGN OUT]</a>

    <div class="home-container">
        <header class="classified-header">
            <h1>THE <span class="glitch" data-text="SHADOW">SHADOW</span> FILES</h1>
            <p class="access-level">Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </header>

        <nav class="main-nav">
            <div class="nav-item" data-sound="creak">
                <a href="${pageContext.request.contextPath}/most-wanted.jsp" class="blood-link">
                    MOST WANTED DATABASE
                    <span class="nav-icon">🕵️</span>
                    <span class="nav-text">ACTIVE CASES</span>
                    <span class="nav-glitch">UNAUTHORIZED</span>
                </a>
            </div>
            
            <div class="nav-item" data-sound="static">
                <a href="${pageContext.request.contextPath}/in-custody.jsp" class="blood-link">
                    <span class="nav-icon">📁</span>
                    <span class="nav-text">Prisoner Archive</span>
                    <span class="nav-glitch">RESTRICTED</span>
                </a>
            </div>
            
            <div class="nav-item" data-sound="typewriter">
                <a href="${pageContext.request.contextPath}/agent-profile.jsp" class="blood-link">
                    <span class="nav-icon">👤</span>
                    <span class="nav-text">AGENT PROFILE</span>
                    <span class="nav-glitch">TERMINATED</span>
                </a>
            </div>
        </nav>

        <div class="recent-activity">
            <h2 class="section-title"><span class="flicker">RECENT ACTIVITY</span></h2>
            <div class="activity-log">
                <div class="log-entry">
                    <span class="log-time">[23:42:07]</span>
                    <span class="log-text">New encrypted message received from ██████</span>
                </div>
                <div class="log-entry warning">
                    <span class="log-time">[23:39:33]</span>
                    <span class="log-text">Security breach attempt detected</span>
                </div>
                <div class="log-entry">
                    <span class="log-time">[23:15:19]</span>
                    <span class="log-text">Case #XK-891 status updated</span>
                </div>
            </div>
        </div>
    </div>

    <audio id="creak" preload="auto">
        <source src="${pageContext.request.contextPath}/assets/sounds/creak.mp3" type="audio/mpeg">
    </audio>
    <audio id="static" preload="auto">
        <source src="${pageContext.request.contextPath}/assets/sounds/static.mp3" type="audio/mpeg">
    </audio>
    <audio id="typewriter" preload="auto">
        <source src="${pageContext.request.contextPath}/assets/sounds/typewriter.mp3" type="audio/mpeg">
    </audio>

    <script src="${pageContext.request.contextPath}/Javascript/home.js"></script>
</body>
</html>
