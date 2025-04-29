<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Most Wanted | Shadow Files</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/eerie.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/most-wanted.css">
</head>
<body>
    <div class="blood-drips"></div>
    <img src="${pageContext.request.contextPath}/assets/images/raven.png" id="raven" class="raven-image">

    <div class="database-container">
        <header class="database-header">
            <h1><span class="glitch" data-text="CLASSIFIED">CLASSIFIED</span></h1>
            <div class="database-controls">
                <button id="add-criminal-btn" class="blood-button">
                    <span class="btn-icon">+</span> ADD PROFILE
                </button>
                <div class="search-box">
                    <input type="text" id="criminal-search" placeholder="SEARCH BY ID OR ALIAS...">
                    <span class="search-icon">🔍</span>
                </div>
            </div>
        </header>

        <!-- Add Criminal Modal (Hidden by default) -->
        <div id="add-criminal-modal" class="modal">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <h2>ADD NEW CRIMINAL PROFILE</h2>
                <form id="criminal-form">
                    <div class="form-group">
                        <label for="criminal-id">CASE ID:</label>
                        <input type="text" id="criminal-id" required pattern="[A-Z]{2}-[0-9]{4}">
                    </div>
                    <div class="form-group">
                        <label for="criminal-name">ALIAS:</label>
                        <input type="text" id="criminal-name" required>
                    </div>
                    <div class="form-group">
                        <label for="criminal-crimes">KNOWN CRIMES:</label>
                        <textarea id="criminal-crimes" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="criminal-danger">THREAT LEVEL:</label>
                        <select id="criminal-danger" required>
                            <option value="low">LOW</option>
                            <option value="medium">MEDIUM</option>
                            <option value="high">HIGH</option>
                            <option value="extreme">EXTREME</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="criminal-image">PROFILE IMAGE:</label>
                        <input type="file" id="criminal-image" accept="image/*">
                    </div>
                    <button type="submit" class="blood-button">SUBMIT TO DATABASE</button>
                </form>
            </div>
        </div>

        <!-- Criminal Database Table -->
        <div class="criminal-table">
            <div class="table-header">
                <div class="header-cell">CASE ID</div>
                <div class="header-cell">ALIAS</div>
                <div class="header-cell">CRIMES</div>
                <div class="header-cell">THREAT</div>
                <div class="header-cell">LAST SIGHTING</div>
                <div class="header-cell">ACTIONS</div>
            </div>

            <div class="table-body">
                <!-- Sample Criminal Entry -->
                <div class="table-row high-threat">
                    <div class="table-cell">XK-0420</div>
                    <div class="table-cell">THE SURGEON</div>
                    <div class="table-cell">Biological weapon development, 14 murders</div>
                    <div class="table-cell">
                        <span class="threat-level high">HIGH</span>
                    </div>
                    <div class="table-cell">[REDACTED]</div>
                    <div class="table-cell actions-cell">
                        <button class="action-btn view-btn">VIEW</button>
                        <button class="action-btn edit-btn">EDIT</button>
                        <button class="action-btn delete-btn">TERMINATE</button>
                    </div>
                </div>

                <!-- More criminal entries would be dynamically loaded here -->
            </div>
        </div>

        <!-- Criminal Details Modal -->
        <div id="criminal-details-modal" class="modal">
            <div class="modal-content criminal-details">
                <!-- Filled dynamically by JavaScript -->
            </div>
        </div>
    </div>

    <audio id="creak" preload="auto">
        <source src="${pageContext.request.contextPath}/assets/sounds/creak.mp3" type="audio/mpeg">
    </audio>
    <audio id="static" preload="auto">
        <source src="${pageContext.request.contextPath}/assets/sounds/static.mp3" type="audio/mpeg">
    </audio>

    <script src="${pageContext.request.contextPath}/js/most-wanted.js"></script>
</body>
</html>