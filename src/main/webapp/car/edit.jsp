<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<html>
<head>
    <title>Edit Car | Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<% Car car = (Car) request.getAttribute("car"); %>

<div class="container">
    <h2>Edit Car Details</h2>

    <form action="<%=request.getContextPath()%>/cars/edit/<%= car.getId() %>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= car.getId() %>">

        <div class="form-group">
            <label for="make">Make <span style="color: red">*</span></label>
            <input type="text" id="make" name="make" value="<%= car.getMake() %>" required>
        </div>

        <div class="form-group">
            <label for="model">Model <span style="color: red">*</span></label>
            <input type="text" id="model" name="model" value="<%= car.getModel() %>" required>
        </div>

        <div class="form-group">
            <label for="year">Year <span style="color: red">*</span></label>
            <input type="number" id="year" name="year" value="<%= car.getYear() %>" required min="1900" max="2025">
        </div>

        <div class="form-group">
            <label for="price">Price (USD) <span style="color: red">*</span></label>
            <input type="number" id="price" step="0.01" name="price" value="<%= car.getPrice() %>" required min="0">
        </div>

        <div class="form-group">
            <label for="description">Description</label>
            <textarea id="description" name="description" rows="5"><%= car.getDescription() != null ? car.getDescription() : "" %></textarea>
        </div>

        <div class="form-group">
            <label>Current Images</label>
            <div style="display: flex; flex-wrap: wrap; gap: 10px; margin-bottom: 15px;">
                <% if (car.getImages().length > 0) { %>
                    <% for (String image : car.getImages()) { %>
                        <div style="width: 100px; height: 100px; overflow: hidden; border: 1px solid #ddd; border-radius: 4px;">
                            <img src="<%=request.getContextPath()%>/images/cars/<%= image %>" style="width: 100%; height: 100%; object-fit: cover;" alt="Car Image">
                        </div>
                    <% } %>
                <% } else { %>
                    <p>No images available</p>
                <% } %>
            </div>
        </div>

        <div class="form-group">
            <label for="images">Upload New Images</label>
            <div style="border: 2px dashed #ccc; padding: 20px; text-align: center; margin-bottom: 10px;">
                <i class="fas fa-cloud-upload-alt" style="font-size: 48px; color: #1e3c72; margin-bottom: 10px;"></i>
                <p>Drag and drop images here or click to select files<br>
                <small>Note: Uploading new images will replace the current ones</small></p>
                <input type="file" id="images" name="images" multiple accept="image/*" style="display: none;">
                <button type="button" onclick="document.getElementById('images').click();" class="btn btn-secondary">
                    Select Files
                </button>
            </div>
            <div id="image-preview" style="display: flex; flex-wrap: wrap; gap: 10px;"></div>
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/cars" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Listings
            </a>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Update Car
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