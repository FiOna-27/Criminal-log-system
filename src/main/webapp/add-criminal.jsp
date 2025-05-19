<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.models.Detective" %>

<%
    // Retrieve the current logged-in Detective object from the session
    Detective detective = (Detective) session.getAttribute("detective");

    // Check if the user is not logged in or lacks the required access level
    if (detective == null || detective.getLevel() < 1) {
        // Set an error message and redirect to the login page
        request.setAttribute("error", "Unauthorized: Insufficient access level");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Criminal | Shadow Files</title>

    <!-- Link to external CSS files for styling -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/add-criminal.css">
</head>

<body>
    <!-- Sign-out link for the logged-in detective -->
    <a href="LogoutController" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <div class="classified-header">
            <h1><span class="glitch" data-text="ADD CRIMINAL">ADD CRIMINAL</span> RECORD</h1>
            <!-- Display the last name of the authenticated detective -->
            <p>Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </div>

        <!-- Form to submit a new criminal record -->
        <form action="AddCriminalController" method="post">
            <!-- Hidden input indicating the criminal record type -->
            <input type="hidden" name="criminalType" value="mostWanted">

            <!-- Input field for the criminal's full name -->
            <div class="form-group">
                <label for="name">FULL NAME:</label>
                <input type="text" id="name" name="name" required>
            </div>

            <!-- Input field for listing criminal charges -->
            <div class="form-group">
                <label for="charges">CHARGES:</label>
                <input type="text" id="charges" name="charges" required>
            </div>

            <!-- Input field for the criminal's last known location -->
            <div class="form-group">
                <label for="lastSeen">LAST KNOWN LOCATION:</label>
                <input type="text" id="lastSeen" name="lastSeen" required>
            </div>

            <!-- Text area for entering a detailed description -->
            <div class="form-group">
                <label for="description">CLASSIFIED DETAILS:</label>
                <textarea id="description" name="description" rows="5" required></textarea>
            </div>

            <!-- Submit button to upload the criminal record -->
            <button type="submit" class="blood-button">UPLOAD TO CRIMINAL DATABASE</button>

            <!-- Warning message displayed below the form -->
            <p class="access-warning">WARNING: UNAUTHORIZED ACCESS WILL BE PUNISHED</p>
        </form>
    </div>

    <!-- JavaScript to add visual feedback when inputs are focused or blurred -->
    <script>
        document.querySelectorAll('input, textarea').forEach(element => {
            element.addEventListener('focus', () => {
                element.style.boxShadow = '0 0 10px rgba(139, 0, 0, 0.7)';
            });
            element.addEventListener('blur', () => {
                element.style.boxShadow = 'none';
            });
        });
    </script>
</body>
</html>
