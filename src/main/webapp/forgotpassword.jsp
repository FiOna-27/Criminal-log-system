<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forgot-password.css">
</head>
<body>
    <div class="forgot-container">
        <h2>Reset Your Password</h2>
        <form action="ResetPasswordServlet" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="code">Verification Code</label>
                <input type="text" id="code" name="verificationCode" required>
            </div>

            <div class="form-group">
                <label for="new-password">New Password</label>
                <input type="password" id="new-password" name="newPassword" required>
            </div>

            <div class="form-group">
                <label for="confirm-password">Confirm Password</label>
                <input type="password" id="confirm-password" name="confirmPassword" required>
            </div>

            <button type="submit" class="reset-btn">Reset Password</button>
        </form>
    </div>
</body>
</html>
