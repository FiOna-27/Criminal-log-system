<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>In-Custody | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <style>
        .classified-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }
        
        .prisoner-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--cobweb);
        }
        
        .prisoner-table th {
            background: rgba(139, 0, 0, 0.3);
            color: var(--blood-red);
            padding: 1rem;
            text-align: left;
            border-bottom: 2px solid var(--blood-red);
            font-family: 'Courier New', monospace;
        }
        
        .prisoner-table td {
            padding: 1rem;
            border-bottom: 1px dashed #333;
            color: #ccc;
        }
        
        .prisoner-table tr:hover {
            background: rgba(139, 0, 0, 0.1);
        }
        
        .behavior-good {
            color: #00ff00;
            font-weight: bold;
            text-shadow: 0 0 5px rgba(0, 255, 0, 0.5);
        }
        
        .behavior-bad {
            color: var(--blood-red);
            font-weight: bold;
            text-shadow: 0 0 5px rgba(139, 0, 0, 0.5);
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .blood-button {
            padding: 0.8rem 1.5rem;
            background: rgba(10, 10, 10, 0.7);
            border: 1px solid var(--blood-red);
            color: #ccc;
            text-decoration: none;
            font-family: 'Courier New', monospace;
            transition: all 0.3s ease;
        }
        
        .blood-button:hover {
            background-color: rgba(139, 0, 0, 0.2);
            transform: translateY(-2px);
        }
        
        .alert-danger {
            color: var(--blood-red);
            background: rgba(139, 0, 0, 0.1);
            border: 1px solid var(--blood-red);
            padding: 1rem;
            margin-bottom: 2rem;
            font-family: 'Courier New', monospace;
        }
        
        .classified-header {
            text-align: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--blood-red);
            padding-bottom: 1rem;
            position: relative;
        }
        
        .classified-header::after {
            content: "";
            position: absolute;
            bottom: -5px;
            left: 25%;
            width: 50%;
            height: 1px;
            background: linear-gradient(to right, transparent, var(--blood-red), transparent);
        }
        
        .signout-fixed {
            position: fixed;
            bottom: 20px;
            right: 20px;
            color: var(--blood-red);
            background: rgba(0, 0, 0, 0.6);
            padding: 0.5rem 1rem;
            border: 1px solid var(--blood-red);
            font-family: 'Courier New', monospace;
            font-weight: bold;
            text-decoration: none;
            z-index: 1000;
        }
        
        .redacted {
            background: #111;
            color: transparent;
            text-shadow: 0 0 8px rgba(139, 0, 0, 0.3);
            padding: 0 0.3rem;
            border-radius: 3px;
        }
    </style>
</head>
<body>
    <!-- SIGN OUT BUTTON -->
    <a href="LogoutServlet" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <header class="classified-header">
            <h1>IN-<span class="glitch" data-text="CUSTODY">CUSTODY</span> FILES</h1>
            <p class="access-level">Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </header>
        
        <c:if test="${not empty error}">
            <div class="alert-danger">${error}</div>
        </c:if>
        
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/AddInmate.jsp" class="blood-button">
                + ADD NEW PRISONER
            </a>
            
        </div>
        
        <table class="prisoner-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>NAME</th>
                    <th>CHARGES</th>
                    <th>SENTENCE</th>
                    <th>BEHAVIOR</th>
                    <th>MENTAL STATE</th>
                    <th>ADDITIONAL INFO</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prisoner" items="${prisoners}">
                    <tr>
                        <td class="redacted">${prisoner.id}</td>
                        <td>${prisoner.name}</td>
                        <td>${prisoner.charges}</td>
                        <td>${prisoner.sentence}</td>
                        <td class="behavior-${prisoner.behavior.toLowerCase()}">
                            ${prisoner.behavior}
                        </td>
                        <td>${prisoner.mentalState}</td>
                        <td>${prisoner.info}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>