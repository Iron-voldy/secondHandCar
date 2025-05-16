<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Car | Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>

<div class="container">
    <%
    // Get any session messages
    String message = (String) session.getAttribute("message");
    String messageType = (String) session.getAttribute("messageType");

    if (message != null) {
    %>
        <div class="alert alert-<%= messageType %>">
            <%= message %>
        </div>
    <%
        // Clear the message after displaying it
        session.removeAttribute("message");
        session.removeAttribute("messageType");
    }
    %>

    <h2>Add New Car</h2>

    <form action="<%=request.getContextPath()%>/cars/add" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="make">Make <span style="color: red">*</span></label>
            <input type="text" id="make" name="make" required placeholder="e.g., Toyota, Honda, Ford">
        </div>

        <div class="form-group">
            <label for="model">Model <span style="color: red">*</span></label>
            <input type="text" id="model" name="model" required placeholder="e.g., Corolla, Civic, Mustang">
        </div>

        <div class="form-group">
            <label for="year">Year <span style="color: red">*</span></label>
            <input type="number" id="year" name="year" required min="1900" max="2025" placeholder="e.g., 2018">
        </div>

        <div class="form-group">
            <label for="price">Price (USD) <span style="color: red">*</span></label>
            <input type="number" id="price" step="0.01" name="price" required min="0" placeholder="e.g., 15000">
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="5" placeholder="Provide details about the vehicle condition, features, history, etc."></textarea>
        </div>

        <div class="form-group">
            <label for="images">Images</label>
            <div style="border: 2px dashed #ccc; padding: 20px; text-align: center; margin-bottom: 10px;">
                <i class="fas fa-cloud-upload-alt" style="font-size: 48px; color: #1e3c72; margin-bottom: 10px;"></i>
                <p>Drag and drop images here or click to select files</p>
                <input type="file" id="images" name="images" multiple accept="image/*" style="display: none;">
                <button type="button" onclick="document.getElementById('images').click();" class="btn btn-secondary">
                    Select Files
                </button>
            </div>
            <div id="image-preview" style="display: flex; flex-wrap: wrap; gap: 10px;"></div>
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/cars" class="btn btn-secondary">
                <i class="fas fa-times"></i> Cancel
            </a>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Car
            </button>
        </div>
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
    // Image preview functionality
    document.getElementById('images').addEventListener('change', function() {
        const preview = document.getElementById('image-preview');
        preview.innerHTML = '';

        if (this.files) {
            for (let i = 0; i < this.files.length; i++) {
                const file = this.files[i];
                if (!file.type.startsWith('image/')) continue;

                const reader = new FileReader();
                reader.onload = function(e) {
                    const div = document.createElement('div');
                    div.style.width = '100px';
                    div.style.height = '100px';
                    div.style.overflow = 'hidden';
                    div.style.position = 'relative';
                    div.style.border = '1px solid #ddd';
                    div.style.borderRadius = '4px';

                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.width = '100%';
                    img.style.height = '100%';
                    img.style.objectFit = 'cover';

                    div.appendChild(img);
                    preview.appendChild(div);
                };

                reader.readAsDataURL(file);
            }
        }
    });

    // Drag and drop functionality
    const dropZone = document.querySelector('div[style*="dashed"]');

    ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, preventDefaults, false);
    });

    function preventDefaults(e) {
        e.preventDefault();
        e.stopPropagation();
    }

    ['dragenter', 'dragover'].forEach(eventName => {
        dropZone.addEventListener(eventName, highlight, false);
    });

    ['dragleave', 'drop'].forEach(eventName => {
        dropZone.addEventListener(eventName, unhighlight, false);
    });

    function highlight() {
        dropZone.style.backgroundColor = '#f0f8ff';
        dropZone.style.borderColor = '#1e3c72';
    }

    function unhighlight() {
        dropZone.style.backgroundColor = '';
        dropZone.style.borderColor = '#ccc';
    }

    dropZone.addEventListener('drop', handleDrop, false);

    function handleDrop(e) {
        const dt = e.dataTransfer;
        const files = dt.files;
        const fileInput = document.getElementById('images');

        fileInput.files = files;

        // Trigger change event
        const event = new Event('change');
        fileInput.dispatchEvent(event);
    }
</script>
</body>
</html>