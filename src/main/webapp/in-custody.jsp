<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>In Custody | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/in-custody.css">
</head>
<body>
    <div class="blood-drips"></div>
    <img src="/assets/images/raven.png" id="raven" class="raven-image">

    <div class="containment-container">
        <header class="containment-header">
            <h1><span class="glitch" data-text="CLASSIFIED">CLASSIFIED</span></h1>
            <div class="containment-controls">
                <button id="add-prisoner-btn" class="blood-button">
                    <span class="btn-icon">+</span> ADD SUBJECT
                </button>
                <div class="search-box">
                    <input type="text" id="prisoner-search" placeholder="SEARCH BY ID OR ALIAS...">
                    <span class="search-icon">🔍</span>
                </div>
            </div>
        </header>

        <!-- Prisoner Table -->
        <div class="prisoner-table">
            <div class="table-header">
                <div class="header-cell">ID</div>
                <div class="header-cell">NAME</div>
                <div class="header-cell">CHARGES</div>
                <div class="header-cell">SENTENCE</div>
                <div class="header-cell">BEHAVIOR</div>
                <div class="header-cell">MENTAL STATE</div>
                <div class="header-cell">ACTIONS</div>
            </div>

            <div class="table-body">
                <!-- Example prisoner row (dynamic rows will be added via JavaScript) -->
                <div class="table-row dangerous">
                    <div class="table-cell" data-label="ID">1</div>
                    <div class="table-cell" data-label="NAME">
                        <span class="prisoner-name">John Doe</span>
                        <span class="danger-tag">⚠️</span>
                    </div>
                    <div class="table-cell" data-label="CHARGES">Armed Robbery</div>
                    <div class="table-cell" data-label="SENTENCE">15 years</div>
                    <div class="table-cell" data-label="BEHAVIOR">
                        <span class="behavior-indicator dangerous">Aggressive</span>
                    </div>
                    <div class="table-cell" data-label="MENTAL STATE">
                        <span class="mental-state dangerous">DANGEROUS</span>
                    </div>
                    <div class="table-cell actions-cell" data-label="ACTIONS">
                        <button class="action-btn view-btn" data-id="1">VIEW</button>
                        <button class="action-btn edit-btn" data-id="1">EDIT</button>
                        <button class="action-btn transfer-btn" data-id="1">TRANSFER</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="/js/in-custody.js"></script>
</body>
</html>
