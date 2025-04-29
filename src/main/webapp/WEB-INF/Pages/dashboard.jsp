<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
if (session.getAttribute("user_id") == null) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}
%>
<html>
<head>
    <title>Case Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <style>
        .dashboard-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(10, 10, 10, 0.8);
            border: 1px solid #8b0000;
            box-shadow: 0 0 20px rgba(139, 0, 0, 0.3);
        }
        .dashboard-container h1 {
            color: #8b0000;
            text-shadow: 0 0 10px rgba(139, 0, 0, 0.5);
        }
        .dashboard-container a {
            color: #aaa;
            text-decoration: none;
            border-bottom: 1px dashed #8b0000;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h1>🔒 CLASSIFIED CASE FILES</h1>
        <p>Welcome, Agent ${sessionScope.user_id}</p>
        <a href="${pageContext.request.contextPath}/logout.jsp">Terminate Session</a>
    </div>
</body>
</html>