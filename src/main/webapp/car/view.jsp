<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%@ page import="com.carsales.servlet.ReviewServlet" %>
<%@ page import="com.carsales.model.Review" %>
<%@ page import="java.util.ArrayList" %>

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

    <!-- Add this section to the car/view.jsp file, just before the similar cars section -->

    <!-- Reviews Section -->
    <div style="margin-top: 40px;">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h3>Reviews & Ratings</h3>
            <a href="<%=request.getContextPath()%>/reviews/car/<%= car.getId() %>" class="btn btn-primary">
                <i class="fas fa-star"></i> See All Reviews
            </a>
        </div>

        <%
        // Get review information using the ReviewServlet
        ReviewServlet reviewServlet = (ReviewServlet) application.getAttribute("ReviewServlet");
        Double averageRating = 0.0;
        List<Review> recentReviews = new ArrayList<>();

        if (reviewServlet != null) {
            averageRating = reviewServlet.getAverageRatingForCar(car.getId());
            List<Review> allReviews = reviewServlet.getReviewsForCar(car.getId());
            // Get up to 2 most recent reviews for preview
            for (int i = 0; i < Math.min(2, allReviews.size()); i++) {
                recentReviews.add(allReviews.get(i));
            }
        }
        %>

        <div style="background-color: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);">
            <div style="display: flex; align-items: center; margin-bottom: 20px;">
                <div style="font-size: 36px; font-weight: 700; color: #333; margin-right: 15px;">
                    <%= String.format("%.1f", averageRating) %>
                </div>
                <div>
                    <%
                    int fullStars = (int) Math.floor(averageRating);
                    boolean hasHalfStar = averageRating - fullStars >= 0.5;

                    for (int i = 1; i <= 5; i++) {
                        if (i <= fullStars) {
                    %>
                        <i class="fas fa-star" style="color: #FFD700;"></i>
                    <% } else if (i == fullStars + 1 && hasHalfStar) { %>
                        <i class="fas fa-star-half-alt" style="color: #FFD700;"></i>
                    <% } else { %>
                        <i class="far fa-star" style="color: #ccc;"></i>
                    <% }
                    }
                    %>
                    <span style="margin-left: 5px; color: #666;">
                        (<%= recentReviews.size() %> <%= recentReviews.size() == 1 ? "review" : "reviews" %>)
                    </span>
                </div>
            </div>

            <% if (recentReviews.isEmpty()) { %>
                <p>No reviews yet. Be the first to share your experience with this car!</p>
            <% } else { %>
                <div style="margin-bottom: 20px;">
                    <% for (Review review : recentReviews) { %>
                        <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 10px;">
                                <div style="font-weight: 600;"><%= review.getUserName() %></div>
                                <div style="color: #888; font-size: 0.9em;"><%= review.getFormattedDate() %></div>
                            </div>
                            <div style="margin-bottom: 10px;">
                                <% for (int i = 1; i <= 5; i++) { %>
                                    <i class="<%= i <= review.getRating() ? "fas fa-star" : "far fa-star" %>"
                                       style="color: <%= i <= review.getRating() ? "#FFD700" : "#ccc" %>;"></i>
                                <% } %>
                            </div>
                            <div style="color: #555; line-height: 1.5;">
                                <%= review.getComment().length() > 150 ? review.getComment().substring(0, 150) + "..." : review.getComment() %>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } %>

            <div style="text-align: center;">
                <a href="<%=request.getContextPath()%>/reviews/add/<%= car.getId() %>" class="btn btn-secondary">
                    <i class="fas fa-pen"></i> Write a Review
                </a>
            </div>
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