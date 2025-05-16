<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.carsales.model.Car" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Car List</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/styles.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<h2>Car Listings</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Make</th>
        <th>Model</th>
        <th>Year</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    <% List<Car> cars = (List<Car>) request.getAttribute("cars"); %>
    <% for (Car car : cars) { %>
    <tr>
        <td><%= car.getId() %></td>
        <td><%= car.getMake() %></td>
        <td><%= car.getModel() %></td>
        <td><%= car.getYear() %></td>
        <td>$<%= String.format("%.2f", car.getPrice()) %></td>
        <td>
            <a href="<%=request.getContextPath()%>/cars/view/<%= car.getId() %>">View</a>
            <a href="<%=request.getContextPath()%>/cars/edit/<%= car.getId() %>">Edit</a>
            <a href="<%=request.getContextPath()%>/cars/delete/<%= car.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
        </td>
    </tr>
    <% } %>
</table>
<a href="<%=request.getContextPath()%>/cars/add">Add New Car</a>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>