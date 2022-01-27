<%--
  Created by IntelliJ IDEA.
  User: QT-247202
  Date: 27/01/2022
  Time: 2:13 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="row">
    <h1>PRODUCT</h1>
    <div class="col-4">
        <table>
            <tr>
                <th>ID</th>
                <td>${product.getId()}</td>
            </tr>
            <tr>
                <th>Name</th>
                <td>${product.getName()}</td>
            </tr>
            <tr>
                <th>Price</th>
                <td>${product.getPrice()}</td>
            </tr>
            <tr>
                <th>Quantily</th>
                <td>${product.getQuantily()}</td>
            </tr>
            <tr>
                <th>Description</th>
                <td>${product.getDescription()}</td>
            </tr>
        </table>
    </div>
</div>
</body>
</html>
