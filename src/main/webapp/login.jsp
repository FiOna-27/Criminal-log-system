<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    // DEBUG logs for dev console to track rendering
    System.out.println("DEBUG: Rendering login page");
    if (request.getAttribute("error") != null) {
        System.out.println("DEBUG: Error present: " + request.getAttribute("error"));
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Shadow Files</title>

    <!-- Global eerie styles -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">

    <!-- Login-specific glitchy aesthetics -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
    <!-- Just a casual dripping blood effect, nothing to worry about -->
    <div class="blood-drips"></div>

    <!-- Raven mascot or surveillance drone? You decide -->
    <img src="${pageContext.request.contextPath}/assets/images/raven.png" id="raven" class="raven-image">

    <div class="login-container">

        <!-- Display backend-passed error, if any -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                ⚠️ ${error}
            </div>
        <% } %>
        
        <h1 class="login-title">REMAIN VIGILANT</h1>

        <!-- Login form posts to LoginServlet -->
        <form action="${pageContext.request.contextPath}/LoginController" method="POST">
            <div class="input-group">
                <label for="email">AGENT ID:</label>
                <input type="email" id="email" name="email" required placeholder="Enter your identification code">
            </div>
            
            <div class="input-group">
                <label for="password">AUTH KEY:</label>
                <input type="password" id="password" name="password" required placeholder="············">
            </div>
            
            <!-- Easter egg-ish password recovery link -->
            <div class="forgot-password">
                <a href="${pageContext.request.contextPath}/forgotpassword.jsp" class="classified-link">
                    <span class="classified-block">████ ███████ ████?</span>
                    <span class="classified-reveal">Recover access</span>
                </a>
            </div>
            
            <!-- Spooky submit button -->
            <button type="submit" id="login-btn">
                <span class="btn-text">INITIATE VERIFICATION</span>
                <span class="btn-glitch">UNAUTHORIZED</span>
            </button>
        </form>

        <!-- Link to registration page -->
        <div class="registration-prompt">
            <span class="whisper">Not yet initiated?</span>
            <a href="${pageContext.request.contextPath}/addUser.jsp" class="blood-link">Request clearance</a>
        </div>

        <p class="disclaimer">
            All access attempts are monitored. Violators will be <span class="text-flicker">neutralized</span>.
        </p>
    </div>

    <!-- External JavaScript for login page interactions -->
    <script src="Javascript/login.js"></script>
</body>
</html>
