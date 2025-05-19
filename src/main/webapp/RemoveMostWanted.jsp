<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.models.Detective" %>

<!-- Check for authenticated detective with sufficient access level --%>
<%
    Detective detective = (Detective) session.getAttribute("detective");
    if (detective == null || detective.getLevel() < 2) {
        request.setAttribute("error", "Unauthorized: Insufficient access level");
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
    <title>Terminate Record | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/RemoveMostWanted.css">
</head>
<body>
    <div class="blood-drips"></div>
    
    <!-- Sign out link -->
    <a href="LogoutController" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <!-- Page header with detective information -->
        <div class="classified-header">
            <h1>TERMINATE <span class="glitch" data-text="RECORD">RECORD</span></h1>
            <p>Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </div>

        <!-- Form to terminate a criminal record -->
        <form action="${pageContext.request.contextPath}/RemoveMostWantedController" method="post">
            <div class="form-group">
                <label for="name">TARGET IDENTIFICATION:</label>
                <input type="text" id="name" name="name" required 
                       placeholder="Enter full name of subject to be terminated">
            </div>
            
            <button type="submit" class="terminate-button">INITIATE TERMINATION</button>
            
            <p class="security-warning">
                WARNING: THIS ACTION IS PERMANENT AND WILL PURGE ALL RECORDS<br>
                UNAUTHORIZED TERMINATION ATTEMPTS WILL BE REPORTED
            </p>
        </form>
    </div>

    <!-- Client-side JavaScript for form interactions -->
    <script>
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const button = document.querySelector('.terminate-button');
            button.textContent = "TERMINATING...";
            button.style.backgroundColor = "rgba(139, 0, 0, 0.7)";
        });

        const input = document.querySelector('input');
        input.addEventListener('focus', function() {
            this.style.animation = 'pulse 1.5s infinite';
        });
        input.addEventListener('blur', function() {
            this.style.animation = 'none';
        });
    </script>
</body>
</html>