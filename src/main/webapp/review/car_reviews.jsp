<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Review" %>
<%@ page import="com.carsales.model.Car" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
    <title>Car Reviews | Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .review-container {
            margin-top: 30px;
        }
        .review-box {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 20px;
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        .review-user {
            font-weight: 600;
            color: #333;
        }
        .review-date {
            color: #888;
            font-size: 0.9em;
        }
        .review-rating {
            margin-bottom: 10px;
        }
        .star-filled {
            color: #FFD700;
        }
        .star-empty {
            color: #ccc;
        }
        .review-comment {
            line-height: 1.6;
            color: #555;
        }
        .review-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }
        .review-summary {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .average-rating {
            display: flex;
            align-items: center;
        }
        .average-rating .rating-value {
            font-size: 2em;
            font-weight: 700;
            color: #333;
            margin-right: 10px;
        }
        .review-count {
            color: #666;
        }
        .add-review-btn {
            padding: 12px 24px;
            font-weight: 600;
        }
        .car-info-box {
            background-color: #f8f9fa;
            border-left: 4px solid #1e3c72;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .car-info-box h3 {
            margin-top: 0;
            color: #1e3c72;
        }
    </style>
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

    List<Review> reviews = (List<Review>) request.getAttribute("reviews");
    Double averageRating = (Double) request.getAttribute("averageRating");
    Integer carId = (Integer) request.getAttribute("carId");
    Car car = (Car) request.getAttribute("car");
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
    %>

    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2>Reviews for <%= car != null ? car.getMake() + " " + car.getModel() + " (" + car.getYear() + ")" : "Car #" + carId %></h2>
        <a href="<%=request.getContextPath()%>/cars/view/<%= carId %>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Car Details
        </a>
    </div>

    <% if (car != null) { %>
    <div class="car-info-box">
        <h3><%= car.getMake() + " " + car.getModel() %> (<%= car.getYear() %>)</h3>
        <p>ID: <%= car.getId() %> | Price: <%= currencyFormatter.format(car.getPrice()) %></p>
    </div>
    <% } %>

    <!-- Review Summary -->
    <div class="review-summary">
        <div>
            <div class="average-rating">
                <div class="rating-value"><%= String.format("%.1f", averageRating) %></div>
                <div>
                    <%
                    int fullStars = (int) Math.floor(averageRating);
                    boolean hasHalfStar = averageRating - fullStars >= 0.5;

                    for (int i = 1; i <= 5; i++) {
                        if (i <= fullStars) {
                    %>
                        <i class="fas fa-star star-filled"></i>
                    <% } else if (i == fullStars + 1 && hasHalfStar) { %>
                        <i class="fas fa-star-half-alt star-filled"></i>
                    <% } else { %>
                        <i class="far fa-star star-empty"></i>
                    <% }
                    }
                    %>
                </div>
            </div>
            <div class="review-count"><%= reviews.size() %> review<%= reviews.size() != 1 ? "s" : "" %></div>
        </div>
        <a href="<%=request.getContextPath()%>/reviews/add/<%= carId %>" class="btn btn-primary add-review-btn">
            <i class="fas fa-plus"></i> Write a Review
        </a>
    </div>

    <!-- Reviews List -->
    <div class="review-container">
        <% if (reviews == null || reviews.isEmpty()) { %>
            <div style="text-align: center; padding: 40px 0;">
                <p>No reviews yet. Be the first to review this car!</p>
            </div>
        <% } else {
            for (Review review : reviews) {
        %>
            <div class="review-box">
                <div class="review-header">
                    <div>
                        <div class="review-user"><%= review.getUserName() %></div>
                        <div class="review-date"><%= review.getFormattedDate() %></div>
                    </div>
                    <div class="review-actions">
                        <a href="<%=request.getContextPath()%>/reviews/edit/<%= review.getId() %>" class="btn btn-secondary btn-sm">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="<%=request.getContextPath()%>/reviews/delete/<%= review.getId() %>"
                           onclick="return confirm('Are you sure you want to delete this review?')"
                           class="btn btn-danger btn-sm">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                    </div>
                </div>
                <div class="review-rating">
                    <% for (int i = 1; i <= 5; i++) { %>
                        <i class="<%= i <= review.getRating() ? "fas fa-star star-filled" : "far fa-star star-empty" %>"></i>
                    <% } %>
                </div>
                <div class="review-comment">
                    <%= review.getComment() %>
                </div>
            </div>
        <%
            }
        }
        %>
    </div>
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