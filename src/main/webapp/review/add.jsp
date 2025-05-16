<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
    <title>Add Review | Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .star-rating {
            margin: 15px 0;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            float: right;
            cursor: pointer;
            color: #ccc;
            font-size: 30px;
            transition: color 0.3s ease;
        }
        .star-rating label:before {
            content: '\2605';
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #FFD700;
            transition: color 0.3s ease;
        }
        .rating-info {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .rating-value {
            font-weight: 600;
            width: 30px;
            text-align: center;
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
    Integer carId = (Integer) request.getAttribute("carId");
    Car car = (Car) request.getAttribute("car");
    NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("en", "US"));
    %>

    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2>Add Review</h2>
        <a href="<%=request.getContextPath()%>/reviews/car/<%= carId %>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Reviews
        </a>
    </div>

    <% if (car != null) { %>
    <div class="car-info-box">
        <h3><%= car.getMake() + " " + car.getModel() %> (<%= car.getYear() %>)</h3>
        <p>ID: <%= car.getId() %> | Price: <%= currencyFormatter.format(car.getPrice()) %></p>
    </div>
    <% } %>

    <form action="<%=request.getContextPath()%>/reviews/add" method="post">
        <input type="hidden" name="carId" value="<%= carId %>">

        <div class="form-group">
            <label for="userName">Your Name <span style="color: red">*</span></label>
            <input type="text" id="userName" name="userName" required placeholder="Enter your name">
        </div>

        <div class="form-group">
            <label for="userEmail">Your Email <span style="color: red">*</span></label>
            <input type="email" id="userEmail" name="userEmail" required placeholder="Enter your email">
        </div>

        <div class="form-group">
            <label>Rating <span style="color: red">*</span></label>
            <div class="rating-info">
                <span>Select rating:</span>
                <span class="rating-value" id="ratingDisplay">0</span>
                <span>/5</span>
            </div>
            <div class="star-rating">
                <input type="radio" id="star5" name="rating" value="5" />
                <label for="star5" title="5 stars"></label>
                <input type="radio" id="star4" name="rating" value="4" />
                <label for="star4" title="4 stars"></label>
                <input type="radio" id="star3" name="rating" value="3" />
                <label for="star3" title="3 stars"></label>
                <input type="radio" id="star2" name="rating" value="2" />
                <label for="star2" title="2 stars"></label>
                <input type="radio" id="star1" name="rating" value="1" />
                <label for="star1" title="1 star"></label>
            </div>
        </div>

        <div class="form-group">
            <label for="comment">Review <span style="color: red">*</span></label>
            <textarea id="comment" name="comment" rows="5" required placeholder="Write your review here. What did you like or dislike about this car?"></textarea>
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 20px;">
            <a href="<%=request.getContextPath()%>/reviews/car/<%= carId %>" class="btn btn-secondary">
                <i class="fas fa-times"></i> Cancel
            </a>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-paper-plane"></i> Submit Review
            </button>
        </div>
    </form>
</div>

<%@ include file="../includes/footer.jsp" %>

<script>
    // Script to update the rating display when a star is clicked
    document.addEventListener('DOMContentLoaded', function() {
        const ratingInputs = document.querySelectorAll('.star-rating input');
        const ratingDisplay = document.getElementById('ratingDisplay');

        ratingInputs.forEach(input => {
            input.addEventListener('change', function() {
                ratingDisplay.textContent = this.value;
            });
        });
    });
</script>
</body>
</html>