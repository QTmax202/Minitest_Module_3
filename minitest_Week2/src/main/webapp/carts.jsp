<%--
  Created by IntelliJ IDEA.
  User: QT-247202
  Date: 27/01/2022
  Time: 2:23 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<h1>CARTS</h1>
    <div class="col-1">
        <button type="button" class="btn btn-outline-info">
            <a href="/product?action=back">Payment</a>
        </button>
    </div>
    <div class="col-11"></div>
    <div class="col-10">
        <c:if test="${requestScope['carts'].isEmpty()}">
            <h2 style="color: red">Không có sản phẩm nào</h2>
        </c:if>
        <c:if test="${requestScope['carts'].isEmpty() == false}">
            <table class="table table-success">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantily</th>
                    <th>Description</th>
                    <th></th>
                </tr>
                <c:forEach items="${requestScope['carts']}" var="carts">
                    <tr>
                        <td>${carts.getId()}</td>
                        <td>${carts.getName()}</td>
                        <td>${carts.getPrice()}</td>
                        <td>${carts.getQuantily()}</td>
                        <td>${carts.getDescription()}</td>
                        <td>
                            <button type="button" class="btn btn-outline-danger">
                                <a href="/product?action=delete&id=${products.getId()}">Delete</a>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="5"></td>
                    <td>
                        <button type="button" class="btn btn-outline-success">
                            <a href="/product?action=payment">Payment</a>
                        </button>
                    </td>
                </tr>
            </table>
        </c:if>
    </div>
    <div>
        <h2 name="payment"></h2>
    </div>
</div>
</body>
</html>
