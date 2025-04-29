<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Contact Us</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
</head>
<body>
  <div class="contact-container">
    <h1>Contact Us</h1>
    <form action="ContactServlet" method="post">
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" required />
      </div>

      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" required />
      </div>

      <div class="form-group">
        <label for="subject">Subject</label>
        <input type="text" id="subject" name="subject" required />
      </div>

      <div class="form-group">
        <label for="message">Your Message</label>
        <textarea id="message" name="message" rows="5" required></textarea>
      </div>

      <button type="submit" class="submit-btn">Send Message</button>
    </form>
  </div>
</body>
</html>
