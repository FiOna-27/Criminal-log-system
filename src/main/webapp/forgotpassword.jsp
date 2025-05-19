<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

    <!-- Main spooky stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">

    <!-- Forgot password-specific styling -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forgot-password.css">
</head>

<body>
    <!-- Container for the password reset form -->
    <div class="forgot-container">
        <h2>Reset Your Password</h2>

        <!-- Form sends data to ResetPasswordServlet via POST -->
        <form action="ResetPasswordServlet" method="post">

            <!-- Email field: where the user enters their registered email -->
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>

            <!-- Verification Code: typically sent to user's email -->
            <div class="form-group">
                <label for="code">Verification Code</label>
                <input type="text" id="code" name="verificationCode" required>
            </div>

            <!-- New Password field -->
            <div class="form-group">
                <label for="new-password">New Password</label>
                <input type="password" id="new-password" name="newPassword" required>
            </div>

            <!-- Confirm Password field to ensure user typed it correctly -->
            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirmPassword" required>
            </div>

            <!-- Submit button that resets the password (fingers crossed) -->
            <button type="submit" class="reset-btn">Reset Password</button>
        </form>
    </div>
</body>
</html>
