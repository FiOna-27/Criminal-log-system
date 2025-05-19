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
    <title>Incarcerate Subject | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AddInmate.css">
    
</head>
<body>
    <a href="LogoutController" class="signout-fixed">[SIGN OUT]</a>

    <div class="containment-form">
        <div class="containment-header">
            <h1>CONTAINMENT PROTOCOL</h1>
            <p>Detective: <span class="redacted"><%= detective.getLastName() %></span> | Clearance: <span class="blink">Gamma-3</span></p>
        </div>

        <form action="${pageContext.request.contextPath}/AddInmateController" method="post">
            <div class="form-group">
                <label for="name">SUBJECT DESIGNATION:</label>
                <input type="text" id="name" name="name" required placeholder="Enter subject's full designation">
            </div>
            
            <div class="form-group">
                <label for="charges">CONTAINMENT REASON:</label>
                <input type="text" id="charges" name="charges" required placeholder="Specify containment justification">
            </div>
            
            <div class="form-group">
                <label for="sentence">CONTAINMENT DURATION:</label>
                <input type="text" id="sentence" name="sentence" required placeholder="Specify sentence parameters">
            </div>
            
            <div class="form-group">
                <label for="info">ADDITIONAL NOTES:</label>
                <textarea id="info" name="info" rows="4" placeholder="Record any anomalous behavior or special containment requirements"></textarea>
            </div>
            
            <div class="form-group">
                <label for="behavior">CONTAINMENT RISK LEVEL:</label>
                <select id="behavior" name="behavior" required>
                    <option value="Good">Green (Cooperative)</option>
                    <option value="Average">Yellow (Moderate Risk)</option>
                    <option value="Poor">Orange (High Risk)</option>
                    <option value="Violent"> Red (Extreme Risk)</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="mentalState">PSYCHOLOGICAL STATUS:</label>
                <select id="mentalState" name="mentalState" required>
                    <option value="Stable">Code White (Stable)</option>
                    <option value="Unstable">Code Yellow (Unstable)</option>
                    <option value="Critical">Code Red (Critical)</option>
                </select>
            </div>
            
            <button type="submit" class="contain-button">AUTHORIZE CONTAINMENT</button>
            
            <p class="security-notice">
                WARNING: UNAUTHORIZED CONTAINMENT REQUESTS WILL BE LOGGED<br>
                ALL ENTRIES ARE PERMANENTLY ARCHIVED IN THE SHADOW FILES DATABASE
            </p>
        </form>
    </div>

    <script>
        document.querySelectorAll('select option').forEach(option => {
            const status = option.value.toLowerCase().replace(' ', '-');
            if (['good', 'average', 'poor', 'violent', 'stable', 'unstable', 'critical'].includes(status)) {
                option.setAttribute('data-status', status);
            }
        });

        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const button = document.querySelector('.contain-button');
            button.textContent = "PROCESSING...";
            button.style.backgroundColor = "#ff0000";
        });
    </script>
</body>
</html>