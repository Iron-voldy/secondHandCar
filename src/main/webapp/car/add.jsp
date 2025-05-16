<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Car</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
<%@ include file="../includes/header.jsp" %>
<h2>Add New Car</h2>
<form action="${pageContext.request.contextPath}/cars/add" method="post" enctype="multipart/form-data">
    Make: <input type="text" name="make" required><br>
    Model: <input type="text" name="model" required><br>
    Year: <input type="number" name="year" required><br>
    Price: <input type="number" step="0.01" name="price" required><br>
    Description: <textarea name="description"></textarea><br>
    Images: <input type="file" name="images" multiple accept="image/*"><br>
    <input type="submit" value="Add Car">
</form>
<%@ include file="../includes/footer.jsp" %>
</body>
</html>