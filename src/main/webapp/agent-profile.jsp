<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    
</head>
<body>
    <!-- Sign Out Button -->
    <a href="${pageContext.request.contextPath}/LogoutController" class="signout-fixed">[SIGN OUT]</a>
    <img src="${pageContext.request.contextPath}/assets/images/raven.png" id="raven" class="raven-image" alt="Raven">

    <div class="profile-container">
        <!-- Profile Header -->
        <div class="profile-header">
            <h1 class="glitch-title">AGENT <span class="redacted"><%= detective.getLastName() %></span> DOSSIER</h1>
            <div class="clearance-badge">
                <span class="clearance-level">CLEARANCE: <span class="flicker">BLACK</span></span>
                <span class="clearance-code">[<span class="blink">Ω-9</span>]</span>
            </div>
        </div>

        <div class="profile-grid">
            <!-- Identity Section -->
            <div class="profile-section identity-section">
                <h2 class="section-title"><span class="flicker">IDENTITY</span></h2>
                <div class="id-photo <%= detective.isHideImage() ? "classified" : "" %>">
                    <c:if test="${not detective.hideImage and not empty detective.imageUrl}">
                        <img src="${pageContext.request.contextPath}${detective.imageUrl}" alt="Detective Profile">
                    </c:if>
                </div>
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
                    <!-- Image Update Form -->
                    <form class="image-form" action="${pageContext.request.contextPath}/AgentProfileController" method="post" enctype="multipart/form-data">
                        <input type="file" name="imageFile" accept="image/*" aria-label="Upload profile image">
                        <label>
                            <input type="checkbox" name="hideImage" <%= detective.isHideImage() ? "checked" : "" %>>
                            Hide Image
                        </label>
                        <button type="submit">Update Image</button>
                    </form>
                </div>
            </div>

            <!-- Activity Log Section -->
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

    <!-- Raven Animation Script -->
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