<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detective Registration | Shadow Files</title>

    <!-- External stylesheet -->
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/css/eerie.css"/>
</head>

<body>

    <!-- Thematic 'Access Denied' banner and raven image -->
    <div class="access-denied">ACCESS DENIED</div>
    <img src="assets/images/raven.png" id="raven" class="raven-image">

    <div class="form-container">
        <!-- Title with animated entry -->
        <h1 class="delayed-animation">THE SHADOW FILES</h1>

        <!-- Conditionally display an error message if 'error' attribute is set -->
        <c:if test="${not empty error}">
            <div class="error-message">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Registration form for new detectives -->
        <form action="AddDetectiveServlet" method="POST">
            <input type="text" name="firstName" placeholder="First Name" required>
            <input type="text" name="lastName" placeholder="Last Name" required>
            <input type="text" name="number" placeholder="Badge Number" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit" id="submit-btn">ENTER THE SHADOWS</button>
        </form>

        <!-- Link for returning detectives to log in -->
        <div class="login-prompt">  
            <span class="whisper">Already initiated?</span>
            <a href="login.jsp" class="blood-link"><span>Prove your identity</span></a>
        </div>

        <!-- Legal humor, very shadowy -->
        <p class="disclaimer">* By registering, you agree to unseen horrors.</p>
    </div>

    <!-- Audio effects for ambience -->
    <audio id="creak" preload="auto">
        <source src="assets/sounds/creak.mp3" type="audio/mpeg">
    </audio>
    <audio id="raven-caw" preload="auto">
        <source src="assets/sounds/raven-caw.mp3" type="audio/mpeg">
    </audio>

    <!-- Custom JavaScript for spooky interactions -->
    <script src="Javascript/eerie.js"></script>

</body>
</html>
