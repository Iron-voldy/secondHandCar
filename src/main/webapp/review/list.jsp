<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Review" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>All Reviews | Second-Hand Car Sales Platform</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        .review-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .review-table th, .review-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
        }
        .review-table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #333;
            text-align: left;
        }
        .review-table tbody tr:hover {
            background-color: #f5f5f5;
        }
        .rating-stars {
            color: #FFD700;
        }
        .review-action {
            display: inline-block;
            margin-right: 5px;
        }
        .review-comment-preview {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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

    Review[] reviews = (Review[]) request.getAttribute("reviews");
    %>

    <h2>All Reviews</h2>

    <div>
        <% if (reviews == null || reviews.length == 0) { %>
            <div style="text-align: center; padding: 40px 0;">
                <p>No reviews found in the system.</p>
            </div>
        <% } else { %>
            <table class="review-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Car ID</th>
                        <th>User</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Review review : reviews) { %>
                        <tr>
                            <td><%= review.getId() %></td>
                            <td>
                                <a href="<%=request.getContextPath()%>/cars/view/<%= review.getCarId() %>">
                                    <%= review.getCarId() %>
                                </a>
                            </td>
                            <td>
                                <%= review.getUserName() %><br>
                                <small><%= review.getUserEmail() %></small>
                            </td>
                            <td>
                                <span class="rating-stars">
                                    <% for (int i = 0; i < review.getRating(); i++) { %>
                                        <i class="fas fa-star"></i>
                                    <% } %>
                                    <% for (int i = review.getRating(); i < 5; i++) { %>
                                        <i class="far fa-star"></i>
                                    <% } %>
                                </span>
                            </td>
                            <td>
                                <div class="review-comment-preview" title="<%= review.getComment() %>">
                                    <%= review.getComment() %>
                                </div>
                            </td>
                            <td><%= review.getFormattedDate() %></td>
                            <td>
                                <a href="<%=request.getContextPath()%>/reviews/car/<%= review.getCarId() %>" class="review-action btn btn-primary btn-sm">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="<%=request.getContextPath()%>/reviews/edit/<%= review.getId() %>" class="review-action btn btn-secondary btn-sm">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <a href="<%=request.getContextPath()%>/reviews/delete/<%= review.getId() %>"
                                   onclick="return confirm('Are you sure you want to delete this review?')"
                                   class="review-action btn btn-danger btn-sm">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
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