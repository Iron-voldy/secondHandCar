<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<html>
<head>
    <title>Edit Car</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<h2>Edit Car</h2>
<% Car car = (Car) request.getAttribute("car"); %>
<form action="<%=request.getContextPath()%>/cars/edit/<%= car.getId() %>" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= car.getId() %>">
    Make: <input type="text" name="make" value="<%= car.getMake() %>" required><br>
    Model: <input type="text" name="model" value="<%= car.getModel() %>" required><br>
    Year: <input type="number" name="year" value="<%= car.getYear() %>" required><br>
    Price: <input type="number" step="0.01" name="price" value="<%= car.getPrice() %>" required><br>
    Description: <textarea name="description"><%= car.getDescription() %></textarea><br>
    Images: <input type="file" name="images" multiple accept="image/*"><br>
    <input type="submit" value="Update Car">
</form>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>