<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Help Center</title>

  <!-- Global eerie styles for the whole site -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
  
  <!-- Page-specific spooky help center styles -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/help.css">
</head>
<body>
  <!-- Main container for the help content -->
  <div class="help-container">
    <h1>Help Center</h1>
    
    <!-- FAQ section: simple hardcoded answers -->
    <section class="faq-section">
      <h2>Frequently Asked Questions</h2>

      <div class="faq-item">
        <h3>How do I reset my password?</h3>
        <p>Go to the login page and click "Forgot Password." Follow the instructions to reset your password using your email.</p>
      </div>

      <div class="faq-item">
        <h3>How do I update my profile information?</h3>
        <p>After logging in, navigate to your profile page and click the "Edit" button to change your details.</p>
      </div>

      <div class="faq-item">
        <h3>Why can't I log in?</h3>
        <p>Ensure your email and password are correct. If you’ve forgotten your password, use the reset link.</p>
      </div>

      <div class="faq-item">
        <h3>How do I contact support?</h3>
        <p>Use the form below or email us directly at support@example.com.</p>
      </div>
    </section>

    <!-- Support contact form (posts to HelpServlet) -->
    <section class="support-section">
      <h2>Still need help?</h2>
      <p>If your issue wasn't addressed above, feel free to contact us using the form below.</p>

      <form action="HelpServlet" method="post">
        <input type="text" name="name" placeholder="Your Name" required>
        <input type="email" name="email" placeholder="Your Email" required>
        <textarea name="message" placeholder="Describe your issue..." rows="5" required></textarea>
        <button type="submit">Send Request</button>
      </form>
    </section>
  </div>
</body>
</html>
