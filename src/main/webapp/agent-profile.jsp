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
    <style>
        body {
            background-color: #000;
            color: #ccc;
            font-family: 'Courier New', monospace;
            overflow-y: auto;
            scroll-behavior: smooth;
        }

        .profile-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 3rem;
            border-bottom: 1px solid var(--blood-red);
            padding-bottom: 1rem;
            position: relative;
        }

        .profile-header::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 25%;
            width: 50%;
            height: 1px;
            background: linear-gradient(to right, transparent, var(--blood-red), transparent);
        }

        .glitch-title {
            color: var(--blood-red);
            font-size: 2.5rem;
            position: relative;
        }

        .redacted {
            background: #111;
            color: transparent;
            text-shadow: 0 0 8px rgba(139, 0, 0, 0.3);
            padding: 0 0.5rem;
            border-radius: 3px;
        }

        .clearance-badge {
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--blood-red);
            padding: 0.5rem 1rem;
            display: inline-block;
            margin-top: 1rem;
        }

        .clearance-level, .clearance-code {
            color: var(--blood-red);
            font-weight: bold;
        }

        .profile-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
        }

        .profile-section {
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--cobweb);
            padding: 1.5rem;
            position: relative;
            overflow: hidden;
        }

        .section-title {
            color: var(--blood-red);
            margin-bottom: 1.5rem;
            position: relative;
        }

        .identity-section {
            display: grid;
            grid-template-columns: 200px 1fr;
            gap: 2rem;
        }

        .id-photo {
            height: 250px;
            background: #111;
            border: 3px solid var(--blood-red);
            position: relative;
            overflow: hidden;
        }

        .id-photo::before {
            content: "CLASSIFIED";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: var(--blood-red);
            font-size: 1.5rem;
            font-weight: bold;
        }

        .id-info {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .info-row {
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px dashed #333;
        }

        .info-label {
            color: var(--blood-red);
            font-weight: bold;
            display: inline-block;
            width: 120px;
        }

        .info-value {
            color: #ccc;
        }

        .info-value.active {
            color: #00ff00;
            text-shadow: 0 0 5px rgba(0, 255, 0, 0.5);
        }

        .activity-log {
            font-family: 'Courier New', monospace;
        }

        .log-entry {
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px dashed #333;
        }

        .log-entry.warning {
            color: #ffcc00;
        }

        .log-entry.danger {
            color: var(--blood-red);
        }

        .log-time {
            color: #666;
            margin-right: 1rem;
        }

        .log-location {
            color: #666;
            float: right;
        }

        .signout-fixed {
            position: fixed;
            bottom: 20px;
            right: 20px;
            color: var(--blood-red);
            background: rgba(0, 0, 0, 0.6);
            padding: 0.5rem 1rem;
            border: 1px solid var(--blood-red);
            font-weight: bold;
            text-decoration: none;
            z-index: 1000;
        }

        .raven-image {
            position: fixed;
            top: 50px;
            right: 50px;
            width: 100px;
            opacity: 0.8;
            z-index: 0;
        }

        @keyframes flicker {
            0%, 19%, 21%, 23%, 25%, 54%, 56%, 100% {
                opacity: 1;
            }
            20%, 22%, 24%, 55% {
                opacity: 0.5;
            }
        }

        .flicker {
            animation: flicker 3s infinite;
        }

        @keyframes blink {
            0%, 100% { opacity: 1; }
            50% { opacity: 0; }
        }

        .blink {
            animation: blink 1s infinite;
        }
    </style>
</head>
<body>
    <a href="LogoutServlet" class="signout-fixed">[SIGN OUT]</a>

    <img src="${pageContext.request.contextPath}/assets/images/raven.png" id="raven" class="raven-image">

    <div class="profile-container">
        <div class="profile-header">
            <h1 class="glitch-title">AGENT <span class="redacted"><%= detective.getLastName() %></span> DOSSIER</h1>
            <div class="clearance-badge">
                <span class="clearance-level">CLEARANCE: <span class="flicker">BLACK</span></span>
                <span class="clearance-code">[<span class="blink">Ω-9</span>]</span>
            </div>
        </div>

        <div class="profile-grid">
            <div class="profile-section identity-section">
                <h2 class="section-title"><span class="flicker">IDENTITY</span></h2>
                <div class="id-photo"></div>
                <div class="id-info">
                    <div class="info-row">
                        <span class="info-label">NAME:</span>
                        <span class="info-value"><%= detective.getLastName() %>, <%= detective.getFirstName() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">EMAIL:</span>
                        <span class="info-value"><%= detective.getEmail() %></span>
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

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const raven = document.getElementById('raven');
            
            function moveRaven() {
                const x = Math.random() * (window.innerWidth - 100);
                const y = Math.random() * (window.innerHeight - 100);
                
                raven.style.transition = 'all 5s linear';
                raven.style.left = `${x}px`;
                raven.style.top = `${y}px`;
                
                setTimeout(moveRaven, 5000);
            }
            
            setTimeout(moveRaven, 2000);
        });
    </script>
</body>
</html>