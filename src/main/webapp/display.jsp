<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Detective's Photos</title>
</head>
<body>
    <h2>Photos for Detective</h2>

    <c:choose>
        <c:when test="${not empty photos}">
            <c:forEach var="photo" items="${photos}">
                <div style="margin-bottom: 15px;">
                    <img src="${photo.url}" alt="Detective Photo" style="width:200px;">
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>No photos found for this detective 😔</p>
        </c:otherwise>
    </c:choose>
</body>
</html>
