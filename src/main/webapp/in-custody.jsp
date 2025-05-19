<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.models.Detective" %>

<% 
    // Restrict access to logged-in detectives only
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

    <!-- Universal eerie site-wide CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">

    <!-- This page’s styles for the prisoner table and layout -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/in-custody.css">
</head>
<body>

    <!-- Always visible sign-out button floating in the void -->
    <a href="LogoutController" class="signout-fixed">[SIGN OUT]</a>

    <!-- Big ominous header for this section -->
    <div class="classified-container">
        <header class="classified-header">
            <h1>IN-<span class="glitch" data-text="CUSTODY">CUSTODY</span> FILES</h1>
            <p class="access-level">Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </header>
        
        <!-- Display error message from backend if it exists -->
        <c:if test="${not empty error}">
            <div class="alert-danger">${error}</div>
        </c:if>
        
        <!-- Button to add new inmate record -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/AddInmate.jsp" class="blood-button">
                + ADD NEW PRISONER
            </a>
        </div>
        
        <!-- Table of existing prisoners in custody -->
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

                        <!-- Dynamic class based on behavior type -->
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
