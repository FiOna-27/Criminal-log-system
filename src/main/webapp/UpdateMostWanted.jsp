<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.models.Detective" %>

<!-- Check for authenticated detective with sufficient access level -->
<%
    Detective detective = (Detective) session.getAttribute("detective");
    if (detective == null || detective.getLevel() < 1) {
        request.setAttribute("error", "Unauthorized: Insufficient access level");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Define page metadata and stylesheets -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Record | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/UpdateMostWanted.css">
</head>
<body>
    <!-- Sign out link -->
    <a href="LogoutController" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <!-- Page header with detective information -->
        <div class="classified-header">
            <h1>UPDATE RECORD</h1>
            <p>Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </div>

        <!-- Form to update a criminal record -->
        <form action="${pageContext.request.contextPath}/UpdateMostWantedController" method="post">
            <div class="form-group">
                <label for="name">CRIMINAL IDENTIFIER:</label>
                <input type="text" id="name" name="name" required placeholder="Enter target's full name">
            </div>
            
            <div class="form-group">
                <label for="charges">UPDATED CHARGES:</label>
                <input type="text" id="charges" name="charges" required placeholder="Modify criminal charges">
            </div>
            
            <div class="form-group">
                <label for="lastSeen">LAST KNOWN LOCATION:</label>
                <input type="text" id="lastSeen" name="lastSeen" required placeholder="Update last sighting">
            </div>
            
            <div class="form-group">
                <label for="description">CLASSIFIED DETAILS:</label>
                <textarea id="description" name="description" rows="5" required placeholder="Enter updated dossier information"></textarea>
            </div>
            
            <button type="submit" class="blood-button">PROCESS RECORD UPDATE</button>
            
            <p class="access-warning">WARNING: UNAUTHORIZED MODIFICATIONS WILL BE TRACED</p>
        </form>
    </div>

    <!-- Client-side JavaScript for form interactions -->
    <script>
        document.querySelectorAll('input, textarea').forEach(element => {
            element.addEventListener('focus', () => {
                element.style.borderColor = 'var(--blood-red)';
                element.style.boxShadow = '0 0 5px rgba(139, 0, 0, 0.5)';
            });
            element.addEventListener('blur', () => {
                element.style.borderColor = 'var(--cobweb)';
                element.style.boxShadow = 'none';
            });
        });

        const form = document.querySelector('form');
        form.addEventListener('submit', (e) => {
            form.classList.add('glitch-effect');
            setTimeout(() => form.classList.remove('glitch-effect'), 1000);
        });
    </script>
</body>
</html>