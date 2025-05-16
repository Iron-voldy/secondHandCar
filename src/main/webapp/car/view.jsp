<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
    <title>Car Details | Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>

<div class="container">
    <% Car car = (Car) request.getAttribute("car"); %>
    <% NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en", "US")); %>

    <div class="car-detail">
        <div class="car-detail-header">
            <div>
                <h2 class="car-detail-title"><%= car.getMake() + " " + car.getModel() %> (<%= car.getYear() %>)</h2>
                <p>ID: <%= car.getId() %></p>
            </div>
            <div class="car-detail-price">
                <%= currencyFormatter.format(car.getPrice()) %>
            </div>
        </div>

        <!-- Car Gallery -->
        <div class="car-gallery">
            <% if (car.getImages().length > 0) { %>
                <% for (String image : car.getImages()) { %>
                    <img src="<%=request.getContextPath()%>/images/cars/<%= image %>" alt="<%= car.getMake() + " " + car.getModel() %>">
                <% } %>
            <% } else { %>
                <img src="<%=request.getContextPath()%>/images/cars/default-car.jpg" alt="Default car image">
            <% } %>
        </div>

        <!-- Car Specifications -->
        <div class="car-specs">
            <div class="car-spec-item">
                <div class="car-spec-label">Make</div>
                <div class="car-spec-value"><%= car.getMake() %></div>
            </div>
            <div class="car-spec-item">
                <div class="car-spec-label">Model</div>
                <div class="car-spec-value"><%= car.getModel() %></div>
            </div>
            <div class="car-spec-item">
                <div class="car-spec-label">Year</div>
                <div class="car-spec-value"><%= car.getYear() %></div>
            </div>
            <div class="car-spec-item">
                <div class="car-spec-label">Price</div>
                <div class="car-spec-value"><%= currencyFormatter.format(car.getPrice()) %></div>
            </div>
        </div>

        <!-- Car Description -->
        <div class="car-description">
            <h3>Description</h3>
            <p><%= car.getDescription() != null && !car.getDescription().isEmpty() ? car.getDescription() : "No description available." %></p>
        </div>

        <!-- Action Buttons -->
        <div style="display: flex; gap: 15px; margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/cars" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Listings
            </a>
            <a href="<%=request.getContextPath()%>/cars/edit/<%= car.getId() %>" class="btn btn-primary">
                <i class="fas fa-edit"></i> Edit
            </a>
            <a href="<%=request.getContextPath()%>/cars/delete/<%= car.getId() %>"
               onclick="return confirm('Are you sure you want to delete this car?')"
               class="btn btn-danger">
                <i class="fas fa-trash"></i> Delete
            </a>
        </div>
    </div>

    <!-- Similar Cars Section -->
    <% List<Car> similarCars = (List<Car>) request.getAttribute("similarCars"); %>
    <% if (similarCars != null && !similarCars.isEmpty()) { %>
        <div style="margin-top: 40px;">
            <h3>Similar Cars You Might Like</h3>
            <div class="car-grid">
                <% for (Car similarCar : similarCars) {
                    String imageSrc = similarCar.getImages().length > 0
                        ? request.getContextPath() + "/images/cars/" + similarCar.getImages()[0]
                        : request.getContextPath() + "/images/cars/default-car.jpg";
                %>
                    <div class="car-card" onclick="window.location.href='<%=request.getContextPath()%>/cars/view/<%= similarCar.getId() %>'">
                        <div class="car-image">
                            <img src="<%= imageSrc %>" alt="<%= similarCar.getMake() + " " + similarCar.getModel() %>">
                        </div>
                        <div class="car-info">
                            <h3 class="car-title"><%= similarCar.getMake() + " " + similarCar.getModel() %></h3>
                            <p class="car-details"><%= similarCar.getYear() %></p>
                            <p class="car-price"><%= currencyFormatter.format(similarCar.getPrice()) %></p>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    <% } %>
</div>

<%@ include file="../includes/footer.jsp" %>
</body>
</html>