<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<html>
<head>
    <title>View Car</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<h2>Car Details</h2>
<% Car car = (Car) request.getAttribute("car"); %>
<p>ID: <%= car.getId() %></p>
<p>Make: <%= car.getMake() %></p>
<p>Model: <%= car.getModel() %></p>
<p>Year: <%= car.getYear() %></p>
<p>Price: $<%= String.format("%.2f", car.getPrice()) %></p>
<p>Description: <%= car.getDescription() %></p>
<h3>Images:</h3>
<% for (String image : car.getImages()) { %>
<img src="<%=request.getContextPath()%>/images/cars/<%= image %>" width="200" alt="Car Image"><br>
<% } %>
<a href="<%=request.getContextPath()%>/cars">Back to List</a>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>