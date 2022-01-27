<%--
  Created by IntelliJ IDEA.
  User: QT-247202
  Date: 27/01/2022
  Time: 1:34 CH
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
    <div><h1>All products</h1></div>
    <div class="col-6">
        <button type="button" class="btn btn-outline-secondary"><a
                href="${pageContext.request.contextPath}/product?action=sortasc">SORT ASC</a></button>
        <button type="button" class="btn btn-outline-secondary"><a
                href="${pageContext.request.contextPath}/product?action=sortdesc">SORT DESC</a></button>
    </div>
    <div class="col-2"></div>
    <div class="col-4">
        <button type="button" class="btn btn-outline-info">
            <a href="/product?action=detailCart">CART</a>
        </button>
    </div>
    <div class="col-10">
        <c:if test="${requestScope['products'].isEmpty()}">
            <h2 style="color: red">Không có sản phẩm nào</h2>
        </c:if>
        <c:if test="${requestScope['products'].isEmpty() == false}">
            <table class="table table-success">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantily</th>
                    <th>Description</th>
                    <th></th>
                </tr>
                <c:forEach items="${requestScope['products']}" var="products">
                    <tr>
                        <td>${products.getId()}</td>
                        <td>
                            <a id="name" style="text-decoration: none"
                               href="/product?action=detail&id=${products.getId()}">${products.getName()}</a>
                        </td>
                        <td>${products.getPrice()}</td>
                        <td <c:if test="${products.getQuantily() == 0}">
                            style="color: red"
                        </c:if>>
                                ${products.getQuantily()}
                        </td>
                        <td>${products.getDescription()}</td>
                        <td>
                            <c:if test="${products.getQuantily() > 0}">
                                <button type="button" class="btn btn-outline-success">
                                    <a href="/product?action=addProduct&id=${products.getId()}">Add Cart</a>
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
    </div>
</div>
</body>
</html>

