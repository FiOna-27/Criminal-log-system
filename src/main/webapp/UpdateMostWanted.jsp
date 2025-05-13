<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Update Record | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <style>
        body {
            background-color: #000;
            color: #ccc;
            font-family: 'Courier New', monospace;
            margin: 0;
            padding: 0;
        }

        .classified-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: rgba(10, 10, 10, 0.8);
            border: 1px solid var(--blood-red);
            position: relative;
            overflow: hidden;
        }

        .classified-header {
            text-align: center;
            margin-bottom: 2rem;
            border-bottom: 1px solid var(--blood-red);
            padding-bottom: 1rem;
            position: relative;
        }

        .classified-header h1 {
            color: var(--blood-red);
            text-shadow: 0 0 5px var(--blood-red);
            font-size: 1.8rem;
            margin: 0;
            position: relative;
            animation: 
                flicker 2s infinite,
                typing 2s steps(14, end) forwards,
                blink-caret 0.75s step-end infinite;
            overflow: hidden;
            white-space: nowrap;
            border-right: 3px solid var(--blood-red);
            width: 0;
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

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--blood-red);
            font-weight: bold;
        }

        input, textarea {
            width: 100%;
            padding: 0.8rem;
            background: rgba(0, 0, 0, 0.5);
            border: 1px solid var(--cobweb);
            color: #ccc;
            font-family: 'Courier New', monospace;
            transition: all 0.3s ease;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--blood-red);
            box-shadow: 0 0 5px rgba(139, 0, 0, 0.5);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .blood-button {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background: var(--blood-red);
            border: 1px solid var(--blood-red);
            color: #ccc;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            width: 100%;
        }

        .blood-button:hover {
            background: #ff0000;
            transform: translateY(-2px);
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

        .access-warning {
            color: var(--blood-red);
            font-size: 0.9rem;
            margin-top: 1rem;
            text-align: center;
            animation: flicker 2s infinite;
        }

        @keyframes flicker {
            0%, 19%, 21%, 23%, 25%, 54%, 56%, 100% {
                opacity: 1;
            }
            20%, 22%, 24%, 55% {
                opacity: 0.5;
            }
        }

        @keyframes typing {
            from { width: 0 }
            to { width: 16ch }
        }

        @keyframes blink-caret {
            from, to { border-color: transparent }
            50% { border-color: var(--blood-red) }
        }
    </style>
</head>
<body>
    <!-- SIGN OUT BUTTON -->
    <a href="LogoutServlet" class="signout-fixed">[SIGN OUT]</a>

    <div class="classified-container">
        <div class="classified-header">
            <h1>UPDATE RECORD</h1>
            <p>Detective: <span class="redacted"><%= detective.getLastName() %></span></p>
        </div>

        <form action="${pageContext.request.contextPath}/UpdateMostWantedServlet" method="post">
            <div class="form-group">
                <label for="name">CRIMINAL IDENTIFIER:</label>
                <input type="text" id="name" name="name" required placeholder="Enter target's full name">
            </div>
            
            <div class="form-group">
                <label for="charges">UPDATED CHARGES:</label>
                <input type="text" id="charges" name="charges" required placeholder="Modify criminal charges">
            </div>
            
            <div class="form-group">
                <label for="lastSeen">LAST KNOWN LOCATION:</label>
                <input type="text" id="lastSeen" name="lastSeen" required placeholder="Update last sighting">
            </div>
            
            <div class="form-group">
                <label for="description">CLASSIFIED DETAILS:</label>
                <textarea id="description" name="description" rows="5" required placeholder="Enter updated dossier information"></textarea>
            </div>
            
            <button type="submit" class="blood-button">PROCESS RECORD UPDATE</button>
            
            <p class="access-warning">WARNING: UNAUTHORIZED MODIFICATIONS WILL BE TRACED</p>
        </form>
    </div>

    <script>
        document.querySelectorAll('input, textarea').forEach(element => {
            element.addEventListener('focus', () => {
                element.style.borderColor = 'var(--blood-red)';
                element.style.boxShadow = '0 0 5px rgba(139, 0, 0, 0.5)';
            });
            element.addEventListener('blur', () => {
                element.style.borderColor = 'var(--cobweb)';
                element.style.boxShadow = 'none';
            });
        });

        const form = document.querySelector('form');
        form.addEventListener('submit', (e) => {
            form.classList.add('glitch-effect');
            setTimeout(() => form.classList.remove('glitch-effect'), 1000);
        });
    </script>
</body>
</html>