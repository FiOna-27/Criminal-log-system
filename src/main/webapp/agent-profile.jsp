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
    <title>Agent Profile | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/agent-profile.css">
    
    <style>
    html, body {
        height: auto;
        overflow-y: auto;
        background-color: #000; /* Optional: keep your theme consistent */
    }

    body {
        scroll-behavior: smooth;
    }
</style>
    
</head>
<body>
    <div class="blood-drips"></div>
    <img src="${pageContext.request.contextPath}/assets/images/raven.png" id="raven" class="raven-image">

    <div class="profile-container">
        <div class="profile-header">
            <h1 class="glitch-title">AGENT <span class="redacted">██████</span> DOSSIER</h1>
            <div class="clearance-badge">
                <span class="clearance-level">CLEARANCE: <span class="flicker">BLACK</span></span>
                <span class="clearance-code">[<span class="blink">Ω-9</span>]</span>
            </div>
        </div>
        
        

        <div class="profile-grid">
            <!-- Left Column -->
            <div class="profile-section identity-section">
                <h2 class="section-title"><span class="flicker">IDENTITY</span></h2>
                <div class="id-photo"></div>
                <div class="id-info">
                    <div class="info-row">
                        <span class="info-label">NAME:</span>
                        <span class="info-value"><span class="glitch-text"><%= detective.getLastName() %> <%= detective.getFirstName() %></span></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Email:</span>
                        <span class="info-value"> <%= detective.getEmail() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">STATUS:</span>
                        <span class="info-value active">ACTIVE</span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">SPECIALTY:</span>
                        <span class="info-value">PSYCHIC PHENOMENA</span>
                    </div>
                </div>
            </div>

            <!-- Full Width Section -->
            <div class="profile-section full-width">
                <h2 class="section-title"><span class="flicker">RECENT ACTIVITY</span></h2>
                <div class="activity-log">
                    <div class="log-entry">
                        <span class="log-time">[23:42:07]</span>
                        <span class="log-text">Accessed Case File #XK-891</span>
                        <span class="log-location">(Sector 7)</span>
                    </div>
                    <div class="log-entry warning">
                        <span class="log-time">[23:39:33]</span>
                        <span class="log-text">Memory wipe detected</span>
                        <span class="log-location">(Med Bay)</span>
                    </div>
                    <div class="log-entry danger">
                        <span class="log-time">[23:15:19]</span>
                        <span class="log-text">PSI exposure threshold exceeded</span>
                        <span class="log-location">(Containment Zone)</span>
                    </div>
                    <div class="log-entry">
                        <span class="log-time">[22:58:42]</span>
                        <span class="log-text">Report filed: Incident #442-B</span>
                        <span class="log-location">(Archive)</span>
                    </div>
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

    <script src="${pageContext.request.contextPath}/js/agent-profile.js"></script>
</body>
</html>