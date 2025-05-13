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
    <title>Incarcerate Subject | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <style>
        :root {
            --blood-red: #8b0000;
            --cobweb: #333;
        }

        body {
            background: #000;
            color: #ccc;
            font-family: 'Courier New', monospace;
            margin: 0;
            padding: 2rem;
            min-height: 100vh;
            background-image: 
                radial-gradient(circle at 10% 20%, var(--cobweb) 1px, transparent 1px),
                radial-gradient(circle at 90% 80%, var(--cobweb) 1px, transparent 1px);
            background-size: 30px 30px;
        }

        .containment-form {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(10, 10, 10, 0.8);
            border: 1px solid var(--blood-red);
            padding: 2rem;
            position: relative;
            overflow: hidden;
        }

        .containment-form::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(to right, transparent, var(--blood-red), transparent);
        }

        .containment-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px dashed var(--blood-red);
        }

        .containment-header h1 {
            color: var(--blood-red);
            text-shadow: 0 0 5px var(--blood-red);
            font-size: 2rem;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 2px;
            animation: flicker 2s infinite, typing 2s steps(18, end) forwards, blink-caret 0.75s step-end infinite;
            overflow: hidden;
            white-space: nowrap;
            border-right: 3px solid var(--blood-red);
            width: 0;
        }

        .containment-header p {
            color: #666;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .blink {
            animation: blink 1s step-end infinite;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--blood-red);
            font-weight: bold;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }

        input, textarea, select {
            width: 100%;
            padding: 0.8rem;
            background: rgba(0, 0, 0, 0.5);
            border: 1px solid var(--cobweb);
            color: #ccc;
            font-family: 'Courier New', monospace;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--blood-red);
            box-shadow: 0 0 5px rgba(139, 0, 0, 0.5);
            transform: scale(1.02);
            animation: flicker 2s infinite;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%238b0000'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.7rem center;
            background-size: 1.2rem;
            padding-right: 2rem;
            border-radius: 4px;
        }

        select:hover {
            border-color: #ff0000;
        }

        option[data-status="good"]::before,
        option[data-status="average"]::before,
        option[data-status="poor"]::before,
        option[data-status="violent"]::before {
            content: '';
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 8px;
            vertical-align: middle;
        }

        option[data-status="good"]::before {
            background-color: #00aa00;
            box-shadow: 0 0 5px #00aa00;
        }

        option[data-status="average"]::before {
            background-color: #aaaa00;
            box-shadow: 0 0 5px #aaaa00;
        }

        option[data-status="poor"]::before {
            background-color: #aa5500;
            box-shadow: 0 0 5px #aa5500;
        }

        option[data-status="violent"]::before {
            background-color: var(--blood-red);
            box-shadow: 0 0 5px var(--blood-red);
        }

        .contain-button {
            display: block;
            width: 100%;
            padding: 1rem;
            background: var(--blood-red);
            border: 1px solid var(--blood-red);
            color: #ccc;
            font-family: 'Courier New', monospace;
            font-weight: bold;
            font-size: 1.1rem;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 2rem;
        }

        .contain-button:hover {
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

        .security-notice {
            color: var(--blood-red);
            text-align: center;
            margin-top: 2rem;
            font-size: 0.8rem;
            border-top: 1px dashed var(--blood-red);
            padding-top: 1rem;
            animation: flicker 2s infinite;
        }

        .status-indicator {
            display: inline-block;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-right: 8px;
        }

        .status-good { background-color: #00aa00; box-shadow: 0 0 5px #00aa00; }
        .status-average { background-color: #aaaa00; box-shadow: 0 0 5px #aaaa00; }
        .status-poor { background-color: #aa5500; box-shadow: 0 0 5px #aa5500; }
        .status-violent { background-color: var(--blood-red); box-shadow: 0 0 5px var(--blood-red); }

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
            to { width: 18ch }
        }

        @keyframes blink-caret {
            from, to { border-color: transparent }
            50% { border-color: var(--blood-red) }
        }

        @keyframes blink {
            50% { opacity: 0; }
        }
    </style>
</head>
<body>
    <a href="LogoutServlet" class="signout-fixed">[SIGN OUT]</a>

    <div class="containment-form">
        <div class="containment-header">
            <h1>CONTAINMENT PROTOCOL</h1>
            <p>Detective: <span class="redacted"><%= detective.getLastName() %></span> | Clearance: <span class="blink">Gamma-3</span></p>
        </div>

        <form action="${pageContext.request.contextPath}/AddInmateServlet" method="post">
            <div class="form-group">
                <label for="name">SUBJECT DESIGNATION:</label>
                <input type="text" id="name" name="name" required placeholder="Enter subject's full designation">
            </div>
            
            <div class="form-group">
                <label for="charges">CONTAINMENT REASON:</label>
                <input type="text" id="charges" name="charges" required placeholder="Specify containment justification">
            </div>
            
            <div class="form-group">
                <label for="sentence">CONTAINMENT DURATION:</label>
                <input type="text" id="sentence" name="sentence" required placeholder="Specify sentence parameters">
            </div>
            
            <div class="form-group">
                <label for="info">ADDITIONAL NOTES:</label>
                <textarea id="info" name="info" rows="4" placeholder="Record any anomalous behavior or special containment requirements"></textarea>
            </div>
            
            <div class="form-group">
                <label for="behavior">CONTAINMENT RISK LEVEL:</label>
                <select id="behavior" name="behavior" required>
                    <option value="Good">Green (Cooperative)</option>
                    <option value="Average">Yellow (Moderate Risk)</option>
                    <option value="Poor">Orange (High Risk)</option>
                    <option value="Violent"> Red (Extreme Risk)</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="mentalState">PSYCHOLOGICAL STATUS:</label>
                <select id="mentalState" name="mentalState" required>
                    <option value="Stable">Code White (Stable)</option>
                    <option value="Unstable">Code Yellow (Unstable)</option>
                    <option value="Critical">Code Red (Critical)</option>
                </select>
            </div>
            
            <button type="submit" class="contain-button">AUTHORIZE CONTAINMENT</button>
            
            <p class="security-notice">
                WARNING: UNAUTHORIZED CONTAINMENT REQUESTS WILL BE LOGGED<br>
                ALL ENTRIES ARE PERMANENTLY ARCHIVED IN THE SHADOW FILES DATABASE
            </p>
        </form>
    </div>

    <script>
        document.querySelectorAll('select option').forEach(option => {
            const status = option.value.toLowerCase().replace(' ', '-');
            if (['good', 'average', 'poor', 'violent', 'stable', 'unstable', 'critical'].includes(status)) {
                option.setAttribute('data-status', status);
            }
        });

        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const button = document.querySelector('.contain-button');
            button.textContent = "PROCESSING...";
            button.style.backgroundColor = "#ff0000";
        });
    </script>
</body>
</html>