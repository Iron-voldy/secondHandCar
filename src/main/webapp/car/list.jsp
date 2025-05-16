<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
    <title>Car Listings | Second-Hand Car Sales Platform</title>
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

    <h2>Car Listings</h2>

    <!-- Search Form -->
    <form action="<%=request.getContextPath()%>/cars/search" method="get" class="search-form">
        <div class="form-group" style="display: flex; gap: 10px;">
            <input type="text" name="keyword" placeholder="Search by make or model..."
                   value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>"
                   style="flex: 1;">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Search
            </button>
        </div>
    </form>

    <!-- Sort Controls -->
    <div class="sort-controls">
        <div>
            <span class="sort-label">Sort by:</span>
            <div class="sort-buttons">
                <a href="<%=request.getContextPath()%>/cars/sort/price_asc"
                   class="sort-btn <%= "price_asc".equals(request.getAttribute("currentSort")) ? "active" : "" %>">
                   Price: Low to High
                </a>
                <a href="<%=request.getContextPath()%>/cars/sort/price_desc"
                   class="sort-btn <%= "price_desc".equals(request.getAttribute("currentSort")) ? "active" : "" %>">
                   Price: High to Low
                </a>
                <a href="<%=request.getContextPath()%>/cars/sort/year_desc"
                   class="sort-btn <%= "year_desc".equals(request.getAttribute("currentSort")) ? "active" : "" %>">
                   Newest First
                </a>
                <a href="<%=request.getContextPath()%>/cars/sort/make"
                   class="sort-btn <%= "make".equals(request.getAttribute("currentSort")) ? "active" : "" %>">
                   Make
                </a>
            </div>
        </div>
        <a href="<%=request.getContextPath()%>/cars/add" class="btn btn-primary">
            <i class="fas fa-plus"></i> Add New Car
        </a>
    </div>

    <%
    List<Car> cars = (List<Car>) request.getAttribute("cars");
    if (cars == null || cars.isEmpty()) {
    %>
        <div style="text-align: center; padding: 40px 0;">
            <p>No cars found. Be the first to add a car listing!</p>
        </div>
    <% } else { %>
        <!-- Car Grid -->
        <div class="car-grid">
            <%
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
            for (Car car : cars) {
                String imageSrc = car.getImages().length > 0
                    ? request.getContextPath() + "/images/cars/" + car.getImages()[0]
                    : request.getContextPath() + "/images/cars/default-car.jpg";
            %>
                <div class="car-card" onclick="window.location.href='<%=request.getContextPath()%>/cars/view/<%= car.getId() %>'">
                    <div class="car-image">
                        <img src="<%= imageSrc %>" alt="<%= car.getMake() + " " + car.getModel() %>">
                    </div>
                    <div class="car-info">
                        <h3 class="car-title"><%= car.getMake() + " " + car.getModel() %></h3>
                        <p class="car-details"><%= car.getYear() %> • ID: <%= car.getId() %></p>
                        <p class="car-price"><%= currencyFormatter.format(car.getPrice()) %></p>
                        <div class="car-actions">
                            <a href="<%=request.getContextPath()%>/cars/view/<%= car.getId() %>" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View
                            </a>
                            <a href="<%=request.getContextPath()%>/cars/edit/<%= car.getId() %>" class="btn btn-secondary">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="<%=request.getContextPath()%>/cars/delete/<%= car.getId() %>"
                               onclick="return confirm('Are you sure you want to delete this car?')"
                               class="btn btn-danger">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
    // Add fade-out effect to alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.opacity = '0';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 500);
            }, 5000);
        });
    });
</script>
</body>
</html>